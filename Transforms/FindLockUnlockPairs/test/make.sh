
cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/build/bin/
./clang  -S -std=c++11  -emit-llvm /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/FindLockUnlockPairs/test/test.cpp -c -o test.ll
llvm-as test.ll -o test.bc

