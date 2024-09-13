# Makes the test bitcode files
# Requires that the following variables be present in the shell:
#   clang: the location of clang
#   llvmdis: the location of llvm-dis (required for human-readable test bitcode files)

# Define variable
clang=/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin/clang
llvmdis=/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin/llvm-dis
LIBCXX_LOCATION=/home/cs23mtech12010/anaconda3/envs/llvm3.2_for_py/
llc=/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin/llc
# Target to compile C++ source to LLVM IR and then to bitcode
cxx: test.cpp
	$(clang) -g -S -std=c++11 -emit-llvm test.cpp -o test.s -c -I$(LIBCXX_LOCATION)/include/c++/v1
	mv test.s test.ll
	llvm-as test.ll
	$(llc) test.bc -o test.s
	$(clang) -stdlib=libcxx test.s -o unmut.exe -I$(LIBCXX_LOCATION)/include/c++/v1 -L$(LIBCXX_LOCATION)/lib -lpthread -lsupc++ -lc++

# Target to run the executables with LD_PRELOAD set
run:
	LD_PRELOAD=$(LIBCXX_LOCATION)/pkgs/libcxx-11.1.0-h4bd325d_0/lib/libc++.so.1 ./unmut.exe $(A)
	LD_PRELOAD=$(LIBCXX_LOCATION)/pkgs/libcxx-11.1.0-h4bd325d_0/lib/libc++.so.1 ./test_out_03.exe $(A)
	LD_PRELOAD=$(LIBCXX_LOCATION)/pkgs/libcxx-11.1.0-h4bd325d_0/lib/libc++.so.1 ./test_out_08.exe $(A)
	LD_PRELOAD=$(LIBCXX_LOCATION)/pkgs/libcxx-11.1.0-h4bd325d_0/lib/libc++.so.1 ./test_out_11.exe $(A)

# Target to test by compiling bitcode to executables
test:
	$(llc) out_03.bc -o test_out_03.s
	$(clang) -stdlib=libcxx test_out_03.s -o test_out_03.exe -I$(LIBCXX_LOCATION)/include/c++/v1 -L$(LIBCXX_LOCATION)/lib -lpthread -lsupc++ -lc++
	$(llc) out_08.bc -o test_out_08.s
	$(clang) -stdlib=libcxx test_out_08.s -o test_out_08.exe -I$(LIBCXX_LOCATION)/include/c++/v1 -L$(LIBCXX_LOCATION)/lib -lpthread -lsupc++ -lc++
	$(llc) out_11.bc -o test_out_11.s
	$(clang) -stdlib=libcxx test_out_11.s -o test_out_11.exe -I$(LIBCXX_LOCATION)/include/c++/v1 -L$(LIBCXX_LOCATION)/lib -lpthread -lsupc++ -lc++
