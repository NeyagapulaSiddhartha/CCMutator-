#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instructions.h"
#include <vector>

using namespace llvm;

class AtomicRMWVisitor {
public:
  void visit(Module &M);
    // Visitor function visitAtomicRMWInst
   void visitAtomicRMWInst(AtomicRMWInst &I);

    // Data accessor functions
    unsigned getSize() const;
    // Returns nullptr if index out-of-bounds
  virtual  AtomicRMWInst *getInst(unsigned index) const;

private:
    // Vector of all the found AtomicRMW instructions
    std::vector<AtomicRMWInst *> atomicRMWInsts;
};
