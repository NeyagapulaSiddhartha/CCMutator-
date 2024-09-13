add_llvm_library(Mutex MODULE 
Mutex.cpp
LockUnlockPairs.cpp



ADDITIONAL_HEADER_DIRS
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/LockUnlockPairs.h

)
