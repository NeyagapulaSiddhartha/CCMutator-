#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "FenceVisitor.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

// Command-line options
static cl::opt<bool> rmMode("rm", 
    cl::desc("Remove occurrences of fence instructions"),
    cl::init(false));

static cl::opt<bool> modMode("mod", 
    cl::desc("Modify atomic ordering, specify type with -order"),
    cl::init(false));

static cl::opt<bool> scopeMode("scope", 
    cl::desc("Toggle the scope of the fence from singlethreaded to multithreaded"),
    cl::init(false));

static cl::list<unsigned> orderings("order",
    cl::desc("Ordering values to use with mod: 0=acquire, 1=release, 2=acq_rel, 3=seq_cst"),
    cl::CommaSeparated);

static cl::list<unsigned> positions("pos", 
    cl::desc("Occurrences to remove or modify"),
    cl::CommaSeparated);

static cl::opt<bool> verbose("verbose", 
    cl::desc("Enable verbose output"),
    cl::init(false));

namespace {
struct Fence : public PassInfoMixin<Fence> {
public:
    // Main run method for the pass
    static char ID;

    FenceVisitor fenceInsts;
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
        bool modified = false;

        checkCommandLineArgs();
        errs()<<"enter the dragon \n";
       
        fenceInsts.visit(M);
        // // Visit and process all fence instructions in the module
        // SmallVector<FenceInst*, 8> fenceInsts;
        // for (Function &F : M) {
        //     for (BasicBlock &BB : F) {
        //         for (Instruction &I : BB) {
        //             if (auto *FI = dyn_cast<FenceInst>(&I)) {
        //                 fenceInsts.push_back(FI);
        //             }
        //         }
        //     }
        // }

        if (rmMode) {
            removeInstructions();
            modified = true;
        } else if (modMode) {
            modifyInstructions();
            modified = true;
        } else if (scopeMode) {
            toggleScope();
            modified = true;
        }

        if (modified) {
            return PreservedAnalyses::none();
        } else {
            return PreservedAnalyses::all();
        }
    }



       void toggleScope() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex;
            FenceInst *curInst;

            curIndex = positions[i];
            if (indexOutOfBounds(curIndex)) {
                errs() << "Warning: index " << curIndex << " is out of bounds, skipping\n";
                continue;
            }

            curInst = fenceInsts.getInst(curIndex); // non NULL since position is in bounds

            if (curInst->getSyncScopeID() == SyncScope::SingleThread) {
                curInst->setSyncScopeID(SyncScope::System);
            } else {
                curInst->setSyncScopeID(SyncScope::SingleThread);
            }
        }
    }

    // Remove fence instructions
    void removeInstructions() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex;
            FenceInst *curInst;

            curIndex = positions[i];
            if (indexOutOfBounds(curIndex)) {
                errs() << "Warning: index " << curIndex << " is out of bounds, skipping\n";
                continue;
            }

            curInst = fenceInsts.getInst(curIndex); // non NULL since position is in bounds
            curInst->eraseFromParent();
        }
    }

    void modifyInstructions() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex;
            AtomicOrdering aorder;
            FenceInst *curInst;

            curIndex = positions[i];
            if (indexOutOfBounds(curIndex)) {
                errs() << "Warning: index " << curIndex << " is out of bounds, skipping\n";
                continue;
            }

            curInst = fenceInsts.getInst(curIndex); // non NULL since position is in bounds

            aorder = getOrdering(curIndex);

            curInst->setOrdering(aorder);
        }
    }

    // Check for command-line argument validity
    void checkCommandLineArgs() {
        if (rmMode && modMode) {
            errs() << "Error: -rm and -mod specified\n";
            exit(EXIT_FAILURE);
        }
        if (rmMode && scopeMode) {
            errs() << "Error: -rm and -scope specified\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && scopeMode) {
            errs() << "Error: -mod and -scope specified\n";
            exit(EXIT_FAILURE);
        }
        if (rmMode && positions.empty()) {
            errs() << "Error: -rm but no positions specified\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && positions.empty()) {
            errs() << "Error: -mod but no positions specified\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && orderings.empty()) {
            errs() << "Error: -mod but no orderings specified\n";
            exit(EXIT_FAILURE);
        }
    }

    // Helper to get atomic ordering
    AtomicOrdering getOrdering(unsigned index) {
        if (index < orderings.size()) {
            return unsignedToOrdering(orderings[index]);
        }
        return unsignedToOrdering(*orderings.end());
    }

    // Helper to map unsigned values to AtomicOrdering
    AtomicOrdering unsignedToOrdering(unsigned val) {
        switch (val) {
            case 0: return AtomicOrdering::Acquire;
            case 1: return AtomicOrdering::Release;
            case 2: return AtomicOrdering::AcquireRelease;
            case 3: return AtomicOrdering::SequentiallyConsistent;
            default: return AtomicOrdering::Acquire;
        }
    }

    // Check if an index is out of bounds
    bool indexOutOfBounds(unsigned index) {
        if (fenceInsts.getSize() < index) {
            return true;
        }
        return false;
    }
};
} // namespace

// Pass registration for the new PassManager
llvm::PassPluginLibraryInfo getFencePassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "Fence", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                PB.registerPipelineParsingCallback(
                    [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>) {
                        if (Name == "Fence") {
                            MPM.addPass(Fence());
                            return true;
                        }
                        return false;
                    });
            }};
}

// Exports the pass plugin
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm:: PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getFencePassPluginInfo();
}
