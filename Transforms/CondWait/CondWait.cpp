/**
 * \file CondWait.cpp
 * \author Markus Kusano
 * \date 2013-02-28
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 *
 * Implementation of a mutator that works on cond_wait() and
 * cond_timed_wait()
 *
 * See README.md for more details
 */
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/ValueSymbolTable.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "EnumerateCallInst.h"

#define MUT_DEBUG

/// The location in timespec structure of the field tv_sec. This is included
 /// because POSIX does not make guaranetees where in the strucutre the element
/// is but only that it is in there somewhere.
static int tv_sec_loc = 0;

/// The location in timespec structure of the field tv_nsec. This is included
/// because POSIX does not make guaranetees where in the strucutre the element
/// is but only that it is in there somewhere.
static int tv_nsec_loc = 1;


using namespace llvm;

/// Command line option: specify if we should remove occurrences specified with
/// -pos. Defaults to false. \sa MutatePos
static cl::opt<bool> rmMode("rm", 
	cl::desc("remove occurrences specified by -pos"),
	cl::init(false));

/// Command line option: specify if we should modify occurrences specified with
/// -pos. Defaults to false. This allows for the wait time to be set to a
/// certain value. If the instruction is a call to pthread_cond_wait it is
/// replaced with a call to pthread_cond_timed_wait with the given time value.
/// Speicfy the value with -val. If no value is specified, a random one is
/// used.
///
/// \sa MutatePos 
/// \sa ModVal
static cl::opt<bool> TimeMod("tmod", 
	cl::desc("modify wait value of occurrences specified by -val"),
	cl::init(false));

/// Command line option: Comma separated list of positions to mutate. The list
/// is zero indexted (the first position is zero). \sa rmMode.
/// Note: -pos 0 -pos 3 is equivalent to -pos=0,3
static cl::list<unsigned> MutatePos("pos",
	cl::desc("occurances to mutate"),
	cl::value_desc("comma separated list of occurances to mutate"),
	cl::CommaSeparated);

/// Command line option: Comma separated list of values to be used when
/// mutating the time wait tv_nsec value. The 0th position in this list will be
/// the value used for the 0th instruction specified by -pos. If this list is
/// shorter than -pos then the last value in the list will be used for the
/// remaining positions to modify.
static cl::list<int> NsecModVal("nsecval",
	cl::desc("modify values"),
	cl::value_desc("comma separated list of values to use"),
	cl::CommaSeparated);

/// Command line option: Comma separated list of values to be used when
/// mutating the time wait tv_sec value. The 0th position in this list will be
/// the value used for the 0th instruction specified by -pos. If this list is
/// shorter than -pos then the last value in the list will be used for the
/// remaining positions to modify.
static cl::list<int> SecModVal("secval",
	cl::desc("modify values"),
	cl::value_desc("comma separated list of values to use"),
	cl::CommaSeparated);

/// Command line option: Comma separated list of values to be specify the
/// instruction relative to the call to the start of the function containing
/// the call to pthread_cond_timedwait that is being modified. All mutation
/// code is inserted before the specified instruction. If this list is shorter
/// than -pos then the last value in the list will be used for the remaining
/// position to modify.
static cl::list<unsigned> InsertPoint("inspt",
	cl::desc("relative point to insert mutation code"),
	cl::value_desc("comma separated list of ints"),
	cl::CommaSeparated);

/// Command line option: Verbose output boolean. Default to false. This option
/// makes sense in the default find mode (ie, when -rm is not specified).
/// Enabling this causes output to be the filename and line number of each
/// occurrence found in the form `<filename>\t<linenumber>` This requires that
/// debug metadata to exist in the LLVM bitcode (use `-g` to clang). Defaults
/// to false. 
///
/// \sa rmMode
static cl::opt<bool> verbose("verbose",
	cl::desc("enable verbose output, displays filename/linenumber info"),
	cl::init(false));

/// Command line option: Tells the pass to switch calls specified with -pos
/// from timedwait to wait. The converse (wait to timedwait) is not implemented
/// yet.
static cl::opt<bool> switchMode("switch",
	cl::desc("switch calls to timedwait to wait"),
	cl::init(false));

/// Command line option: The pass will mutate POSIX condition variable calls.
static cl::opt<bool> posix("posix",
	cl::desc("mutates posix condition calls"),
	cl::init(false));

static cl::opt<bool> cpp11("cpp",
	cl::desc("mutates C++11 condition calls"),
	cl::init(false));

/// Verifies command line arguments are valid
void checkCommandLineArgs();

/// Obtains the next second mutate and nsec mutate values from the nsecval and
/// secval lists.
/// \param secVal next second mutation value (returned)
/// \param nsecVal next nano second mutation value (returned)
/// \param timedWait the call to pthread_cond_timedwait
/// \param pos next position being mutated
/// \return Instruction of the next insertion point
Instruction *getNextMutateVals(int &secVal, int &nsecVal, CallInst *timedWait, unsigned pos);

/// Returns an instruction poitner that corresponds to the val'th instruction
/// in the passed function. 
/// \param F function to iterate over
/// \param val number of times to move the inst_iterator
/// \return Instruction* 
Instruction *getInstFromFunction(Function *F, unsigned val);

void checkCommandLineArgs() {
    if (!posix && !cpp11) {
        errs() << "Error: atleast posix or cpp must be specified\n";
        exit(EXIT_FAILURE);
    }
    // Both verbose and rm should not be specified together
    if (verbose && rmMode) {
	errs() << "Error: both verbose and rm cannot be specified together\n";
	exit(EXIT_FAILURE);
    }

    // Modify and remove mode should not be specified together
    if (TimeMod && rmMode) {
	errs () << "Error: both -rm and -tmod cannot be specified together\n";
	exit(EXIT_FAILURE);
    }

    if (TimeMod && switchMode) {
	errs() << "Error: both -tmod and -swtich cannot be specified together\n";
	exit(EXIT_FAILURE);
    }

    if (rmMode && switchMode) {
	errs() << "Error: both -rm and -switch cannot be specified together\n";
	exit(EXIT_FAILURE);
    }

    // Check if the size of positions specified is zero and we are in rmMode.
    // This does not make sense since it would be a no-op
    if (rmMode && MutatePos.size() == 0) {
	errs() << "Error: In rmMode with no positions specified to mutate\n";
	exit(EXIT_FAILURE);
    }

    if (switchMode && MutatePos.size() == 0) {
	errs() << "Error: -switch set but no positions specified (see -pos)\n";
	exit(EXIT_FAILURE);
    }

    // Check if the size of positions specified is zero and we are in time
    // mutate mode.  This does not make sense since it would be a no-op
    if (TimeMod && MutatePos.size() == 0) {
	errs() << "Error: In time mutate mode with no positions specified to mutate\n";
	exit(EXIT_FAILURE);
    }

    if (TimeMod && SecModVal.size() == 0) {
	errs() << "Error: In time mutate mode with no second values specified\n";
	exit(EXIT_FAILURE);
    }

    if (TimeMod && NsecModVal.size() == 0) {
	errs() << "Error: In time mutate mode with no nano second values specified\n";
	exit(EXIT_FAILURE);
    }

    if (switchMode && SecModVal.size() != 0) {
	errs() << "Error: -switch does not use -secval\n";
	exit(EXIT_FAILURE);
    }
    if (switchMode && NsecModVal.size() != 0) {
	errs() << "Error: -switch does not use -nsecval\n";
	exit(EXIT_FAILURE);
    }
}

Instruction *getInstFromFunction(Function *F, unsigned val) {
    inst_iterator I = inst_begin(F);
    inst_iterator end = inst_end(F);

    for (unsigned i = 0; (I != end) && (i != val); ++I, ++i) {
	// Empty body
    }

    return &(*I);
}

Instruction *getNextMutateVals(int &secVal, int &nsecVal, Instruction *timedWait, unsigned pos) {
    Instruction *insPoint = timedWait; // default return value

    if (pos >= NsecModVal.size()) {
#ifdef MUT_DEBUG
	errs() << "DEBUG: NsecModVal list shorter than pos list, using last value\n";
#endif
	nsecVal = NsecModVal[NsecModVal.size() -1];
    }
    else {
	nsecVal = NsecModVal[pos];
    }

    if (pos >= SecModVal.size()) {
#ifdef MUT_DEBUG
	errs() << "DEBUG: SecModVal list shorter than pos list, using last value\n";
#endif
	secVal = SecModVal[NsecModVal.size() -1];
    }
    else {
	secVal = SecModVal[pos];
    }

    if (pos >= InsertPoint.size()) {
	if (InsertPoint.size() != 0) {
	    // use the last value for the remaining positions
	    insPoint = getInstFromFunction(timedWait->getParent()->getParent(), 
		    InsertPoint[InsertPoint.size() - 1]);
	}
	// if InsertPoint.size() == 0 then leave insPoint unmodified
    }
    else {
	insPoint = getInstFromFunction(timedWait->getParent()->getParent(),
	    InsertPoint[pos]);
    }

#ifdef MUT_DEBUG
    errs() << "DEBUG: mutation values for pos " << pos << '\n'
	   << "\tsecVal == " << secVal << '\n'
	   << "\tnsecVal == " << nsecVal << '\n'
	   << "\tinsPt == " << *insPoint << '\n';
#endif

    return insPoint;
}
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Type.h"

using namespace llvm;

namespace {

struct CondWait : public PassInfoMixin<CondWait> {

    static char ID;

    CondWait() = default;
    EnumerateCallInst eci;

    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
        checkCommandLineArgs();
        bool modified = false;

        // Enumerate instances of call instructions to mutate
        if (posix) {
            eci.addFuncNameToSearch("pthread_cond_wait");
            eci.addFuncNameToSearch("pthread_cond_timedwait");
        }
        if (cpp11) {
            eci.addFuncNameToSearch("std::__1::condition_variable::wait");
            eci.addFuncNameToSearch("std::__1::condition_variable::wait_for");
            eci.addFuncNameToSearch("std::__1::condition_variable::wait_until");
            eci.searchCpp();
        }

        eci.visit(M);

        if (!rmMode && !TimeMod && !switchMode) {
            modified = false; // implicit print mode
        } else if (rmMode) {
            for (unsigned i = 0; i < MutatePos.size(); i++) {
                int ret = eci.removeFromParentRepZero(MutatePos[i], sizeof(int), true);
#ifdef MUT_DEBUG
                errs() << "DEBUG: remove from parent returned: " << ret << '\n';
#endif
                if (ret == -1) {
                    errs() << "Warning: position " << MutatePos[i] << " is out of "
                           << "bounds of found instructions, ignoring\n";
                } else if (ret == -2) {
                    errs() << "Warning: position " << MutatePos[i] << " has been "
                           << "removed already. Skipping\n";
                } else {
                    modified = true;
                }
            }
        } else if (TimeMod) {
#ifdef MUT_DEBUG
            errs() << "DEBUG: in modify mode\n";
#endif

            for (unsigned i = 0; i < MutatePos.size(); i++) {
                unsigned posToMod = MutatePos[i];
                bool isCallInst;
                int error;
                int secMod;
                int nsecMod;
                Instruction *curInst;
                Instruction *insPoint;

                curInst = eci.getInstructionAt(posToMod, &isCallInst, &error);
                if (error == -1) {
                    errs() << "Warning: position " << posToMod << " is out of bounds, skipping\n";
                    continue;
                } else if (error == -2) {
                    errs() << "Warning: position " << posToMod << " has already been mutated, skipping\n";
                    continue;
                }

                insPoint = getNextMutateVals(secMod, nsecMod, curInst, MutatePos[i]);

                if (isCallInst) {
                    CallInst *curCall = cast<CallInst>(curInst);
                    if (curCall->getCalledFunction()->getName() == "pthread_cond_timedwait") {
                        // LLVMContext c;
                        StructType *timespecType = llvm::StructType::getTypeByName(M.getContext(),"struct.timespec");
                        if (!timespecType) {
                            errs() << "Warning: unable to find definition of type "
                                  "struct.timespec, skipping modification\n";
                            continue;
                        }

                        IRBuilder<> builder(insPoint);
                        Value *timespecStruct;

                        if (curCall->getNumOperands() < 3) {
                            errs() << "Warning: found pthread_cond_timedwait() call "
                                  "with less than 3 arguments, skipping\n";
                            continue;
                        }

                        timespecStruct = curCall->getArgOperand(2);

                        Value *tvSecPtr = builder.CreateConstGEP2_32(timespecStruct->getType(),timespecStruct,  0, tv_sec_loc, "tv_sec_mut");
                        Value *tvNsecPtr = builder.CreateConstGEP2_32(timespecStruct->getType(),timespecStruct,  0, tv_nsec_loc, "tv_nsec_mut");
                        Value *tvSecVal = builder.CreateLoad(tvSecPtr->getType(),tvSecPtr, "tvSecVal_mut");
                        Value *tvNsecVal = builder.CreateLoad(tvNsecPtr->getType(), tvNsecPtr,"tvNsecVal_mut");

                        if (timespecType->getNumElements() < 2) {
                            errs() << "Warning: found struct.timespec type with "
                                  "less than 2 elements, skipping modification\n";
                            continue;
                        }

                        Value *secModVal = ConstantInt::get(timespecType->getElementType(tv_sec_loc), secMod);
                        Value *nsecModVal = ConstantInt::get(timespecType->getElementType(tv_nsec_loc), nsecMod);

                        Value *secAddRes = builder.CreateAdd(tvSecVal, secModVal, "sec_mod_val");
                        Value *nsecAddRes = builder.CreateAdd(tvNsecVal, nsecModVal, "nsec_mod_val");

                        builder.CreateStore(secAddRes, tvSecPtr);
                        builder.CreateStore(nsecAddRes, tvNsecPtr);
                    } else {
                        errs() << "Warning: attempting to mutate the timespec value "
                              "of a call other than pthread_cond_timedwait(), skipping\n";
                    }
                } else {
                    InvokeInst *curInvoke = cast<InvokeInst>(curInst);
                    if (curInvoke->getCalledFunction()->getName() == "pthread_cond_timedwait") {
                        // StructType *timespecType = M.getTypeByName("struct.timespec");
                        //LLVMContext c;
                        StructType *timespecType = llvm::StructType::getTypeByName(M.getContext(),"struct.timespec");
                        if (!timespecType) {
                            errs() << "Warning: unable to find definition of type "
                                  "struct.timespec, skipping modification\n";
                            continue;
                        }

                        IRBuilder<> builder(insPoint);
                        Value *timespecStruct;

                        if (curInvoke->getNumOperands() < 3) {
                            errs() << "Warning: found pthread_cond_timedwait() call "
                                  "with less than 3 arguments, skipping\n";
                            continue;
                        }

                        timespecStruct = curInvoke->getArgOperand(2);

                        Value *tvSecPtr = builder.CreateConstGEP2_32(timespecStruct->getType(),timespecStruct, 0, tv_sec_loc, "tv_sec_mut");
                        Value *tvNsecPtr = builder.CreateConstGEP2_32(timespecStruct->getType(),timespecStruct, 0, tv_nsec_loc, "tv_nsec_mut");
                        Value *tvSecVal = builder.CreateLoad(tvSecPtr->getType(),tvSecPtr, "tvSecVal_mut");
                        Value *tvNsecVal = builder.CreateLoad(tvNsecPtr->getType(),tvNsecPtr, "tvNsecVal_mut");

                        if (timespecType->getNumElements() < 2) {
                            errs() << "Warning: found struct.timespec type with "
                                  "less than 2 elements, skipping modification\n";
                            continue;
                        }

                        Value *secModVal = ConstantInt::get(timespecType->getElementType(tv_sec_loc), secMod);
                        Value *nsecModVal = ConstantInt::get(timespecType->getElementType(tv_nsec_loc), nsecMod);

                        Value *secAddRes = builder.CreateAdd(tvSecVal, secModVal, "sec_mod_val");
                        Value *nsecAddRes = builder.CreateAdd(tvNsecVal, nsecModVal, "nsec_mod_val");

                        builder.CreateStore(secAddRes, tvSecPtr);
                        builder.CreateStore(nsecAddRes, tvNsecPtr);
                    } else {
                        errs() << "Warning: attempting to mutate the timespec value "
                              "of a call other than pthread_cond_timedwait(), skipping\n";
                    }
                }
            }
            modified = true;
        } else if (switchMode) {
#ifdef MUT_DEBUG
            errs() << "DEBUG: in switch mode\n";
#endif
            for (unsigned i = 0; i < MutatePos.size(); i++) {
                unsigned posToMod = MutatePos[i];
                int error;
                bool isCallInst;
                Instruction *curInst;

                curInst = eci.getInstructionAt(posToMod, &isCallInst, &error);
                if (error == -1) {
                    errs() << "Warning: position " << posToMod << " is out of bounds, skipping\n";
                    continue;
                } else if (error == -2) {
                    errs() << "Warning: position " << posToMod << " has already been mutated, skipping\n";
                    continue;
                }

                if (isCallInst) {
                    CallInst *curCall = cast<CallInst>(curInst);
                    Function *curFunc = curCall->getCalledFunction();

                    if (!curFunc) {
                        errs() << "Warning: indirect function call found, skipping\n";
                        continue;
                    }

                    if (curFunc->getName() == "pthread_cond_wait") {
                        errs() << "Warning: switching pthread_cond_wait to pthread_cond_timedwait "
                              "is not supported, skipping\n";
                        continue;
                    }

                    if (curCall->getNumOperands() != 3) {
                        errs() << "Warning: found call to pthread_cond_timedwait that "
                              "does not have 3 operands, skipping\n";
                        continue;
                    }

                    if (curFunc->getName() != "pthread_cond_timedwait") {
                        errs() << "Warning: switch only supported for pthread_cond_timedwait()\n";
                        continue;
                    }

                    Value *args[2];
                    args[0] = curCall->getArgOperand(0);
                    args[1] = curCall->getArgOperand(1);

                    FunctionCallee pthreadCondWait = M.getOrInsertFunction("pthread_cond_wait", 
                        IntegerType::get(M.getContext(), 32), // return type
                        args[0]->getType(), // param 0
                        args[1]->getType()  // param 1
                    );

                    CallInst *newCall = CallInst::Create(pthreadCondWait, args, "mut_timedWait", curCall);
                    curCall->replaceAllUsesWith(newCall);
                    curCall->eraseFromParent();

                    modified = true;
                } else {
                    InvokeInst *curInvoke = cast<InvokeInst>(curInst);
                    Function *curFunc = curInvoke->getCalledFunction();
                    if (!curFunc) {
                        errs() << "Warning: indirect function call found, skipping\n";
                        continue;
                    }

                    if (curFunc->getName() == "pthread_cond_wait") {
                        errs() << "Warning: switching pthread_cond_wait to pthread_cond_timedwait "
                              "is not supported, skipping\n";
                        continue;
                    }

                    if (curInvoke->getNumOperands() != 3) {
                        errs() << "Warning: found call to pthread_cond_timedwait that "
                              "does not have 3 operands, skipping\n";
                        continue;
                    }

                    if (curFunc->getName() != "pthread_cond_timedwait") {
                        errs() << "Warning: switch only supported for pthread_cond_timedwait()\n";
                        continue;
                    }

                    Value *args[2];
                    args[0] = curInvoke->getArgOperand(0);
                    args[1] = curInvoke->getArgOperand(1);

                    FunctionCallee pthreadCondWait = M.getOrInsertFunction("pthread_cond_wait", 
                        IntegerType::get(M.getContext(), 32), // return type
                        args[0]->getType(), // param 0
                        args[1]->getType()  // param 1
                    );

                    CallInst *newCall = CallInst::Create(pthreadCondWait, args, "mut_timedWait", curInvoke);
                    curInvoke->replaceAllUsesWith(newCall);
                    curInvoke->eraseFromParent();

                    modified = true;
                }
            }
        }

        return llvm::PreservedAnalyses::none();
    }

    void print(raw_ostream &O, const Module *M) const {
        if (!verbose) {
            errs() << eci.callInsts.size() + eci.invokeInsts.size() << '\n';
        } else {
            eci.printInstDebugInfo();
        }
    }
};



} // namespace

// Register the pass
llvm::PassPluginLibraryInfo getStdMutexPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "CondWait", LLVM_VERSION_STRING, [](llvm::PassBuilder &PB) {
        PB.registerPipelineParsingCallback([](llvm::StringRef Name, llvm::ModulePassManager &MPM, llvm::ArrayRef<llvm::PassBuilder::PipelineElement>) {
            if (Name == "CondWait") {
                MPM.addPass(CondWait());
                return true;
            }
            return false;
        });
    }};
}

// This is required to be loaded by the `opt` tool.
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getStdMutexPluginInfo();
}