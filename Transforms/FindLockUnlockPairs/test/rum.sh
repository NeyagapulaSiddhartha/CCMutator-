

cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/
cmake ../llvm
make FindLockUnlockPairs
cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/FindLockUnlockPairs/test
./run_test.sh