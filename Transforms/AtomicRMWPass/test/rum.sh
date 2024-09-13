cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/
cmake ../llvm
make AtomicRMWPass
cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/AtomicRMWPass/test
./run_test.sh