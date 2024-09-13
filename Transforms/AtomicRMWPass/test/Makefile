LIBCXX_LOCATION=/home/markus/Repos/libc++/libc++

all:
	/home/cs23mtech12010/CCM/CCMutator/llvm-project/build/bin/clang  -S  -emit-llvm /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CompareExchange/test/test.cpp -c -o test2.ll
	llvm-as test2.ll -o test2.bc

