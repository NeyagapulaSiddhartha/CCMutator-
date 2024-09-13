; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Mutex/test/global_mut_no_bug.c'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/Mutex/test/global_mut_no_bug.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { ptr, ptr }

@mut1 = dso_local global %union.pthread_mutex_t zeroinitializer, align 8
@.str = private unnamed_addr constant [13 x i8] c"t2 has mut2\0A\00", align 1
@mut2 = dso_local global %union.pthread_mutex_t zeroinitializer, align 8
@.str.1 = private unnamed_addr constant [18 x i8] c"t2 released mut2\0A\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"t1 has mut1\0A\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"t1 has mut2\0A\00", align 1
@.str.4 = private unnamed_addr constant [18 x i8] c"t1 released mut2\0A\00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"t1 released mut1\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @t2_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mut1) #4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mut2) #4
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @mut2) #4
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mut1) #4
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  ret ptr null
}

; Function Attrs: nounwind
declare i32 @pthread_mutex_lock(ptr noundef) #1

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: nounwind
declare i32 @pthread_mutex_unlock(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @t1_main(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = call i32 @pthread_mutex_lock(ptr noundef @mut1) #4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %5 = call i32 @pthread_mutex_lock(ptr noundef @mut2) #4
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %7 = call i32 @pthread_mutex_unlock(ptr noundef @mut2) #4
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  %9 = call i32 @pthread_mutex_unlock(ptr noundef @mut1) #4
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.5)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %8 = call i32 @pthread_mutex_init(ptr noundef @mut1, ptr noundef null) #4
  %9 = call i32 @pthread_mutex_init(ptr noundef @mut2, ptr noundef null) #4
  %10 = call i32 @pthread_create(ptr noundef %6, ptr noundef null, ptr noundef @t1_main, ptr noundef null) #4
  %11 = call i32 @pthread_create(ptr noundef %7, ptr noundef null, ptr noundef @t2_main, ptr noundef null) #4
  call void @pthread_exit(ptr noundef null) #5
  unreachable
}

; Function Attrs: nounwind
declare i32 @pthread_mutex_init(ptr noundef, ptr noundef) #1

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noreturn
declare void @pthread_exit(ptr noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind }
attributes #5 = { noreturn }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
