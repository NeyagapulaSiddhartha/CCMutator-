LIBCXX_LOCATION=/home/cs23mtech12010/anaconda3/envs/llvm3.2_for_py
cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin
./clang  -S -emit-llvm /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Load/test/test.cpp -o /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Load/test/test.ll
# mv test.s test.ll
# llvm-as test.ll
