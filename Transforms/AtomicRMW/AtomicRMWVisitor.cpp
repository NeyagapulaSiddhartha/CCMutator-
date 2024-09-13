/*
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \author: Markus Kusano
 * \date: 2013-06-02
 */

#include "AtomicRMWVisitor.h"

#include "llvm/Pass.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

// #include "/Tools/FileInfo.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
// Enable debugging output
#define MUT_DEBUG

#ifdef MUT_DEBUG
#include "llvm/Support/raw_ostream.h"
#endif


 void AtomicRMWVisitor::visitAtomicRMWInst(AtomicRMWInst &I) {
#ifdef MUT_DEBUG
    errs() << "[DEBUG] Found atomicrmw Inst\n";
#endif
    llvm::errs()<<"this is the  visitor function  \n";
    atomicRMWInsts.push_back(&I);
}

unsigned AtomicRMWVisitor::getSize() const {
    return atomicRMWInsts.size();
}
void AtomicRMWVisitor::visit(Module &M) {
    for(Function &f:M){
        for (BasicBlock &BB :f){
            for(Instruction &I :BB)
            {
                if(isa<AtomicRMWInst>(I))
                {
                    //llvm::errs()<<I <<" \n";
                    if (auto *AtomicRMW = dyn_cast<AtomicRMWInst>(&I)) {
                    visitAtomicRMWInst(*AtomicRMW);
                    }
                }
            }
        }
    }
}

AtomicRMWInst *AtomicRMWVisitor::getInst(unsigned index) const {
    if (index < getSize()) {
        return atomicRMWInsts[index];
    } else {
        return nullptr;  // Use nullptr instead of NULL
    }
}
