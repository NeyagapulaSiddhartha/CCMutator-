/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \author Markus Kusano
 * \date 2013-06-02
 *
 * \file Load.cpp
 *
 * Mutation pass for load instructions
 */
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "LoadVisitor.h"
#include "FileInfo.h"

using namespace llvm;

// Enable Debugging Output
//#define MUT_DEBUG

static cl::list<unsigned> positions("pos", 
    cl::desc("Occurrences to remove or modify"),
    cl::value_desc("Comma separated list of unsigned ints"),
    cl::CommaSeparated);

static cl::opt<bool> verbose("verbose", 
    cl::desc("Enable verbose output\n"),
    cl::init(false));

// To be used in the future to support non-atomic to atomic load mutation
static cl::opt<bool> onlyAtomic("onlyatomic", 
    cl::desc("Only enumerate and mutate atomic loads"),
    cl::Hidden,
    cl::init(true));

static cl::opt<bool> toggle("toggle", 
    cl::desc("Switch non-atomic load to atomic and vice versa"),
    cl::init(false));

static cl::opt<bool> modMode("mod", 
    cl::desc("Change atomic ordering of load instruction, use -order to specify ordering"),
    cl::init(false));

static cl::list<unsigned> orderings("order",
    cl::desc("Atomic ordering values for each position found in -pos"),
    cl::value_desc("Comma separated list of unsigned ints. 0 = unordered, 1 = monotonic, "
                   "2 = acquire, 3 = sequentially consistent"),
    cl::CommaSeparated);

static cl::opt<bool> scope("scope", 
    cl::desc("Change synchronization scope from single-threaded to multi-threaded and vice-versa"),
    cl::init(false));

namespace {
class LoadPass : public PassInfoMixin<LoadPass> {
public:
    LoadVisitor loadInsts;

    // Main entry point for the pass
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
        bool modified = false;

        checkCommandLineArgs();

        if (onlyAtomic) {
            loadInsts.setOnlyAtomic(true);
        }

        loadInsts.visit(M);
        print();
        if (toggle) {
            toggleInstructions();
            modified = true;
        } else if (modMode) {
            modifyInstructions();
            modified = true;
        } else { // scope
            toggleScope();
            modified = true;
        }

#ifdef MUT_DEBUG
        errs() << "[DEBUG] exiting run\n";
#endif

        return modified ? PreservedAnalyses::none() : PreservedAnalyses::all();
    }

private:
    bool indexOutOfBounds(unsigned index) {
        return loadInsts.getSize() < index;
    }

    void toggleInstructions() {
        for (unsigned curIndex : positions) {
            if (curIndex < loadInsts.getSize()) {
                LoadInst *curInst = loadInsts.getInst(curIndex);
                if (curInst->isAtomic()) {
                    curInst->setOrdering(AtomicOrdering::NotAtomic);
                } else {
                    errs() << "Warning: -toggle only works for atomic loads, "
                           << "skipping index " << curIndex << '\n';
                }
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }

    void toggleScope() {
        for (unsigned curIndex : positions) {
            if (curIndex < loadInsts.getSize()) {
                LoadInst *curInst = loadInsts.getInst(curIndex);
                if (curInst->getSyncScopeID() == SyncScope::System) {
                    curInst->setSyncScopeID(SyncScope::SingleThread);
                } else {
                    curInst->setSyncScopeID(SyncScope::System);
                }
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }

    void modifyInstructions() {
        for (unsigned curIndex : positions) {
            if (curIndex < loadInsts.getSize()) {
                LoadInst *curInst = loadInsts.getInst(curIndex);
                AtomicOrdering aorder = getOrdering(curIndex);
                curInst->setOrdering(aorder);
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }
        virtual void print() const {
        if (!verbose) {
            errs() << loadInsts.getSize() << '\n';
        }
        else {
            for (unsigned i = 0; i < loadInsts.getSize(); i++) {
                StringRef filename;
                unsigned linenum;

                filename = getDebugFilename(loadInsts.getInst(i));
                linenum = getDebugLineNum(loadInsts.getInst(i));
                errs() << i << '\t' << filename << ':' << linenum << "\n\t";
                errs() << *(loadInsts.getInst(i)) << '\n';
            }
        }
    }

    AtomicOrdering getOrdering(unsigned index) {
        if (index < orderings.size()) {
            return unsignedToOrdering(orderings[index]);
        } else {
            return unsignedToOrdering(*orderings.end());
        }
    }

    AtomicOrdering unsignedToOrdering(unsigned val) {
        switch (val) {
            case 0: return AtomicOrdering::Unordered;
            case 1: return AtomicOrdering::Monotonic;
            case 2: return AtomicOrdering::Acquire;
            case 3: return AtomicOrdering::SequentiallyConsistent;
            default: return AtomicOrdering::Unordered;
        }
    }

    void outOfBoundsWarning(unsigned curIndex) {
        errs() << "Warning: position " << curIndex << " is out-of-bounds of found instructions, skipping\n";
    }

    void checkCommandLineArgs() {
        if (toggle && positions.empty()) {
            errs() << "Error: -toggle but no positions specified with -pos\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && positions.empty()) {
            errs() << "Error: -mod but no positions specified with -pos\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && orderings.empty()) {
            errs() << "Error: -mod but no orderings specified with -order\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && toggle) {
            errs() << "Error: -mod and -toggle cannot both be specified\n";
            exit(EXIT_FAILURE);
        }
        if (modMode && scope) {
            errs() << "Error: -mod and -scope cannot both be specified\n";
            exit(EXIT_FAILURE);
        }
        if (scope && toggle) {
            errs() << "Error: -toggle and -scope cannot both be specified\n";
            exit(EXIT_FAILURE);
        }
        if (scope && positions.empty()) {
            errs() << "Error: -scope but no positions specified with -pos\n";
            exit(EXIT_FAILURE);
        }

        for (unsigned i = 0; i < orderings.size(); ++i) {
            if (orderings[i] > 3) {
                errs() << "Error: ordering value at index " << i << " is too large\n";
                exit(EXIT_FAILURE);
            }
        }
    }
};

// Register the pass with the LLVM pass pipeline
llvm::PassPluginLibraryInfo getLoadPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "LoadPass", LLVM_VERSION_STRING,
            [](PassBuilder &PB) {
                PB.registerPipelineParsingCallback(
                    [](StringRef Name, ModulePassManager &MPM,
                       ArrayRef<PassBuilder::PipelineElement>) {
                        if (Name == "loadpass") {
                            MPM.addPass(LoadPass());
                            return true;
                        }
                        return false;
                    });
            }};
}
} // end namespace

// Export this pass so that it can be dynamically loaded
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getLoadPassPluginInfo();
}
