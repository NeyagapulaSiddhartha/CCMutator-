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
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstVisitor.h"
#include "CmpXchgVisitor.h"
#include "../Tools/FileInfo.h"

using namespace llvm;

// Enable Debugging Output
#define MUT_DEBUG

static cl::list<unsigned> positions("pos",
    cl::desc("Occurrences to remove or modify"),
    cl::value_desc("comma separated list of unsigned ints"),
    cl::CommaSeparated);

static cl::opt<bool> verbose("verbose",
        cl::desc("Enable verbose output"),
        cl::init(false));

static cl::opt<bool> onlyAtomic("onlyatomic",
        cl::desc("Only enumerate and mutate atomic loads"),
        cl::Hidden,
        cl::init(true));

static cl::opt<bool> modMode("mod",
        cl::desc("Change atomic ordering of load instruction, use -order to specify ordering"),
        cl::init(false));

static cl::list<unsigned> orderings("order",
        cl::desc("Atomic ordering values for each position found in -pos"),
        cl::value_desc("comma separated list of unsigned ints. 0 = monotonic, "
                       "1 = acquire, 2 = release, 3 = acquire release, 4 = sequentially consistent"),
        cl::CommaSeparated);

static cl::opt<bool> scope("scope",
        cl::desc("Change synchronization scope from single-threaded to multi-threaded and vice-versa"),
        cl::init(false));

namespace {
struct CmpXchg : public PassInfoMixin<CmpXchg> {
    static char ID;
    CmpXchgVisitor cmpXchgInsts;


    // Runs the pass on the given module.
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
        bool modified = false;

        checkCommandLineArgs();

        cmpXchgInsts.visit(M);

        int NumAllocas = cmpXchgInsts.getSize();
        llvm::errs()<<"the count is ="<<NumAllocas<<"\n";

        if (modMode) {
            modifyInstructions();
            modified = true;
        } else if (scope) {
            toggleScope();
            modified = true;
        }

#ifdef MUT_DEBUG
        errs() << "[DEBUG] exiting runOnModule\n";
#endif
        return PreservedAnalyses::none();
    }

    bool indexOutOfBounds(unsigned index) {
        return cmpXchgInsts.getSize() < index;
    }

    void toggleScope() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex = positions[i];


            if (curIndex < cmpXchgInsts.getSize()) {
                AtomicCmpXchgInst *curInst = cmpXchgInsts.getInst(curIndex);

                 SyncScope::ID currentScope = curInst->getSyncScopeID();
                if (currentScope == SyncScope::System)
                curInst->setSyncScopeID(SyncScope::SingleThread);
            else
                curInst->setSyncScopeID(SyncScope::System);
            } 
        else {
            outOfBoundsWarning(curIndex);
        }

            //     if (currentScope == SyncScope::CrossThread)
            //         curInst->setSynchScope(SyncScope::SingleThread);
            //     else
            //         curInst->setSynchScope(SyncScope::CrossThread);
            // } else {
            //     outOfBoundsWarning(curIndex);
            // }
        }
    }

    void modifyInstructions() {
        for (unsigned i = 0; i < positions.size(); i++) {
            unsigned curIndex = positions[i];
            if (curIndex < cmpXchgInsts.getSize()) {
                AtomicOrdering aorder = getOrdering(curIndex);
                AtomicCmpXchgInst *curInst = cmpXchgInsts.getInst(curIndex);
                //curInst->setOrdering(aorder);
                errs()<<"the changed ins are "<<*curInst<<" \n";
            curInst->setSuccessOrdering(aorder);
            curInst->setFailureOrdering(AtomicOrdering::Monotonic);
            } else {
                outOfBoundsWarning(curIndex);
            }
        }
    }

    AtomicOrdering getOrdering(unsigned index) {
        if (index < orderings.size()) {
            return unsignedToOrdering(orderings[index]);
        } else {
            return unsignedToOrdering(orderings[orderings.size() - 1]);
        }
    }

    AtomicOrdering unsignedToOrdering(unsigned val) {
        switch (val) {
            case 0:
                return AtomicOrdering::Monotonic;
            case 1:
                return AtomicOrdering::Acquire;
            case 2:
                return AtomicOrdering::Release;
            case 3:
                return AtomicOrdering::AcquireRelease;
            case 4:
                return AtomicOrdering::SequentiallyConsistent;
            default:
                return AtomicOrdering::Unordered;
        }
    }

    void outOfBoundsWarning(unsigned curIndex) {
        errs() << "Warning: position " << curIndex << " is out-of-bounds "
               << "of found instructions, skipping\n";
    }

    void checkCommandLineArgs() {
        if (modMode && positions.size()==0) {
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
};

char CmpXchg::ID = 0;
} // end anonymous namespace

// Register the pass with the new PassManager
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "CmpXchg", "v0.1", [](PassBuilder &PB) {
        PB.registerPipelineParsingCallback(
            [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement> Elements) {
                if (Name == "CmpXchg") {
                    MPM.addPass(CmpXchg());
                    return true;
                }
                return false;
            });
    }};
}
