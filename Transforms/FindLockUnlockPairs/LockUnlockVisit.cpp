/**
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE for details.
 *
 * \file LockUnlockVisit.cpp
 * Author: Markus Kusano
 * Date: 2013-01-15
 *
 * See LockUnlockVisit.h for more information
 */

#include "LockUnlockVisit.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Debug.h"
#include "llvm/Analysis/AliasAnalysis.h"

using namespace llvm;

// Visit a call instruction
void LockUnlockVisit::visitCallInst(CallBase &I) {
    // Check if the function being called is pthread_mutex_lock or pthread_mutex_unlock
    Function *call = I.getCalledFunction();

    if (call) {
        // Assumption: calls to pthread_mutex_lock will never be indirect and
        // their first argument is the mutex they operate on
        if (isPthreadLock(call)) {
         errs() << "DEBUG: pthread_mutex_lock call found\n";
            if (!call->arg_empty()) {
                // DEBUG(errs() << "with first argument: " << *call->arg_begin() << '\n');
                errs() << "with first argument: " << *call->arg_begin() << '\n';
            }
        } else if (isPthreadUnlock(call)) {
            //DEBUG(errs() << "DEBUG: pthread_mutex_unlock call found\n");
            errs() << "DEBUG: pthread_mutex_unlock call found\n";
            if (!call->arg_empty()) {
                errs() << "with first argument: " << *call->arg_begin() << '\n';
                //DEBUG(errs() << "with first argument: " << *call->arg_begin() << '\n');
            }
        }
    }
}

// Check if the function is pthread_mutex_lock
bool LockUnlockVisit::isPthreadLock(const Function *F) const {
    return F && F->getName() == "pthread_mutex_lock";
}

// Check if the function is pthread_mutex_unlock
bool LockUnlockVisit::isPthreadUnlock(const Function *F) const {
    return F && F->getName() == "pthread_mutex_unlock";
}

// Set alias analysis information
void LockUnlockVisit::sendAliasInfo(AliasAnalysis *AA) {
    aliasInfo = AA;
}
