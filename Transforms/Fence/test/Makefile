LIBCXX_LOCATION=/home/markus/Repos/libc++/libc++

all:
	clang -g -S  -emit-llvm test.cpp -c -
	mv test.s test.ll
	llvm-as test.ll
