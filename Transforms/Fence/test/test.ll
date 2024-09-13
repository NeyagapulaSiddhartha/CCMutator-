; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Fence/test/test.cpp'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Fence/test/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: mustprogress noinline norecurse nounwind optnone uwtable
define dso_local noundef i32 @main() #0 !dbg !28 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %2, align 4
  store i32 0, ptr @a, align 4, !dbg !30
  store i32 2, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %1, metadata !31, metadata !DIExpression()), !dbg !37
  %3 = load i32, ptr %1, align 4, !dbg !39
  switch i32 %3, label %8 [
    i32 1, label %4
    i32 2, label %4
    i32 3, label %5
    i32 4, label %6
    i32 5, label %7
  ], !dbg !40

4:                                                ; preds = %0, %0
  fence acquire, !dbg !40
  br label %8, !dbg !40

5:                                                ; preds = %0
  fence release, !dbg !40
  br label %8, !dbg !40

6:                                                ; preds = %0
  fence acq_rel, !dbg !40
  br label %8, !dbg !40

7:                                                ; preds = %0
  fence seq_cst, !dbg !40
  br label %8, !dbg !40

8:                                                ; preds = %0, %4, %5, %6, %7
  %9 = load i32, ptr @a, align 4, !dbg !41
  %10 = add nsw i32 %9, 1, !dbg !41
  store i32 %10, ptr @a, align 4, !dbg !41
  ret i32 0, !dbg !42
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { mustprogress noinline norecurse nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!20, !21, !22, !23, !24, !25, !26}
!llvm.ident = !{!27}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !19, line: 3, type: !17, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !3, producer: "clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !16, globals: !18, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Fence/test/test.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin", checksumkind: CSK_MD5, checksum: "2c4a4b743ee0477dadce68b0684f29f3")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "memory_order", scope: !7, file: !6, line: 73, baseType: !8, size: 32, elements: !9, identifier: "_ZTSSt12memory_order")
!6 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/9/../../../../include/c++/9/bits/atomic_base.h", directory: "")
!7 = !DINamespace(name: "std", scope: null)
!8 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!9 = !{!10, !11, !12, !13, !14, !15}
!10 = !DIEnumerator(name: "memory_order_relaxed", value: 0, isUnsigned: true)
!11 = !DIEnumerator(name: "memory_order_consume", value: 1, isUnsigned: true)
!12 = !DIEnumerator(name: "memory_order_acquire", value: 2, isUnsigned: true)
!13 = !DIEnumerator(name: "memory_order_release", value: 3, isUnsigned: true)
!14 = !DIEnumerator(name: "memory_order_acq_rel", value: 4, isUnsigned: true)
!15 = !DIEnumerator(name: "memory_order_seq_cst", value: 5, isUnsigned: true)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !{!0}
!19 = !DIFile(filename: "llvm/lib/Transforms/Fence/test/test.cpp", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "2c4a4b743ee0477dadce68b0684f29f3")
!20 = !{i32 7, !"Dwarf Version", i32 5}
!21 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !{i32 1, !"wchar_size", i32 4}
!23 = !{i32 8, !"PIC Level", i32 2}
!24 = !{i32 7, !"PIE Level", i32 2}
!25 = !{i32 7, !"uwtable", i32 2}
!26 = !{i32 7, !"frame-pointer", i32 2}
!27 = !{!"clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!28 = distinct !DISubprogram(name: "main", scope: !19, file: !19, line: 5, type: !29, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2)
!29 = !DISubroutineType(types: !16)
!30 = !DILocation(line: 6, column: 7, scope: !28)
!31 = !DILocalVariable(name: "__m", arg: 1, scope: !32, file: !6, line: 120, type: !35)
!32 = distinct !DISubprogram(name: "atomic_thread_fence", linkageName: "_ZSt19atomic_thread_fenceSt12memory_order", scope: !7, file: !6, line: 120, type: !33, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !36)
!33 = !DISubroutineType(types: !34)
!34 = !{null, !35}
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "memory_order", scope: !7, file: !6, line: 81, baseType: !5)
!36 = !{}
!37 = !DILocation(line: 120, column: 36, scope: !32, inlinedAt: !38)
!38 = distinct !DILocation(line: 7, column: 5, scope: !28)
!39 = !DILocation(line: 121, column: 31, scope: !32, inlinedAt: !38)
!40 = !DILocation(line: 121, column: 5, scope: !32, inlinedAt: !38)
!41 = !DILocation(line: 8, column: 6, scope: !28)
!42 = !DILocation(line: 10, column: 5, scope: !28)
