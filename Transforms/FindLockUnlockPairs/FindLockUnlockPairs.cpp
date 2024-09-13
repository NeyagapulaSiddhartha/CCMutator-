/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \file FindLockUnlockPairs.cpp
 * Author: Markus Kusano
 * Date: 2013-01-25
 *
 * Pass to find lock/unlock pairs
 */

#include "LockUnlockVisit.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Analysis/AliasAnalysis.h"

using namespace llvm;

namespace {
    class FindLockUnlockPairsPass : public PassInfoMixin<FindLockUnlockPairsPass> {
    public:
        PreservedAnalyses run(Module &M, ModuleAnalysisManager &MAM) {
        auto &AA = MAM.getResult<AAManager>(M);
            pairVisit.sendAliasInfo(&AA);
            pairVisit.visit(&M);

            return PreservedAnalyses::all();
        }

        static bool isRequired() { return true; }

    private:
        LockUnlockVisit pairVisit;
    };
}

llvm::PassPluginLibraryInfo getAtomicRMWPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "FindLockUnlockPairs", LLVM_VERSION_STRING,
                [](PassBuilder &PB) {
                        PB.registerPipelineParsingCallback(
                            [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>) {
                                        if (Name == "FindLockUnlockPairs") {
                                                        MPM.addPass(FindLockUnlockPairsPass());
                                                return true;
                                                    }
                                         return false;
                                        });
                                    }};
                                        }


extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getAtomicRMWPassPluginInfo();
}


// // Create a pass plugin
// extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeFindLockUnlockPairsPass() {
//     PassBuilder PB;
//     PB.registerPipelineParsingCallback(
//         [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement> Elements) {
//             if (Name == "FindLockUnlockPairs") {
//                 MPM.addPass(FindLockUnlockPairsPass());
//                 return true;
//             }
//             return false;
//         }
//     );
// }
