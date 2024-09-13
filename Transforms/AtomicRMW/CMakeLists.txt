add_llvm_library(AtomicRMW MODULE 
AtomicRMW.cpp
AtomicRMWVisitor.cpp


ADDITIONAL_HEADER_DIRS
${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/AtomicRMW
)
