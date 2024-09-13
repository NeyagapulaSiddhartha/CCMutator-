#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
// #include "/Tools/FileInfo.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/IR/InstVisitor.h"
#include "CmpXchgVisitor.h"
using namespace llvm;
#define MUT_DEBUG

#ifdef MUT_DEBUG
#include "llvm/Support/raw_ostream.h"
#endif






namespace {



class AtomicRMWPass : public PassInfoMixin<AtomicRMWPass> {
public:
 unsigned Count;
     PreservedAnalyses run(Module &f, ModuleAnalysisManager &) {
        

   
            
                   CountAllocaVisitor CAV;
                    CAV.visit(f);
                    int NumAllocas = CAV.getSize();
                    llvm::errs()<<"the count is ="<<NumAllocas<<"\n";
        

       // visit(&M);
        // auto  NumAllocas = Count;
         //   llvm::errs()<<"the count is ="<<NumAllocas<<"\n";
        return PreservedAnalyses::none(); // Return preserved analyses
    }
};

} // namespace

// Register the pass with LLVM

llvm::PassPluginLibraryInfo getAtomicRMWPassPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "AtomicRMWPass", LLVM_VERSION_STRING,
                [](PassBuilder &PB) {
                        PB.registerPipelineParsingCallback(
                            [](StringRef Name, ModulePassManager &MPM, ArrayRef<PassBuilder::PipelineElement>) {
                                        if (Name == "AtomicRMWPass") {
                                                        MPM.addPass(AtomicRMWPass());
                                                return true;
                                                    }
                                         return false;
                                        });
                                    }};
                                        }


extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getAtomicRMWPassPluginInfo();
}

