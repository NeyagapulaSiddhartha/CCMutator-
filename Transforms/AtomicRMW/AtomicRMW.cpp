/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \author: Markus Kusano
 * \date: 2013-06-02
 *
 * \file Store.cpp
 *
 * Mutation pass for Store instructions
 */

#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "AtomicRMWVisitor.h"
// #include "/Tools/FileInfo.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

using namespace llvm;

// Enable Debugging Output
//#define MUT_DEBUG

static cl::list<unsigned> positions("pos", 
    cl::desc("occurrences to remove or modify"),
    cl::value_desc("comma separated list of unsigned ints"),
    cl::CommaSeparated);


static cl::opt<bool> verbose("verbose", 
        cl::desc("enable verbose output\n"),
        cl::init(false));

// To be used in the future to support non-atomic to atomic load mutation
static cl::opt<bool> onlyAtomic("onlyatomic", 
        cl::desc("only enumerate and mutate atomic loads"),
        cl::Hidden,
        cl::init(true));

static cl::opt<bool> modMode("mod", 
        cl::desc("change atomic ordering of load instruction, use -order to specify ordering"),
        cl::init(false));

static cl::list<unsigned> orderings("order",
        cl::desc("atomic ordering values for each position found in -pos"),
        cl::value_desc("comma separated list of unsigned ints. 0 = monotonic, "
                       "1 = acquire, 2 = release, 3 = acquire release, 4 = sequentially consistent"),
        cl::CommaSeparated);

static cl::opt<bool> scope("scope", 
        cl::desc("change synchronization scope from single-threaded to multi-threaded and vice-versa"),
        cl::init(false));

namespace {
struct AtomicRMW : public PassInfoMixin<AtomicRMW> {

    AtomicRMWVisitor atomicRMWInsts;


        void checkCommandLineArgs() const {

        llvm::errs()<<"enterrn the fun checkCommandLineArgs \n";
        if (modMode && positions.empty()) {
            errs() << "Error: -mod but no positions specified with -pos\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && orderings.empty()) {
            errs() << "Error: -mod but no orderings specified with -order\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && scope) {
            errs() << "Error: -mod and -scope cannot both be specified\n";
            exit(EXIT_FAILURE);
        }
        if (scope && positions.empty()) {
            errs() << "Error: -scope but no positions specified with -pos\n";
            exit(EXIT_FAILURE);
        }

        for (unsigned i = 0; i < orderings.size(); i++) {
            if (orderings[i] > 4) {
                errs() << "Error: ordering value at index " << i << " is too large\n";
                exit(EXIT_FAILURE);
            }
        }
    }



    bool indexOutOfBounds(unsigned index) const {
        return atomicRMWInsts.getSize() <= index;
    }

    void toggleScope() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex = positions[i];
            if (!indexOutOfBounds(curIndex)) {
                AtomicRMWInst *curInst = atomicRMWInsts.getInst(curIndex);
                if (curInst->getSyncScopeID() == SyncScope::System)
                    curInst->setSyncScopeID(SyncScope::SingleThread);
                else
                    curInst->setSyncScopeID(SyncScope::System);
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }

    void modifyInstructions() {

        errs()<<"enterring the modiufyu instructions\n";
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex = positions[i];
            if (!indexOutOfBounds(curIndex)) {
                AtomicRMWInst *curInst = atomicRMWInsts.getInst(curIndex);
                AtomicOrdering aorder = getOrdering(curIndex);
                curInst->setOrdering(aorder);
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }

AtomicOrdering getOrdering(unsigned index) const {
    if (index < orderings.size()) {
        return unsignedToOrdering(orderings[index]);
    } else {
        if (!orderings.empty()) {
            auto last = orderings.end();
            --last; // Move iterator to the last element
            return unsignedToOrdering(*last);
        } else {
            errs() << "Error: -order list is empty\n";
            exit(EXIT_FAILURE);
        }
    }
}


    AtomicOrdering unsignedToOrdering(unsigned val) const {
        switch (val) {
            case 0: return AtomicOrdering::Monotonic;
            case 1: return AtomicOrdering::Acquire;
            case 2: return AtomicOrdering::Release;
            case 3: return AtomicOrdering::AcquireRelease;
            case 4: return AtomicOrdering::SequentiallyConsistent;
            default: return AtomicOrdering::Unordered;
        }
    }
    
    void outOfBoundsWarning(unsigned curIndex) const {
        errs() << "Warning: position " << curIndex << " is out-of-bounds "
               << "of found instructions, skipping\n";
    }
    unsigned int getDebugLineNum( AtomicRMWInst  * i) const
    {

        return 5;
    }

    std::string getDebugFilename( AtomicRMWInst  *I) const {

        return "siddu";
    }
    void print(raw_ostream &O, const Module *M) const {
        if (!verbose) {
            errs() << atomicRMWInsts.getSize() << '\n';
        } else {
            for (unsigned i = 0; i < atomicRMWInsts.getSize(); i++) {
                StringRef filename = getDebugFilename(atomicRMWInsts.getInst(i));
                unsigned linenum = getDebugLineNum(atomicRMWInsts.getInst(i));
                errs() << i << '\t' << filename << ':' << linenum << "\n\t";
                errs() << *(atomicRMWInsts.getInst(i)) << '\n';
            }
        }
    }

        PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
        bool modified = false; 
    
        checkCommandLineArgs();
        llvm::errs()<<"the pass is working go to the other methods and check\n";
        atomicRMWInsts.visit(M);
        //atomicRMWInsts.visit(M);

        if (modMode) {
            errs()<<"the got mod \n";
            modifyInstructions();
            modified = true;
        } else if (scope) {
                        errs()<<"the  got scope \n";

            toggleScope();
            modified = true;
        }
          //errs()<<"the  got nothing \n";
#ifdef MUT_DEBUG
        errs() << "[DEBUG] exiting runOnModule\n";
#endif
        return modified ? PreservedAnalyses::none() : PreservedAnalyses::all();
    }


};

} // end anonymous namespace

llvm::PassPluginLibraryInfo getAtomicRMWPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "AtomicRMW", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                PB.registerPipelineParsingCallback(
                    [](StringRef Name, ModulePassManager &MPM,
                       ArrayRef<PassBuilder::PipelineElement>) {
                        if (Name == "AtomicRMW") {
                            MPM.addPass(AtomicRMW());
                            return true;
                        }
                        return false;
                    });
            }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getAtomicRMWPluginInfo();
}
