; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CondWait/test/test_time.c'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CondWait/test/test_time.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { ptr, ptr }
%union.pthread_cond_t = type { %struct.__pthread_cond_s }
%struct.__pthread_cond_s = type { %union.anon, %union.anon.0, [2 x i32], [2 x i32], i32, i32, [2 x i32] }
%union.anon = type { i64 }
%union.anon.0 = type { i64 }
%struct.timespec = type { i64, i64 }
%struct.timeval = type { i64, i64 }

@cond_mutex = dso_local global %union.pthread_mutex_t zeroinitializer, align 8, !dbg !0
@cond_pcond = dso_local global %union.pthread_cond_t zeroinitializer, align 8, !dbg !7
@cond = dso_local global i32 0, align 4, !dbg !68
@.str = private unnamed_addr constant [26 x i8] c"t2_main wakeup ret == %d\0A\00", align 1, !dbg !53
@.str.1 = private unnamed_addr constant [19 x i8] c"\09ret == ETIMEDOUT\0A\00", align 1, !dbg !58
@.str.2 = private unnamed_addr constant [37 x i8] c"Timespec wait: %ld seconds %lu usec\0A\00", align 1, !dbg !63

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @t1_main(ptr noundef %0) #0 !dbg !107 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !111, metadata !DIExpression()), !dbg !112
  call void @llvm.dbg.declare(metadata ptr %3, metadata !113, metadata !DIExpression()), !dbg !115
  store i32 0, ptr %3, align 4, !dbg !115
  br label %4, !dbg !116

4:                                                ; preds = %18, %1
  %5 = load i32, ptr %3, align 4, !dbg !117
  %6 = icmp slt i32 %5, 3, !dbg !119
  br i1 %6, label %7, label %21, !dbg !120

7:                                                ; preds = %4
  %8 = load i32, ptr @cond, align 4, !dbg !121
  %9 = icmp ne i32 %8, 0, !dbg !121
  %10 = zext i1 %9 to i64, !dbg !121
  %11 = select i1 %9, i32 0, i32 1, !dbg !121
  store i32 %11, ptr @cond, align 4, !dbg !123
  %12 = call i32 @sleep(i32 noundef 1), !dbg !124
  %13 = load i32, ptr @cond, align 4, !dbg !125
  %14 = icmp ne i32 %13, 0, !dbg !125
  br i1 %14, label %15, label %17, !dbg !127

15:                                               ; preds = %7
  %16 = call i32 @pthread_cond_signal(ptr noundef @cond_pcond) #6, !dbg !128
  br label %17, !dbg !130

17:                                               ; preds = %15, %7
  br label %18, !dbg !131

18:                                               ; preds = %17
  %19 = load i32, ptr %3, align 4, !dbg !132
  %20 = add nsw i32 %19, 1, !dbg !132
  store i32 %20, ptr %3, align 4, !dbg !132
  br label %4, !dbg !133, !llvm.loop !134

21:                                               ; preds = %4
  call void @exit(i32 noundef 0) #7, !dbg !137
  unreachable, !dbg !137
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @sleep(i32 noundef) #2

; Function Attrs: nounwind
declare i32 @pthread_cond_signal(ptr noundef) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @t2_main(ptr noundef %0) #0 !dbg !138 {
  %2 = alloca ptr, align 8
  %3 = alloca %struct.timespec, align 8
  %4 = alloca %struct.timeval, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !139, metadata !DIExpression()), !dbg !140
  call void @llvm.dbg.declare(metadata ptr %3, metadata !141, metadata !DIExpression()), !dbg !150
  call void @llvm.dbg.declare(metadata ptr %4, metadata !151, metadata !DIExpression()), !dbg !158
  call void @llvm.dbg.declare(metadata ptr %5, metadata !159, metadata !DIExpression()), !dbg !160
  %7 = call i32 @gettimeofday(ptr noundef %4, ptr noundef null) #6, !dbg !161
  call void @llvm.dbg.declare(metadata ptr %6, metadata !162, metadata !DIExpression()), !dbg !165
  %8 = getelementptr inbounds %struct.timeval, ptr %4, i32 0, i32 0, !dbg !166
  %9 = load i64, ptr %8, align 8, !dbg !166
  store i64 %9, ptr %6, align 8, !dbg !167
  %10 = load i64, ptr %6, align 8, !dbg !168
  %11 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 0, !dbg !169
  store i64 %10, ptr %11, align 8, !dbg !170
  %12 = getelementptr inbounds %struct.timeval, ptr %4, i32 0, i32 1, !dbg !171
  %13 = load i64, ptr %12, align 8, !dbg !171
  %14 = add i64 %13, 100000, !dbg !172
  %15 = mul i64 %14, 1000, !dbg !173
  %16 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 1, !dbg !174
  store i64 %15, ptr %16, align 8, !dbg !175
  br label %17, !dbg !176

17:                                               ; preds = %1, %36
  %18 = call i32 @pthread_mutex_lock(ptr noundef @cond_mutex) #6, !dbg !177
  br label %19, !dbg !179

19:                                               ; preds = %35, %17
  %20 = load i32, ptr @cond, align 4, !dbg !180
  %21 = icmp ne i32 %20, 0, !dbg !181
  %22 = xor i1 %21, true, !dbg !181
  br i1 %22, label %23, label %36, !dbg !179

23:                                               ; preds = %19
  %24 = call i32 @pthread_cond_timedwait(ptr noundef @cond_pcond, ptr noundef @cond_mutex, ptr noundef %3), !dbg !182
  store i32 %24, ptr %5, align 4, !dbg !184
  %25 = load i32, ptr %5, align 4, !dbg !185
  %26 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %25), !dbg !186
  %27 = load i32, ptr %5, align 4, !dbg !187
  %28 = icmp ne i32 %27, 0, !dbg !187
  br i1 %28, label %29, label %35, !dbg !189

29:                                               ; preds = %23
  %30 = load i32, ptr %5, align 4, !dbg !190
  %31 = icmp eq i32 %30, 110, !dbg !193
  br i1 %31, label %32, label %34, !dbg !194

32:                                               ; preds = %29
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.1), !dbg !195
  br label %34, !dbg !197

34:                                               ; preds = %32, %29
  br label %35, !dbg !198

35:                                               ; preds = %34, %23
  br label %19, !dbg !179, !llvm.loop !199

36:                                               ; preds = %19
  %37 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 0, !dbg !201
  %38 = load i64, ptr %37, align 8, !dbg !201
  %39 = getelementptr inbounds %struct.timespec, ptr %3, i32 0, i32 1, !dbg !202
  %40 = load i64, ptr %39, align 8, !dbg !202
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %38, i64 noundef %40), !dbg !203
  %42 = call i32 @pthread_mutex_unlock(ptr noundef @cond_mutex) #6, !dbg !204
  br label %17, !dbg !176, !llvm.loop !205
}

; Function Attrs: nounwind
declare i32 @gettimeofday(ptr noundef, ptr noundef) #3

; Function Attrs: nounwind
declare i32 @pthread_mutex_lock(ptr noundef) #3

declare i32 @pthread_cond_timedwait(ptr noundef, ptr noundef, ptr noundef) #2

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: nounwind
declare i32 @pthread_mutex_unlock(ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 !dbg !207 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !212, metadata !DIExpression()), !dbg !213
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !214, metadata !DIExpression()), !dbg !215
  call void @llvm.dbg.declare(metadata ptr %6, metadata !216, metadata !DIExpression()), !dbg !219
  call void @llvm.dbg.declare(metadata ptr %7, metadata !220, metadata !DIExpression()), !dbg !221
  %8 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @t1_main, ptr noundef null) #6, !dbg !222
  %9 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @t2_main, ptr noundef null) #6, !dbg !223
  call void @pthread_exit(ptr noundef null) #8, !dbg !224
  unreachable, !dbg !224
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noreturn
declare void @pthread_exit(ptr noundef) #5

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }
attributes #8 = { noreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!99, !100, !101, !102, !103, !104, !105}
!llvm.ident = !{!106}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "cond_mutex", scope: !2, file: !9, line: 13, type: !71, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !6, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CondWait/test/test_time.c", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project/build_conda/bin", checksumkind: CSK_MD5, checksum: "1c3a5b2b72901237dcdff83692c22020")
!4 = !{!5}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !{!0, !7, !53, !58, !63, !68}
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(name: "cond_pcond", scope: !2, file: !9, line: 14, type: !10, isLocal: false, isDefinition: true)
!9 = !DIFile(filename: "llvm/lib/Transforms/CondWait/test/test_time.c", directory: "/home/cs23mtech12010/CCM/CCMutator/llvm-project", checksumkind: CSK_MD5, checksum: "1c3a5b2b72901237dcdff83692c22020")
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_cond_t", file: !11, line: 80, baseType: !12)
!11 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "2d764266ce95ab26d4a4767c2ec78176")
!12 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !11, line: 75, size: 384, elements: !13)
!13 = !{!14, !46, !51}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "__data", scope: !12, file: !11, line: 77, baseType: !15, size: 384)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__pthread_cond_s", file: !16, line: 92, size: 384, elements: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h", directory: "", checksumkind: CSK_MD5, checksum: "4b8899127613e00869e96fcefd314d61")
!17 = !{!18, !29, !38, !42, !43, !44, !45}
!18 = !DIDerivedType(tag: DW_TAG_member, scope: !15, file: !16, line: 94, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !15, file: !16, line: 94, size: 64, elements: !20)
!20 = !{!21, !23}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "__wseq", scope: !19, file: !16, line: 96, baseType: !22, size: 64)
!22 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "__wseq32", scope: !19, file: !16, line: 101, baseType: !24, size: 64)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !19, file: !16, line: 97, size: 64, elements: !25)
!25 = !{!26, !28}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "__low", scope: !24, file: !16, line: 99, baseType: !27, size: 32)
!27 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "__high", scope: !24, file: !16, line: 100, baseType: !27, size: 32, offset: 32)
!29 = !DIDerivedType(tag: DW_TAG_member, scope: !15, file: !16, line: 103, baseType: !30, size: 64, offset: 64)
!30 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !15, file: !16, line: 103, size: 64, elements: !31)
!31 = !{!32, !33}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "__g1_start", scope: !30, file: !16, line: 105, baseType: !22, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "__g1_start32", scope: !30, file: !16, line: 110, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !30, file: !16, line: 106, size: 64, elements: !35)
!35 = !{!36, !37}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "__low", scope: !34, file: !16, line: 108, baseType: !27, size: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "__high", scope: !34, file: !16, line: 109, baseType: !27, size: 32, offset: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "__g_refs", scope: !15, file: !16, line: 112, baseType: !39, size: 64, offset: 128)
!39 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 64, elements: !40)
!40 = !{!41}
!41 = !DISubrange(count: 2)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "__g_size", scope: !15, file: !16, line: 113, baseType: !39, size: 64, offset: 192)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "__g1_orig_size", scope: !15, file: !16, line: 114, baseType: !27, size: 32, offset: 256)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "__wrefs", scope: !15, file: !16, line: 115, baseType: !27, size: 32, offset: 288)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "__g_signals", scope: !15, file: !16, line: 116, baseType: !39, size: 64, offset: 320)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !12, file: !11, line: 78, baseType: !47, size: 384)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 384, elements: !49)
!48 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!49 = !{!50}
!50 = !DISubrange(count: 48)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !12, file: !11, line: 79, baseType: !52, size: 64)
!52 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(scope: null, file: !9, line: 50, type: !55, isLocal: true, isDefinition: true)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 208, elements: !56)
!56 = !{!57}
!57 = !DISubrange(count: 26)
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression())
!59 = distinct !DIGlobalVariable(scope: null, file: !9, line: 54, type: !60, isLocal: true, isDefinition: true)
!60 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 152, elements: !61)
!61 = !{!62}
!62 = !DISubrange(count: 19)
!63 = !DIGlobalVariableExpression(var: !64, expr: !DIExpression())
!64 = distinct !DIGlobalVariable(scope: null, file: !9, line: 60, type: !65, isLocal: true, isDefinition: true)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 296, elements: !66)
!66 = !{!67}
!67 = !DISubrange(count: 37)
!68 = !DIGlobalVariableExpression(var: !69, expr: !DIExpression())
!69 = distinct !DIGlobalVariable(name: "cond", scope: !2, file: !9, line: 11, type: !70, isLocal: false, isDefinition: true)
!70 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_mutex_t", file: !11, line: 72, baseType: !72)
!72 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !11, line: 67, size: 320, elements: !73)
!73 = !{!74, !93, !97}
!74 = !DIDerivedType(tag: DW_TAG_member, name: "__data", scope: !72, file: !11, line: 69, baseType: !75, size: 320)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__pthread_mutex_s", file: !76, line: 22, size: 320, elements: !77)
!76 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/struct_mutex.h", directory: "", checksumkind: CSK_MD5, checksum: "3a896f588055d599ccb9e3fe6eaee3e3")
!77 = !{!78, !79, !80, !81, !82, !83, !85, !86}
!78 = !DIDerivedType(tag: DW_TAG_member, name: "__lock", scope: !75, file: !76, line: 24, baseType: !70, size: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !75, file: !76, line: 25, baseType: !27, size: 32, offset: 32)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "__owner", scope: !75, file: !76, line: 26, baseType: !70, size: 32, offset: 64)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "__nusers", scope: !75, file: !76, line: 28, baseType: !27, size: 32, offset: 96)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "__kind", scope: !75, file: !76, line: 32, baseType: !70, size: 32, offset: 128)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "__spins", scope: !75, file: !76, line: 34, baseType: !84, size: 16, offset: 160)
!84 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "__elision", scope: !75, file: !76, line: 35, baseType: !84, size: 16, offset: 176)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "__list", scope: !75, file: !76, line: 36, baseType: !87, size: 128, offset: 192)
!87 = !DIDerivedType(tag: DW_TAG_typedef, name: "__pthread_list_t", file: !16, line: 53, baseType: !88)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__pthread_internal_list", file: !16, line: 49, size: 128, elements: !89)
!89 = !{!90, !92}
!90 = !DIDerivedType(tag: DW_TAG_member, name: "__prev", scope: !88, file: !16, line: 51, baseType: !91, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "__next", scope: !88, file: !16, line: 52, baseType: !91, size: 64, offset: 64)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "__size", scope: !72, file: !11, line: 70, baseType: !94, size: 320)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !48, size: 320, elements: !95)
!95 = !{!96}
!96 = !DISubrange(count: 40)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "__align", scope: !72, file: !11, line: 71, baseType: !98, size: 64)
!98 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!99 = !{i32 7, !"Dwarf Version", i32 5}
!100 = !{i32 2, !"Debug Info Version", i32 3}
!101 = !{i32 1, !"wchar_size", i32 4}
!102 = !{i32 8, !"PIC Level", i32 2}
!103 = !{i32 7, !"PIE Level", i32 2}
!104 = !{i32 7, !"uwtable", i32 2}
!105 = !{i32 7, !"frame-pointer", i32 2}
!106 = !{!"clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
!107 = distinct !DISubprogram(name: "t1_main", scope: !9, file: !9, line: 19, type: !108, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !110)
!108 = !DISubroutineType(types: !109)
!109 = !{!5, !5}
!110 = !{}
!111 = !DILocalVariable(name: "unused", arg: 1, scope: !107, file: !9, line: 19, type: !5)
!112 = !DILocation(line: 19, column: 21, scope: !107)
!113 = !DILocalVariable(name: "i", scope: !114, file: !9, line: 20, type: !70)
!114 = distinct !DILexicalBlock(scope: !107, file: !9, line: 20, column: 5)
!115 = !DILocation(line: 20, column: 14, scope: !114)
!116 = !DILocation(line: 20, column: 10, scope: !114)
!117 = !DILocation(line: 20, column: 21, scope: !118)
!118 = distinct !DILexicalBlock(scope: !114, file: !9, line: 20, column: 5)
!119 = !DILocation(line: 20, column: 23, scope: !118)
!120 = !DILocation(line: 20, column: 5, scope: !114)
!121 = !DILocation(line: 22, column: 9, scope: !122)
!122 = distinct !DILexicalBlock(scope: !118, file: !9, line: 20, column: 33)
!123 = !DILocation(line: 22, column: 7, scope: !122)
!124 = !DILocation(line: 23, column: 2, scope: !122)
!125 = !DILocation(line: 24, column: 6, scope: !126)
!126 = distinct !DILexicalBlock(scope: !122, file: !9, line: 24, column: 6)
!127 = !DILocation(line: 24, column: 6, scope: !122)
!128 = !DILocation(line: 25, column: 6, scope: !129)
!129 = distinct !DILexicalBlock(scope: !126, file: !9, line: 24, column: 12)
!130 = !DILocation(line: 26, column: 2, scope: !129)
!131 = !DILocation(line: 27, column: 5, scope: !122)
!132 = !DILocation(line: 20, column: 29, scope: !118)
!133 = !DILocation(line: 20, column: 5, scope: !118)
!134 = distinct !{!134, !120, !135, !136}
!135 = !DILocation(line: 27, column: 5, scope: !114)
!136 = !{!"llvm.loop.mustprogress"}
!137 = !DILocation(line: 28, column: 5, scope: !107)
!138 = distinct !DISubprogram(name: "t2_main", scope: !9, file: !9, line: 34, type: !108, scopeLine: 34, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !110)
!139 = !DILocalVariable(name: "unused", arg: 1, scope: !138, file: !9, line: 34, type: !5)
!140 = !DILocation(line: 34, column: 21, scope: !138)
!141 = !DILocalVariable(name: "timeToWait", scope: !138, file: !9, line: 35, type: !142)
!142 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !143, line: 10, size: 128, elements: !144)
!143 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h", directory: "", checksumkind: CSK_MD5, checksum: "33f28095c70788baa6982a79b13f774b")
!144 = !{!145, !148}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !142, file: !143, line: 12, baseType: !146, size: 64)
!146 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !147, line: 160, baseType: !98)
!147 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "f6304b1a6dcfc6bee76e9a51043b5090")
!148 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !142, file: !143, line: 16, baseType: !149, size: 64, offset: 64)
!149 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !147, line: 196, baseType: !98)
!150 = !DILocation(line: 35, column: 21, scope: !138)
!151 = !DILocalVariable(name: "now", scope: !138, file: !9, line: 36, type: !152)
!152 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timeval", file: !153, line: 8, size: 128, elements: !154)
!153 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timeval.h", directory: "", checksumkind: CSK_MD5, checksum: "7798c68081a8161421218378689a8d48")
!154 = !{!155, !156}
!155 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !152, file: !153, line: 10, baseType: !146, size: 64)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "tv_usec", scope: !152, file: !153, line: 11, baseType: !157, size: 64, offset: 64)
!157 = !DIDerivedType(tag: DW_TAG_typedef, name: "__suseconds_t", file: !147, line: 162, baseType: !98)
!158 = !DILocation(line: 36, column: 20, scope: !138)
!159 = !DILocalVariable(name: "ret", scope: !138, file: !9, line: 37, type: !70)
!160 = !DILocation(line: 37, column: 9, scope: !138)
!161 = !DILocation(line: 38, column: 5, scope: !138)
!162 = !DILocalVariable(name: "nowTime", scope: !138, file: !9, line: 40, type: !163)
!163 = !DIDerivedType(tag: DW_TAG_typedef, name: "time_t", file: !164, line: 7, baseType: !146)
!164 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/time_t.h", directory: "", checksumkind: CSK_MD5, checksum: "49b4e16ef1215de5afdbb283400ab90c")
!165 = !DILocation(line: 40, column: 12, scope: !138)
!166 = !DILocation(line: 41, column: 19, scope: !138)
!167 = !DILocation(line: 41, column: 13, scope: !138)
!168 = !DILocation(line: 43, column: 25, scope: !138)
!169 = !DILocation(line: 43, column: 16, scope: !138)
!170 = !DILocation(line: 43, column: 23, scope: !138)
!171 = !DILocation(line: 44, column: 31, scope: !138)
!172 = !DILocation(line: 44, column: 38, scope: !138)
!173 = !DILocation(line: 44, column: 50, scope: !138)
!174 = !DILocation(line: 44, column: 16, scope: !138)
!175 = !DILocation(line: 44, column: 24, scope: !138)
!176 = !DILocation(line: 46, column: 5, scope: !138)
!177 = !DILocation(line: 47, column: 2, scope: !178)
!178 = distinct !DILexicalBlock(scope: !138, file: !9, line: 46, column: 15)
!179 = !DILocation(line: 48, column: 2, scope: !178)
!180 = !DILocation(line: 48, column: 10, scope: !178)
!181 = !DILocation(line: 48, column: 9, scope: !178)
!182 = !DILocation(line: 49, column: 12, scope: !183)
!183 = distinct !DILexicalBlock(scope: !178, file: !9, line: 48, column: 16)
!184 = !DILocation(line: 49, column: 10, scope: !183)
!185 = !DILocation(line: 50, column: 43, scope: !183)
!186 = !DILocation(line: 50, column: 6, scope: !183)
!187 = !DILocation(line: 51, column: 10, scope: !188)
!188 = distinct !DILexicalBlock(scope: !183, file: !9, line: 51, column: 10)
!189 = !DILocation(line: 51, column: 10, scope: !183)
!190 = !DILocation(line: 53, column: 7, scope: !191)
!191 = distinct !DILexicalBlock(scope: !192, file: !9, line: 53, column: 7)
!192 = distinct !DILexicalBlock(scope: !188, file: !9, line: 51, column: 15)
!193 = !DILocation(line: 53, column: 11, scope: !191)
!194 = !DILocation(line: 53, column: 7, scope: !192)
!195 = !DILocation(line: 54, column: 7, scope: !196)
!196 = distinct !DILexicalBlock(scope: !191, file: !9, line: 53, column: 25)
!197 = !DILocation(line: 55, column: 3, scope: !196)
!198 = !DILocation(line: 56, column: 6, scope: !192)
!199 = distinct !{!199, !179, !200, !136}
!200 = !DILocation(line: 57, column: 2, scope: !178)
!201 = !DILocation(line: 60, column: 61, scope: !178)
!202 = !DILocation(line: 61, column: 18, scope: !178)
!203 = !DILocation(line: 60, column: 2, scope: !178)
!204 = !DILocation(line: 65, column: 2, scope: !178)
!205 = distinct !{!205, !176, !206}
!206 = !DILocation(line: 66, column: 5, scope: !138)
!207 = distinct !DISubprogram(name: "main", scope: !9, file: !9, line: 108, type: !208, scopeLine: 108, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !110)
!208 = !DISubroutineType(types: !209)
!209 = !{!70, !70, !210}
!210 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !211, size: 64)
!211 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!212 = !DILocalVariable(name: "argc", arg: 1, scope: !207, file: !9, line: 108, type: !70)
!213 = !DILocation(line: 108, column: 14, scope: !207)
!214 = !DILocalVariable(name: "argv", arg: 2, scope: !207, file: !9, line: 108, type: !210)
!215 = !DILocation(line: 108, column: 26, scope: !207)
!216 = !DILocalVariable(name: "t1", scope: !207, file: !9, line: 109, type: !217)
!217 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !11, line: 27, baseType: !218)
!218 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!219 = !DILocation(line: 109, column: 15, scope: !207)
!220 = !DILocalVariable(name: "t2", scope: !207, file: !9, line: 109, type: !217)
!221 = !DILocation(line: 109, column: 19, scope: !207)
!222 = !DILocation(line: 112, column: 5, scope: !207)
!223 = !DILocation(line: 114, column: 5, scope: !207)
!224 = !DILocation(line: 116, column: 5, scope: !207)
