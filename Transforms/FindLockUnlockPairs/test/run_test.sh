

x="/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/lib/AtomicRMW.so"

cd /home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin/
echo "Begin Test: Non verbose analyze"
./opt  -load-pass-plugin=/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/lib/FindLockUnlockPairs.so -passes=FindLockUnlockPairs   /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/FindLockUnlockPairs/test/test.ll -o /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/AtomicRMW/test/out_put.ll 
# llvm-dis /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/FindLockUnlockPairs/test/out_put.bc -o /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/FindLockUnlockPairs/test/out_put.ll
echo ""
# ./opt  -load-pass-plugin=/home/cs23mtech12010/CCM/CCMutator/llvm-project/build/lib/AtomicRMW.so -passes=AtomicRMW -mod -pos 1 -order 2  /home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/AtomicRMW/test/test.ll 
# echo "Begin Test: verbose analyze"
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <test.bc >/dev/null
# echo ""

# echo "Begin Test: -mod without -pos (should fail)"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod -order=0 <test.bc >/dev/null
# echo ""

# echo "Begin Test: -mod and no -order (should fail)"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod -pos=0 <test.bc >/dev/null
# echo ""

# echo "Begin Test: just -mod (should fail)"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod <test.bc >/dev/null
# echo ""
# test="/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/AtomicRMW/test"
# echo "Begin Test: -mod position 1 to monotonic (-order=0) out to out_001.bc"
# ./opt -load-pass-plugin=$x -passes=AtomicRMW -mod false -pos 1 -order 0 <$test/test.bc >$test/out_001.bc
# llvm-dis out_001.bc
# ./opt  -load-pass-plugin=$x -passes=AtomicRMW -verbose <$test/test.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0 to acquire (-order=1) out to out_002.bc"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod -pos=0 -order=1 <test.bc >out_002.bc
# llvm-dis out_002.bc
# opt  -load-pass-plugin=$x -passes=AtomicRMW -verbose <out_002.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0 to release (-order=2) out to out_003.bc"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod -pos=0 -order=2 <test.bc >out_003.bc
# llvm-dis out_003.bc
# opt  -load-pass-plugin=$x -passes=AtomicRMW -verbose <out_003.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0 to acquire release (-order=3) out to out_004.bc"
# opt -load-pass-plugin=$x -passes=AtomicRMW -mod -pos=0 -order=3 <test.bc >out_004.bc
# llvm-dis out_004.bc
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <out_004.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0 to  sequential consistency (-order=4) out to out_005.bc"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -mod -pos=0 -order=4 <test.bc >out_005.bc
# llvm-dis out_005.bc
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <out_005.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0 to  order 5 (one off, should fail"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -mod -pos=0 -order=5 <test.bc >/dev/null
# echo "End Test"

# echo "Begin Test: -mod position 0,1,2,3,4,5 to order=3,0 out to out_006.bc (should warn)"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -mod -pos=0,1,2,3,4,5 -order=3,0 <test.bc >out_006.bc
# llvm-dis out_006.bc
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <out_006.bc >/dev/null
# echo ""

# echo "Begin Test: -mod and -scope (should fail)"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -mod -scope -pos=0 -order=0<test.bc >/dev/null
# echo ""

# echo "Begin Test: -scope and no -pos (should fail)"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -scope <test.bc >/dev/null
# echo ""

# echo "Begin Test: -scope position 0, out to out_007.bc"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -scope -pos=0 <test.bc >out_007.bc
# llvm-dis out_007.bc
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <out_007.bc >/dev/null
# echo ""

# echo "Begin Test: -scope position 0 of out_007.bc out to out_008.bc"
# opt -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -scope -pos=0 <out_007.bc >out_008.bc
# llvm-dis out_008.bc
# opt  -load-pass-plugin= $CCMUTATE_LIB/$testLibName -passes=AtomicRMW -verbose <out_008.bc >/dev/null
# echo ""
