#include "LockUnlockPairs.h"
#include "../Tools/ItaniumDemangle.h"
#include "../Tools/FileInfo.h"

#include "llvm/IR/InstIterator.h"

#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/DebugInfo.h"

#include <vector>
#include <string>

// Enable debugging output
#define MUT_DEBUG

// Enable verbose output
#define MUT_DEBUG_VERBOSE

void LockUnlockPairs::enumerate(Module &M, AliasAnalysis &AA) {
    // Iterate over every function
    for (Function &F : M) {
#ifdef MUT_DEBUG_VERBOSE
        errs() << "DEBUG: checking new function\n";
#endif
        // Vector to hold all lock & unlock calls for the function
        std::vector<CallInst *> mutexCalls;
        std::vector<InvokeInst *> mutexInvokes;

        // Iterate over every instruction in the function
        for (Function &F : M) {
            if (F.isDeclaration()) continue;

            for (Instruction &I : instructions(F)) {
                // Check for call instructions
                if (auto *callInst = dyn_cast<CallInst>(&I)) {
                    Function *calledFunc = callInst->getCalledFunction();
                    if (calledFunc && isMatch(calledFunc)) {
                        mutexCalls.push_back(callInst);
                    }
                } 
                // Check for invoke instructions
                else if (auto *invokeInst = dyn_cast<InvokeInst>(&I)) {
                    Function *calledFunc = invokeInst->getCalledFunction();
                    if (calledFunc && isMatch(calledFunc)) {
                        mutexInvokes.push_back(invokeInst);
                    }
                }
            }
        } // end for (instructions)
        
        // Find pairs in the current function
        findPairs(mutexCalls, mutexInvokes, AA);
    } // end for (functions)
} // end func

bool LockUnlockPairs::isMatch(Function *func) {
    std::string funcName = func->getName().str(); // Get function name as std::string
    bool ret = false;

#ifdef MUT_DEBUG_VERBOSE
    errs() << "DEBUG: checking for match: " << funcName << '\n';
#endif

    if (funcName == "std::__1::mutex::unlock" ||
        funcName == "std::__1::mutex::lock" ||
        funcName == "pthread_mutex_lock" ||
        funcName == "pthread_mutex_unlock") {
        ret = true;
    }

#ifdef MUT_DEBUG_VERBOSE
    errs() << "DEBUG: match found? " << ret << '\n';
#endif
    return ret;
}


#if 0 // These two functions don't provide full coverage of the case when a
      // lock is a CallInst and the unlock call is an Invoke and vice versa.
void LockUnlockPairs::findCallPairs(std::vector<CallInst *> &calls, AliasAnalysis &AA) {
#ifdef MUT_DEBUG
    errs() << "DEBUG: attempting to find call pairs in the following\n (size == " 
           << calls.size() << ")\n";
    for (unsigned i = 0; i < calls.size(); i++) {
        errs() << "\t" << *(calls[i]) << '\n';
    }
#endif

    // Check for a match in the unlock calls that follow a lock call. The
    // assumption is that a paired up unlock call cannot be before the
    // associated lock call.
    for (unsigned i = 0; i < calls.size(); i++) {
        CallInst *inst1;;
        inst1 = calls[i];
        if (isLockCall(inst1->getCalledFunction())) {
            for (unsigned j = i + 1; j < calls.size(); j++) {
                CallInst *inst2;
                inst2 = calls[j];
                if (isLockUnlockPair(inst1, inst2, AA)) {
#ifdef MUT_DEBUG
                    errs() << "DEBUG: found pair:\n\t" << *inst1 << "\n\t" << *inst2 << '\n';
#endif
                    CallLockUnlockPair *newPair;
                    newPair = new CallLockUnlockPair;
                    newPair->lockCall = inst1;
                    newPair->unlockCall = inst2;
                    CallPairs.push_back(newPair);
                }
            }
        }
    }
}

void LockUnlockPairs::findInvokePairs(std::vector<InvokeInst *> &calls, AliasAnalysis &AA) {
#ifdef MUT_DEBUG
    errs() << "DEBUG: attempting to find invoke pairs in the following\n (size == " 
           << calls.size() << ")\n";
    for (unsigned i = 0; i < calls.size(); i++) {
        errs() << "\t" << *(calls[i]) << '\n';
    }
#endif
    // Check for a match in the unlock calls that follow a lock call. The
    // assumption is that a paired up unlock call cannot be before the
    // associated lock call.
    for (unsigned i = 0; i < calls.size(); i++) {
        InvokeInst *inst1;;
        inst1 = calls[i];
        if (isLockCall(inst1->getCalledFunction())) {
            for (unsigned j = i + 1; j < calls.size(); j++) {
                InvokeInst *inst2;
                inst2 = calls[j];
                if (isLockUnlockPair(inst1, inst2, AA)) {
#ifdef MUT_DEBUG
                    errs() << "DEBUG: found pair:\n\t" << *inst1 << "\n\t" << *inst2 << '\n';
#endif
                    InvokeLockUnlockPair *newPair;
                    newPair = new InvokeLockUnlockPair;
                    newPair->lockCall = inst1;
                    newPair->unlockCall = inst2;
                    InvokePairs.push_back(newPair);
                }
            }
        }
    }
}
#endif

void LockUnlockPairs::findPairs(std::vector<CallInst *> &calls, std::vector<InvokeInst *> &invokes,
                                AAResults &AA) {
    // For each lock instruction found in either calls or invokes, compare it to
    // every other unlock call to see if they are a pair.

    // Compare all the call instructions
    for (unsigned i = 0; i < calls.size(); i++) {
        CallInst *call1 = calls[i];
        if (Function *calledFunc = call1->getCalledFunction()) {
            if (isLockCall(calledFunc)) {
                // Compare to all other CallInsts
                for (unsigned j = 0; j < calls.size(); j++) {
                    if (i == j) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: comparing call to itself, skipping\n"
                               << "\t i == " << i << " j == " << j << '\n';
#endif
                        continue;
                    }

                    CallInst *call2 = calls[j];
                    if (isLockUnlockPair(call1, call2, AA)) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: found pair:\n\t" << *call1 << "\n\t" << *call2 << '\n';
#endif
                        CallCallLockPair *newPair = new CallCallLockPair{call1, call2};
                        CallCallPairs.push_back(newPair);
                    }
                }

                // Compare to all InvokeInsts
                for (unsigned j = 0; j < invokes.size(); j++) {
                    InvokeInst *invoke2 = invokes[j];
                    if (isLockUnlockPair(call1, invoke2, AA)) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: found pair:\n\t" << *call1 << "\n\t" << *invoke2 << '\n';
#endif
                        CallInvokeLockPair *newPair = new CallInvokeLockPair{call1, invoke2};
                        CallInvokePairs.push_back(newPair);
                    }
                }
            }
        }
    }

    // Compare all the InvokeInst instructions
    for (unsigned i = 0; i < invokes.size(); i++) {
        InvokeInst *invoke1 = invokes[i];
        if (Function *calledFunc = invoke1->getCalledFunction()) {
            if (isLockCall(calledFunc)) {
                // Compare to all CallInsts
                for (unsigned j = 0; j < calls.size(); j++) {
                    CallInst *call2 = calls[j];
                    if (isLockUnlockPair(invoke1, call2, AA)) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: found pair:\n\t" << *invoke1 << "\n\t" << *call2 << '\n';
#endif
                        InvokeCallLockPair *newPair = new InvokeCallLockPair{invoke1, call2};
                        InvokeCallPairs.push_back(newPair);
                    }
                }

                // Compare to all other InvokeInsts
                for (unsigned j = 0; j < invokes.size(); j++) {
                    if (i == j) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: comparing invoke to itself, skipping\n"
                               << "\t i == " << i << " j == " << j << '\n';
#endif
                        continue;
                    }

                    InvokeInst *invoke2 = invokes[j];
                    if (isLockUnlockPair(invoke1, invoke2, AA)) {
#ifdef MUT_DEBUG_VERB
                        errs() << "DEBUG: found pair:\n\t" << *invoke1 << "\n\t" << *invoke2 << '\n';
#endif
                        InvokeInvokeLockPair *newPair = new InvokeInvokeLockPair{invoke1, invoke2};
                        InvokeInvokePairs.push_back(newPair);
                    }
                }
            }
        }
    }
}

bool LockUnlockPairs::isLockCall(Function *func) const {
    if (!func) {
        return false; // Indirect function calls are not resolved
    }

    StringRef funcName = func->getName();

    if (funcName == "pthread_mutex_lock" || funcName == "std::__1::mutex::lock") {
        return true;
    }

    return false;
}

bool LockUnlockPairs::isLockUnlockPair(Function *lockFunc, Function *otherFunc,
                                       AAResults &AA, Value *mut1, Value *mut2) {
    if (!lockFunc || !otherFunc) {
        return false;
    }
    if (isLockCall(otherFunc)) {
        return false;
    }

    if (!isLockCall(lockFunc)) {
        errs() << "Warning: non-lock call passed as lockFunc to isLockUnlockPair()\n";
        return false;
    }

    StringRef lockFuncName = lockFunc->getName();
    StringRef otherFuncName = otherFunc->getName();

    AliasResult res = AA.alias(mut1, mut2);

    if (lockFuncName == "pthread_mutex_lock" && otherFuncName == "pthread_mutex_unlock") {
        if (res == AliasResult::MustAlias) {
            return true;
        }
    } else if (lockFuncName == "std::__1::mutex::lock" && otherFuncName == "std::__1::mutex::unlock") {
        if (res == AliasResult::MustAlias) {
            return true;
        }
    }

    return false;
}


bool LockUnlockPairs::isLockUnlockPair(CallInst *lockCall, CallInst *otherCall, AAResults &AA) {
    if (lockCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex call with < 1 operand, skipping\n";
        return false;
    }
    if (otherCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex call with < 1 operand, skipping\n";
        return false;
    }

    Value *mut1 = lockCall->getArgOperand(0);
    Value *mut2 = otherCall->getArgOperand(0);

    Function *lockFunc = lockCall->getCalledFunction();
    Function *otherFunc = otherCall->getCalledFunction();

    return isLockUnlockPair(lockFunc, otherFunc, AA, mut1, mut2);
}


bool LockUnlockPairs::isLockUnlockPair(InvokeInst *lockCall, InvokeInst *otherCall, AAResults &AA) {
    if (lockCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex invoke with < 1 operand, skipping\n";
        return false;
    }
    if (otherCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex invoke with < 1 operand, skipping\n";
        return false;
    }

    Value *mut1 = lockCall->getArgOperand(0);
    Value *mut2 = otherCall->getArgOperand(0);

    Function *lockFunc = lockCall->getCalledFunction();
    Function *otherFunc = otherCall->getCalledFunction();

    return isLockUnlockPair(lockFunc, otherFunc, AA, mut1, mut2);
}


bool LockUnlockPairs::isLockUnlockPair(CallInst *lockCall, InvokeInst *otherInvoke, AAResults &AA) {
    if (lockCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex call with < 1 operand, skipping\n";
        return false;
    }
    if (otherInvoke->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex invoke with < 1 operand, skipping\n";
        return false;
    }

    Value *mut1 = lockCall->getArgOperand(0);
    Value *mut2 = otherInvoke->getArgOperand(0);

    Function *lockFunc = lockCall->getCalledFunction();
    Function *otherFunc = otherInvoke->getCalledFunction();

    return isLockUnlockPair(lockFunc, otherFunc, AA, mut1, mut2);
}

bool LockUnlockPairs::isLockUnlockPair(InvokeInst *lockInvoke, CallInst *otherCall, AAResults &AA) {
    if (lockInvoke->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex invoke with < 1 operand, skipping\n";
        return false;
    }
    if (otherCall->arg_size() < 1) {
        errs() << "Warning: found a pthread or std::mutex call with < 1 operand, skipping\n";
        return false;
    }

    Value *mut1 = lockInvoke->getArgOperand(0);
    Value *mut2 = otherCall->getArgOperand(0);

    Function *lockFunc = lockInvoke->getCalledFunction();
    Function *otherFunc = otherCall->getCalledFunction();

    return isLockUnlockPair(lockFunc, otherFunc, AA, mut1, mut2);
}


unsigned LockUnlockPairs::getNumPairs() const {
    int ret;
    ret = 0;
    ret += CallCallPairs.size();
    ret += CallInvokePairs.size();
    ret += InvokeCallPairs.size();
    ret += InvokeInvokePairs.size();

    return ret;
}

unsigned LockUnlockPairs::getNumCallCallPairs() const {
    return CallCallPairs.size();
}
unsigned LockUnlockPairs::getNumCallInvokePairs() const {
    return CallInvokePairs.size();
}
unsigned LockUnlockPairs::getNumInvokeCallPairs() const {
    return InvokeCallPairs.size();
}

unsigned LockUnlockPairs::getNumInvokeInvokePairs() const {
    return InvokeInvokePairs.size();
}

void LockUnlockPairs::printDebugInfo() const {
    for (unsigned i = 0; i < CallCallPairs.size(); i++) {
        CallCallLockPair *curPair = CallCallPairs[i];
        CallInst *lockCall = curPair->lockCall;
        CallInst *unlockCall = curPair->unlockCall;
        Function *parent = lockCall->getFunction();

        errs() << parent->getName() << '\t' << 0 << '\t' << i << '\n';
        errs() << '\t' << *lockCall << '\n';
        errs() << '\t' << *unlockCall << '\n';

        printDebugInfo(lockCall, unlockCall);
    }
    for (unsigned i = 0; i < CallInvokePairs.size(); i++) {
        CallInvokeLockPair *curPair = CallInvokePairs[i];
        CallInst *lockCall = curPair->lockCall;
        InvokeInst *unlockInvoke = curPair->unlockInvoke;
        Function *parent = lockCall->getFunction();

        errs() << parent->getName() << '\t' << 1 << '\t' << i << '\n';
        errs() << '\t' << *lockCall << '\n';
        errs() << '\t' << *unlockInvoke << '\n';

        printDebugInfo(lockCall, unlockInvoke);
    }
    for (unsigned i = 0; i < InvokeCallPairs.size(); i++) {
        InvokeCallLockPair *curPair = InvokeCallPairs[i];
        InvokeInst *lockInvoke = curPair->lockInvoke;
        CallInst *unlockCall = curPair->unlockCall;
        Function *parent = lockInvoke->getFunction();

        errs() << parent->getName() << '\t' << 2 << '\t' << i << '\n';
        errs() << '\t' << *lockInvoke << '\n';
        errs() << '\t' << *unlockCall << '\n';
        
        printDebugInfo(lockInvoke, unlockCall);
    }
    for (unsigned i = 0; i < InvokeInvokePairs.size(); i++) {
        InvokeInvokeLockPair *curPair = InvokeInvokePairs[i];
        InvokeInst *lockInvoke = curPair->lockInvoke;
        InvokeInst *unlockInvoke = curPair->unlockInvoke;
        Function *parent = lockInvoke->getFunction();

        errs() << parent->getName() << '\t' << 3 << '\t' << i << '\n';
        errs() << '\t' << *lockInvoke << '\n';
        errs() << '\t' << *unlockInvoke << '\n';

        printDebugInfo(lockInvoke, unlockInvoke);
    }
}


int LockUnlockPairs::calcDistanceBetween(Instruction *inst1, Instruction *inst2) const {
    // Check that the instructions are from the same function
    if (inst1->getFunction() != inst2->getFunction()) {
        errs() << "Warning: unable to calculate the distance between two "
                 "instructions that are in different functions";
        return -1;
    }

    int distance = 0;
    Function *parentFunc = inst1->getFunction();
    auto iter = inst_begin(parentFunc);

    // Find the first instruction in the function
    while (&*iter != inst1 && &*iter != inst2) {
        ++iter;
    }

    // Increment the iterator past the just found instruction
    ++iter;
    ++distance;

    while (&*iter != inst1 && &*iter != inst2) {
        ++distance;
        ++iter;
    }

    return distance;
}


void LockUnlockPairs::printDebugInfo(Instruction *lockCall, Instruction *unlockCall) const {
    // Lock call filename and line number
    StringRef fileName1 = getDebugFilename(lockCall);
    unsigned lineNum1 = getDebugLineNum(lockCall);
    
    if (fileName1.empty()) {
        errs() << "\tno debug filename for lock call";
    } else {
        errs() << '\t' << fileName1;
    }

    if (lineNum1 == std::numeric_limits<unsigned>::max()) {
        errs() << " no debug line number for lock call";
    } else {
        errs() << ' ' << lineNum1;
    }

    // Unlock call filename and line number
    StringRef fileName2 = getDebugFilename(unlockCall);
    unsigned lineNum2 = getDebugLineNum(unlockCall);
    
    if (fileName2.empty()) {
        errs() << "\tno debug filename for unlock call";
    } else {
        errs() << '\t' << fileName2;
    }

    if (lineNum2 == std::numeric_limits<unsigned>::max()) {
        errs() << " no debug line number for unlock call";
    } else {
        errs() << ' ' << lineNum2;
    }

    // Distance between the two calls
    int distBetween = calcDistanceBetween(lockCall, unlockCall);
    
    if (distBetween < 0) {
        errs() << "\tunable to calc distance between insts\n";
    } else {
        errs() << '\t' << distBetween << '\n';
    }
}


LockUnlockPairs::CallCallLockPair *LockUnlockPairs::getCallCallPair(unsigned index) {
    if (index < CallCallPairs.size()) {
        return CallCallPairs[index];
    } else {
        return nullptr;
    }
}

LockUnlockPairs::CallInvokeLockPair *LockUnlockPairs::getCallInvokePair(unsigned index) {
    if (index < CallInvokePairs.size()) {
        return CallInvokePairs[index];
    } else {
        return nullptr;
    }
}

LockUnlockPairs::InvokeCallLockPair *LockUnlockPairs::getInvokeCallPair(unsigned index) {
    if (index < InvokeCallPairs.size()) {
        return InvokeCallPairs[index];
    } else {
        return nullptr;
    }
}

LockUnlockPairs::InvokeInvokeLockPair *LockUnlockPairs::getInvokeInvokePair(unsigned index) {
    if (index < InvokeInvokePairs.size()) {
        return InvokeInvokePairs[index];
    } else {
        return nullptr;
    }
}

