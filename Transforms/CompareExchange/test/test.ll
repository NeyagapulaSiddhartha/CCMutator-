; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CompareExchange/test/test.cpp'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CompareExchange/test/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"struct.std::atomic" = type { %"struct.std::__atomic_base" }
%"struct.std::__atomic_base" = type { i32 }
%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type { ptr, i64 }
%"class.std::locale" = type { ptr }

$_ZNKSt13__atomic_baseIiEcviEv = comdat any

$_ZSt9boolalphaRSt8ios_base = comdat any

$_ZNSt13__atomic_baseIiEaSEi = comdat any

$_ZNSt8ios_base4setfESt13_Ios_Fmtflags = comdat any

$_ZStoRRSt13_Ios_FmtflagsS_ = comdat any

$_ZStorSt13_Ios_FmtflagsS_ = comdat any

$_ZStanSt12memory_orderSt23__memory_order_modifier = comdat any

$__clang_call_terminate = comdat any

$_ZSt23__cmpexch_failure_orderSt12memory_order = comdat any

$_ZStorSt12memory_orderSt23__memory_order_modifier = comdat any

$_ZSt24__cmpexch_failure_order2St12memory_order = comdat any

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external hidden global i8
@ai = dso_local global %"struct.std::atomic" zeroinitializer, align 4
@tst_val = dso_local global i32 4, align 4
@new_val = dso_local global i32 5, align 4
@exchanged = dso_local global i8 0, align 1
@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [5 x i8] c"ai= \00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"  tst_val= \00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"  new_val= \00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"  exchanged= \00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @_GLOBAL__sub_I_test.cpp, ptr null }]

; Function Attrs: noinline uwtable
define internal void @__cxx_global_var_init() #0 section ".text.startup" {
  call void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1) @_ZStL8__ioinit)
  %1 = call i32 @__cxa_atexit(ptr @_ZNSt8ios_base4InitD1Ev, ptr @_ZStL8__ioinit, ptr @__dso_handle) #3
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(ptr noundef nonnull align 1 dereferenceable(1)) unnamed_addr #2

; Function Attrs: nounwind
declare i32 @__cxa_atexit(ptr, ptr, ptr) #3

; Function Attrs: mustprogress noinline optnone uwtable
define dso_local void @_Z7valsoutv() #4 {
  %1 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef @.str)
  %2 = call noundef i32 @_ZNKSt13__atomic_baseIiEcviEv(ptr noundef nonnull align 4 dereferenceable(4) @ai) #3
  %3 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8) %1, i32 noundef %2)
  %4 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8) %3, ptr noundef @.str.1)
  %5 = load i32, ptr @tst_val, align 4
  %6 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8) %4, i32 noundef %5)
  %7 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8) %6, ptr noundef @.str.2)
  %8 = load i32, ptr @new_val, align 4
  %9 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8) %7, i32 noundef %8)
  %10 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8) %9, ptr noundef @.str.3)
  %11 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSt8ios_baseS0_E(ptr noundef nonnull align 8 dereferenceable(8) %10, ptr noundef @_ZSt9boolalphaRSt8ios_base)
  %12 = load i8, ptr @exchanged, align 1
  %13 = trunc i8 %12 to i1
  %14 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEb(ptr noundef nonnull align 8 dereferenceable(8) %11, i1 noundef zeroext %13)
  %15 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8) %14, ptr noundef @.str.4)
  ret void
}

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef) #1

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8), i32 noundef) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZNKSt13__atomic_baseIiEcviEv(ptr noundef nonnull align 4 dereferenceable(4) %0) #5 comdat align 2 personality ptr @__gxx_personality_v0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  %7 = load ptr, ptr %6, align 8
  store ptr %7, ptr %2, align 8
  store i32 5, ptr %3, align 4
  %8 = load ptr, ptr %2, align 8
  %9 = load i32, ptr %3, align 4
  %10 = invoke noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %9, i32 noundef 65535)
          to label %11 unwind label %19

11:                                               ; preds = %1
  store i32 %10, ptr %4, align 4
  %12 = load i32, ptr %3, align 4
  switch i32 %12, label %13 [
    i32 1, label %15
    i32 2, label %15
    i32 5, label %17
  ]

13:                                               ; preds = %11
  %14 = load atomic i32, ptr %8 monotonic, align 4
  store i32 %14, ptr %5, align 4
  br label %22

15:                                               ; preds = %11, %11
  %16 = load atomic i32, ptr %8 acquire, align 4
  store i32 %16, ptr %5, align 4
  br label %22

17:                                               ; preds = %11
  %18 = load atomic i32, ptr %8 seq_cst, align 4
  store i32 %18, ptr %5, align 4
  br label %22

19:                                               ; preds = %1
  %20 = landingpad { ptr, i32 }
          catch ptr null
  %21 = extractvalue { ptr, i32 } %20, 0
  call void @__clang_call_terminate(ptr %21) #8
  unreachable

22:                                               ; preds = %13, %15, %17
  %23 = load i32, ptr %5, align 4
  ret i32 %23
}

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEPFRSt8ios_baseS0_E(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef) #1

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef nonnull align 8 dereferenceable(216) ptr @_ZSt9boolalphaRSt8ios_base(ptr noundef nonnull align 8 dereferenceable(216) %0) #4 comdat {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call noundef i32 @_ZNSt8ios_base4setfESt13_Ios_Fmtflags(ptr noundef nonnull align 8 dereferenceable(216) %3, i32 noundef 1)
  %5 = load ptr, ptr %2, align 8
  ret ptr %5
}

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEb(ptr noundef nonnull align 8 dereferenceable(8), i1 noundef zeroext) #1

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main() #6 {
  %1 = alloca ptr, align 8
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i8, align 1
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca ptr, align 8
  %24 = alloca ptr, align 8
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  store i32 0, ptr %27, align 4
  %28 = call noundef i32 @_ZNSt13__atomic_baseIiEaSEi(ptr noundef nonnull align 4 dereferenceable(4) @ai, i32 noundef 3) #3
  call void @_Z7valsoutv()
  %29 = load i32, ptr @new_val, align 4
  store ptr @ai, ptr %19, align 8
  store ptr @tst_val, ptr %20, align 8
  store i32 %29, ptr %21, align 4
  store i32 5, ptr %22, align 4
  %30 = load ptr, ptr %19, align 8
  %31 = load ptr, ptr %20, align 8
  %32 = load i32, ptr %21, align 4
  %33 = load i32, ptr %22, align 4
  %34 = load i32, ptr %22, align 4
  %35 = call noundef i32 @_ZSt23__cmpexch_failure_orderSt12memory_order(i32 noundef %34) #3
  store ptr %30, ptr %10, align 8
  store ptr %31, ptr %11, align 8
  store i32 %32, ptr %12, align 4
  store i32 %33, ptr %13, align 4
  store i32 %35, ptr %14, align 4
  %36 = load ptr, ptr %10, align 8
  %37 = load i32, ptr %14, align 4
  %38 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %37, i32 noundef 65535)
  store i32 %38, ptr %15, align 4
  %39 = load i32, ptr %13, align 4
  %40 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %39, i32 noundef 65535)
  store i32 %40, ptr %16, align 4
  %41 = load i32, ptr %13, align 4
  %42 = load ptr, ptr %11, align 8
  %43 = load i32, ptr %12, align 4
  store i32 %43, ptr %17, align 4
  %44 = load i32, ptr %14, align 4
  switch i32 %41, label %45 [
    i32 1, label %46
    i32 2, label %46
    i32 3, label %47
    i32 4, label %48
    i32 5, label %49
  ]

45:                                               ; preds = %0
  switch i32 %44, label %50 [
    i32 1, label %56
    i32 2, label %56
    i32 5, label %62
  ]

46:                                               ; preds = %0, %0
  switch i32 %44, label %78 [
    i32 1, label %84
    i32 2, label %84
    i32 5, label %90
  ]

47:                                               ; preds = %0
  switch i32 %44, label %106 [
    i32 1, label %112
    i32 2, label %112
    i32 5, label %118
  ]

48:                                               ; preds = %0
  switch i32 %44, label %134 [
    i32 1, label %140
    i32 2, label %140
    i32 5, label %146
  ]

49:                                               ; preds = %0
  switch i32 %44, label %162 [
    i32 1, label %168
    i32 2, label %168
    i32 5, label %174
  ]

50:                                               ; preds = %45
  %51 = load i32, ptr %42, align 4
  %52 = load i32, ptr %17, align 4
  %53 = cmpxchg ptr %36, i32 %51, i32 %52 monotonic monotonic, align 4
  %54 = extractvalue { i32, i1 } %53, 0
  %55 = extractvalue { i32, i1 } %53, 1
  br i1 %55, label %70, label %69

56:                                               ; preds = %45, %45
  %57 = load i32, ptr %42, align 4
  %58 = load i32, ptr %17, align 4
  %59 = cmpxchg ptr %36, i32 %57, i32 %58 monotonic acquire, align 4
  %60 = extractvalue { i32, i1 } %59, 0
  %61 = extractvalue { i32, i1 } %59, 1
  br i1 %61, label %73, label %72

62:                                               ; preds = %45
  %63 = load i32, ptr %42, align 4
  %64 = load i32, ptr %17, align 4
  %65 = cmpxchg ptr %36, i32 %63, i32 %64 monotonic seq_cst, align 4
  %66 = extractvalue { i32, i1 } %65, 0
  %67 = extractvalue { i32, i1 } %65, 1
  br i1 %67, label %76, label %75

68:                                               ; preds = %76, %73, %70
  br label %190

69:                                               ; preds = %50
  store i32 %54, ptr %42, align 4
  br label %70

70:                                               ; preds = %69, %50
  %71 = zext i1 %55 to i8
  store i8 %71, ptr %18, align 1
  br label %68

72:                                               ; preds = %56
  store i32 %60, ptr %42, align 4
  br label %73

73:                                               ; preds = %72, %56
  %74 = zext i1 %61 to i8
  store i8 %74, ptr %18, align 1
  br label %68

75:                                               ; preds = %62
  store i32 %66, ptr %42, align 4
  br label %76

76:                                               ; preds = %75, %62
  %77 = zext i1 %67 to i8
  store i8 %77, ptr %18, align 1
  br label %68

78:                                               ; preds = %46
  %79 = load i32, ptr %42, align 4
  %80 = load i32, ptr %17, align 4
  %81 = cmpxchg ptr %36, i32 %79, i32 %80 acquire monotonic, align 4
  %82 = extractvalue { i32, i1 } %81, 0
  %83 = extractvalue { i32, i1 } %81, 1
  br i1 %83, label %98, label %97

84:                                               ; preds = %46, %46
  %85 = load i32, ptr %42, align 4
  %86 = load i32, ptr %17, align 4
  %87 = cmpxchg ptr %36, i32 %85, i32 %86 acquire acquire, align 4
  %88 = extractvalue { i32, i1 } %87, 0
  %89 = extractvalue { i32, i1 } %87, 1
  br i1 %89, label %101, label %100

90:                                               ; preds = %46
  %91 = load i32, ptr %42, align 4
  %92 = load i32, ptr %17, align 4
  %93 = cmpxchg ptr %36, i32 %91, i32 %92 acquire seq_cst, align 4
  %94 = extractvalue { i32, i1 } %93, 0
  %95 = extractvalue { i32, i1 } %93, 1
  br i1 %95, label %104, label %103

96:                                               ; preds = %104, %101, %98
  br label %190

97:                                               ; preds = %78
  store i32 %82, ptr %42, align 4
  br label %98

98:                                               ; preds = %97, %78
  %99 = zext i1 %83 to i8
  store i8 %99, ptr %18, align 1
  br label %96

100:                                              ; preds = %84
  store i32 %88, ptr %42, align 4
  br label %101

101:                                              ; preds = %100, %84
  %102 = zext i1 %89 to i8
  store i8 %102, ptr %18, align 1
  br label %96

103:                                              ; preds = %90
  store i32 %94, ptr %42, align 4
  br label %104

104:                                              ; preds = %103, %90
  %105 = zext i1 %95 to i8
  store i8 %105, ptr %18, align 1
  br label %96

106:                                              ; preds = %47
  %107 = load i32, ptr %42, align 4
  %108 = load i32, ptr %17, align 4
  %109 = cmpxchg ptr %36, i32 %107, i32 %108 release monotonic, align 4
  %110 = extractvalue { i32, i1 } %109, 0
  %111 = extractvalue { i32, i1 } %109, 1
  br i1 %111, label %126, label %125

112:                                              ; preds = %47, %47
  %113 = load i32, ptr %42, align 4
  %114 = load i32, ptr %17, align 4
  %115 = cmpxchg ptr %36, i32 %113, i32 %114 release acquire, align 4
  %116 = extractvalue { i32, i1 } %115, 0
  %117 = extractvalue { i32, i1 } %115, 1
  br i1 %117, label %129, label %128

118:                                              ; preds = %47
  %119 = load i32, ptr %42, align 4
  %120 = load i32, ptr %17, align 4
  %121 = cmpxchg ptr %36, i32 %119, i32 %120 release seq_cst, align 4
  %122 = extractvalue { i32, i1 } %121, 0
  %123 = extractvalue { i32, i1 } %121, 1
  br i1 %123, label %132, label %131

124:                                              ; preds = %132, %129, %126
  br label %190

125:                                              ; preds = %106
  store i32 %110, ptr %42, align 4
  br label %126

126:                                              ; preds = %125, %106
  %127 = zext i1 %111 to i8
  store i8 %127, ptr %18, align 1
  br label %124

128:                                              ; preds = %112
  store i32 %116, ptr %42, align 4
  br label %129

129:                                              ; preds = %128, %112
  %130 = zext i1 %117 to i8
  store i8 %130, ptr %18, align 1
  br label %124

131:                                              ; preds = %118
  store i32 %122, ptr %42, align 4
  br label %132

132:                                              ; preds = %131, %118
  %133 = zext i1 %123 to i8
  store i8 %133, ptr %18, align 1
  br label %124

134:                                              ; preds = %48
  %135 = load i32, ptr %42, align 4
  %136 = load i32, ptr %17, align 4
  %137 = cmpxchg ptr %36, i32 %135, i32 %136 acq_rel monotonic, align 4
  %138 = extractvalue { i32, i1 } %137, 0
  %139 = extractvalue { i32, i1 } %137, 1
  br i1 %139, label %154, label %153

140:                                              ; preds = %48, %48
  %141 = load i32, ptr %42, align 4
  %142 = load i32, ptr %17, align 4
  %143 = cmpxchg ptr %36, i32 %141, i32 %142 acq_rel acquire, align 4
  %144 = extractvalue { i32, i1 } %143, 0
  %145 = extractvalue { i32, i1 } %143, 1
  br i1 %145, label %157, label %156

146:                                              ; preds = %48
  %147 = load i32, ptr %42, align 4
  %148 = load i32, ptr %17, align 4
  %149 = cmpxchg ptr %36, i32 %147, i32 %148 acq_rel seq_cst, align 4
  %150 = extractvalue { i32, i1 } %149, 0
  %151 = extractvalue { i32, i1 } %149, 1
  br i1 %151, label %160, label %159

152:                                              ; preds = %160, %157, %154
  br label %190

153:                                              ; preds = %134
  store i32 %138, ptr %42, align 4
  br label %154

154:                                              ; preds = %153, %134
  %155 = zext i1 %139 to i8
  store i8 %155, ptr %18, align 1
  br label %152

156:                                              ; preds = %140
  store i32 %144, ptr %42, align 4
  br label %157

157:                                              ; preds = %156, %140
  %158 = zext i1 %145 to i8
  store i8 %158, ptr %18, align 1
  br label %152

159:                                              ; preds = %146
  store i32 %150, ptr %42, align 4
  br label %160

160:                                              ; preds = %159, %146
  %161 = zext i1 %151 to i8
  store i8 %161, ptr %18, align 1
  br label %152

162:                                              ; preds = %49
  %163 = load i32, ptr %42, align 4
  %164 = load i32, ptr %17, align 4
  %165 = cmpxchg ptr %36, i32 %163, i32 %164 seq_cst monotonic, align 4
  %166 = extractvalue { i32, i1 } %165, 0
  %167 = extractvalue { i32, i1 } %165, 1
  br i1 %167, label %182, label %181

168:                                              ; preds = %49, %49
  %169 = load i32, ptr %42, align 4
  %170 = load i32, ptr %17, align 4
  %171 = cmpxchg ptr %36, i32 %169, i32 %170 seq_cst acquire, align 4
  %172 = extractvalue { i32, i1 } %171, 0
  %173 = extractvalue { i32, i1 } %171, 1
  br i1 %173, label %185, label %184

174:                                              ; preds = %49
  %175 = load i32, ptr %42, align 4
  %176 = load i32, ptr %17, align 4
  %177 = cmpxchg ptr %36, i32 %175, i32 %176 seq_cst seq_cst, align 4
  %178 = extractvalue { i32, i1 } %177, 0
  %179 = extractvalue { i32, i1 } %177, 1
  br i1 %179, label %188, label %187

180:                                              ; preds = %188, %185, %182
  br label %190

181:                                              ; preds = %162
  store i32 %166, ptr %42, align 4
  br label %182

182:                                              ; preds = %181, %162
  %183 = zext i1 %167 to i8
  store i8 %183, ptr %18, align 1
  br label %180

184:                                              ; preds = %168
  store i32 %172, ptr %42, align 4
  br label %185

185:                                              ; preds = %184, %168
  %186 = zext i1 %173 to i8
  store i8 %186, ptr %18, align 1
  br label %180

187:                                              ; preds = %174
  store i32 %178, ptr %42, align 4
  br label %188

188:                                              ; preds = %187, %174
  %189 = zext i1 %179 to i8
  store i8 %189, ptr %18, align 1
  br label %180

190:                                              ; preds = %68, %96, %124, %152, %180
  %191 = load i8, ptr %18, align 1
  %192 = trunc i8 %191 to i1
  %193 = zext i1 %192 to i8
  store i8 %193, ptr @exchanged, align 1
  call void @_Z7valsoutv()
  %194 = load i32, ptr @new_val, align 4
  store ptr @ai, ptr %23, align 8
  store ptr @tst_val, ptr %24, align 8
  store i32 %194, ptr %25, align 4
  store i32 5, ptr %26, align 4
  %195 = load ptr, ptr %23, align 8
  %196 = load ptr, ptr %24, align 8
  %197 = load i32, ptr %25, align 4
  %198 = load i32, ptr %26, align 4
  %199 = load i32, ptr %26, align 4
  %200 = call noundef i32 @_ZSt23__cmpexch_failure_orderSt12memory_order(i32 noundef %199) #3
  store ptr %195, ptr %1, align 8
  store ptr %196, ptr %2, align 8
  store i32 %197, ptr %3, align 4
  store i32 %198, ptr %4, align 4
  store i32 %200, ptr %5, align 4
  %201 = load ptr, ptr %1, align 8
  %202 = load i32, ptr %5, align 4
  %203 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %202, i32 noundef 65535)
  store i32 %203, ptr %6, align 4
  %204 = load i32, ptr %4, align 4
  %205 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %204, i32 noundef 65535)
  store i32 %205, ptr %7, align 4
  %206 = load i32, ptr %4, align 4
  %207 = load ptr, ptr %2, align 8
  %208 = load i32, ptr %3, align 4
  store i32 %208, ptr %8, align 4
  %209 = load i32, ptr %5, align 4
  switch i32 %206, label %210 [
    i32 1, label %211
    i32 2, label %211
    i32 3, label %212
    i32 4, label %213
    i32 5, label %214
  ]

210:                                              ; preds = %190
  switch i32 %209, label %215 [
    i32 1, label %221
    i32 2, label %221
    i32 5, label %227
  ]

211:                                              ; preds = %190, %190
  switch i32 %209, label %243 [
    i32 1, label %249
    i32 2, label %249
    i32 5, label %255
  ]

212:                                              ; preds = %190
  switch i32 %209, label %271 [
    i32 1, label %277
    i32 2, label %277
    i32 5, label %283
  ]

213:                                              ; preds = %190
  switch i32 %209, label %299 [
    i32 1, label %305
    i32 2, label %305
    i32 5, label %311
  ]

214:                                              ; preds = %190
  switch i32 %209, label %327 [
    i32 1, label %333
    i32 2, label %333
    i32 5, label %339
  ]

215:                                              ; preds = %210
  %216 = load i32, ptr %207, align 4
  %217 = load i32, ptr %8, align 4
  %218 = cmpxchg ptr %201, i32 %216, i32 %217 monotonic monotonic, align 4
  %219 = extractvalue { i32, i1 } %218, 0
  %220 = extractvalue { i32, i1 } %218, 1
  br i1 %220, label %235, label %234

221:                                              ; preds = %210, %210
  %222 = load i32, ptr %207, align 4
  %223 = load i32, ptr %8, align 4
  %224 = cmpxchg ptr %201, i32 %222, i32 %223 monotonic acquire, align 4
  %225 = extractvalue { i32, i1 } %224, 0
  %226 = extractvalue { i32, i1 } %224, 1
  br i1 %226, label %238, label %237

227:                                              ; preds = %210
  %228 = load i32, ptr %207, align 4
  %229 = load i32, ptr %8, align 4
  %230 = cmpxchg ptr %201, i32 %228, i32 %229 monotonic seq_cst, align 4
  %231 = extractvalue { i32, i1 } %230, 0
  %232 = extractvalue { i32, i1 } %230, 1
  br i1 %232, label %241, label %240

233:                                              ; preds = %241, %238, %235
  br label %355

234:                                              ; preds = %215
  store i32 %219, ptr %207, align 4
  br label %235

235:                                              ; preds = %234, %215
  %236 = zext i1 %220 to i8
  store i8 %236, ptr %9, align 1
  br label %233

237:                                              ; preds = %221
  store i32 %225, ptr %207, align 4
  br label %238

238:                                              ; preds = %237, %221
  %239 = zext i1 %226 to i8
  store i8 %239, ptr %9, align 1
  br label %233

240:                                              ; preds = %227
  store i32 %231, ptr %207, align 4
  br label %241

241:                                              ; preds = %240, %227
  %242 = zext i1 %232 to i8
  store i8 %242, ptr %9, align 1
  br label %233

243:                                              ; preds = %211
  %244 = load i32, ptr %207, align 4
  %245 = load i32, ptr %8, align 4
  %246 = cmpxchg ptr %201, i32 %244, i32 %245 acquire monotonic, align 4
  %247 = extractvalue { i32, i1 } %246, 0
  %248 = extractvalue { i32, i1 } %246, 1
  br i1 %248, label %263, label %262

249:                                              ; preds = %211, %211
  %250 = load i32, ptr %207, align 4
  %251 = load i32, ptr %8, align 4
  %252 = cmpxchg ptr %201, i32 %250, i32 %251 acquire acquire, align 4
  %253 = extractvalue { i32, i1 } %252, 0
  %254 = extractvalue { i32, i1 } %252, 1
  br i1 %254, label %266, label %265

255:                                              ; preds = %211
  %256 = load i32, ptr %207, align 4
  %257 = load i32, ptr %8, align 4
  %258 = cmpxchg ptr %201, i32 %256, i32 %257 acquire seq_cst, align 4
  %259 = extractvalue { i32, i1 } %258, 0
  %260 = extractvalue { i32, i1 } %258, 1
  br i1 %260, label %269, label %268

261:                                              ; preds = %269, %266, %263
  br label %355

262:                                              ; preds = %243
  store i32 %247, ptr %207, align 4
  br label %263

263:                                              ; preds = %262, %243
  %264 = zext i1 %248 to i8
  store i8 %264, ptr %9, align 1
  br label %261

265:                                              ; preds = %249
  store i32 %253, ptr %207, align 4
  br label %266

266:                                              ; preds = %265, %249
  %267 = zext i1 %254 to i8
  store i8 %267, ptr %9, align 1
  br label %261

268:                                              ; preds = %255
  store i32 %259, ptr %207, align 4
  br label %269

269:                                              ; preds = %268, %255
  %270 = zext i1 %260 to i8
  store i8 %270, ptr %9, align 1
  br label %261

271:                                              ; preds = %212
  %272 = load i32, ptr %207, align 4
  %273 = load i32, ptr %8, align 4
  %274 = cmpxchg ptr %201, i32 %272, i32 %273 release monotonic, align 4
  %275 = extractvalue { i32, i1 } %274, 0
  %276 = extractvalue { i32, i1 } %274, 1
  br i1 %276, label %291, label %290

277:                                              ; preds = %212, %212
  %278 = load i32, ptr %207, align 4
  %279 = load i32, ptr %8, align 4
  %280 = cmpxchg ptr %201, i32 %278, i32 %279 release acquire, align 4
  %281 = extractvalue { i32, i1 } %280, 0
  %282 = extractvalue { i32, i1 } %280, 1
  br i1 %282, label %294, label %293

283:                                              ; preds = %212
  %284 = load i32, ptr %207, align 4
  %285 = load i32, ptr %8, align 4
  %286 = cmpxchg ptr %201, i32 %284, i32 %285 release seq_cst, align 4
  %287 = extractvalue { i32, i1 } %286, 0
  %288 = extractvalue { i32, i1 } %286, 1
  br i1 %288, label %297, label %296

289:                                              ; preds = %297, %294, %291
  br label %355

290:                                              ; preds = %271
  store i32 %275, ptr %207, align 4
  br label %291

291:                                              ; preds = %290, %271
  %292 = zext i1 %276 to i8
  store i8 %292, ptr %9, align 1
  br label %289

293:                                              ; preds = %277
  store i32 %281, ptr %207, align 4
  br label %294

294:                                              ; preds = %293, %277
  %295 = zext i1 %282 to i8
  store i8 %295, ptr %9, align 1
  br label %289

296:                                              ; preds = %283
  store i32 %287, ptr %207, align 4
  br label %297

297:                                              ; preds = %296, %283
  %298 = zext i1 %288 to i8
  store i8 %298, ptr %9, align 1
  br label %289

299:                                              ; preds = %213
  %300 = load i32, ptr %207, align 4
  %301 = load i32, ptr %8, align 4
  %302 = cmpxchg ptr %201, i32 %300, i32 %301 acq_rel monotonic, align 4
  %303 = extractvalue { i32, i1 } %302, 0
  %304 = extractvalue { i32, i1 } %302, 1
  br i1 %304, label %319, label %318

305:                                              ; preds = %213, %213
  %306 = load i32, ptr %207, align 4
  %307 = load i32, ptr %8, align 4
  %308 = cmpxchg ptr %201, i32 %306, i32 %307 acq_rel acquire, align 4
  %309 = extractvalue { i32, i1 } %308, 0
  %310 = extractvalue { i32, i1 } %308, 1
  br i1 %310, label %322, label %321

311:                                              ; preds = %213
  %312 = load i32, ptr %207, align 4
  %313 = load i32, ptr %8, align 4
  %314 = cmpxchg ptr %201, i32 %312, i32 %313 acq_rel seq_cst, align 4
  %315 = extractvalue { i32, i1 } %314, 0
  %316 = extractvalue { i32, i1 } %314, 1
  br i1 %316, label %325, label %324

317:                                              ; preds = %325, %322, %319
  br label %355

318:                                              ; preds = %299
  store i32 %303, ptr %207, align 4
  br label %319

319:                                              ; preds = %318, %299
  %320 = zext i1 %304 to i8
  store i8 %320, ptr %9, align 1
  br label %317

321:                                              ; preds = %305
  store i32 %309, ptr %207, align 4
  br label %322

322:                                              ; preds = %321, %305
  %323 = zext i1 %310 to i8
  store i8 %323, ptr %9, align 1
  br label %317

324:                                              ; preds = %311
  store i32 %315, ptr %207, align 4
  br label %325

325:                                              ; preds = %324, %311
  %326 = zext i1 %316 to i8
  store i8 %326, ptr %9, align 1
  br label %317

327:                                              ; preds = %214
  %328 = load i32, ptr %207, align 4
  %329 = load i32, ptr %8, align 4
  %330 = cmpxchg ptr %201, i32 %328, i32 %329 seq_cst monotonic, align 4
  %331 = extractvalue { i32, i1 } %330, 0
  %332 = extractvalue { i32, i1 } %330, 1
  br i1 %332, label %347, label %346

333:                                              ; preds = %214, %214
  %334 = load i32, ptr %207, align 4
  %335 = load i32, ptr %8, align 4
  %336 = cmpxchg ptr %201, i32 %334, i32 %335 seq_cst acquire, align 4
  %337 = extractvalue { i32, i1 } %336, 0
  %338 = extractvalue { i32, i1 } %336, 1
  br i1 %338, label %350, label %349

339:                                              ; preds = %214
  %340 = load i32, ptr %207, align 4
  %341 = load i32, ptr %8, align 4
  %342 = cmpxchg ptr %201, i32 %340, i32 %341 seq_cst seq_cst, align 4
  %343 = extractvalue { i32, i1 } %342, 0
  %344 = extractvalue { i32, i1 } %342, 1
  br i1 %344, label %353, label %352

345:                                              ; preds = %353, %350, %347
  br label %355

346:                                              ; preds = %327
  store i32 %331, ptr %207, align 4
  br label %347

347:                                              ; preds = %346, %327
  %348 = zext i1 %332 to i8
  store i8 %348, ptr %9, align 1
  br label %345

349:                                              ; preds = %333
  store i32 %337, ptr %207, align 4
  br label %350

350:                                              ; preds = %349, %333
  %351 = zext i1 %338 to i8
  store i8 %351, ptr %9, align 1
  br label %345

352:                                              ; preds = %339
  store i32 %343, ptr %207, align 4
  br label %353

353:                                              ; preds = %352, %339
  %354 = zext i1 %344 to i8
  store i8 %354, ptr %9, align 1
  br label %345

355:                                              ; preds = %233, %261, %289, %317, %345
  %356 = load i8, ptr %9, align 1
  %357 = trunc i8 %356 to i1
  %358 = zext i1 %357 to i8
  store i8 %358, ptr @exchanged, align 1
  call void @_Z7valsoutv()
  ret i32 0
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZNSt13__atomic_baseIiEaSEi(ptr noundef nonnull align 4 dereferenceable(4) %0, i32 noundef %1) #5 comdat align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  store ptr %0, ptr %8, align 8
  store i32 %1, ptr %9, align 4
  %10 = load ptr, ptr %8, align 8
  %11 = load i32, ptr %9, align 4
  store ptr %10, ptr %3, align 8
  store i32 %11, ptr %4, align 4
  store i32 5, ptr %5, align 4
  %12 = load ptr, ptr %3, align 8
  %13 = load i32, ptr %5, align 4
  %14 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %13, i32 noundef 65535)
  store i32 %14, ptr %6, align 4
  %15 = load i32, ptr %5, align 4
  %16 = load i32, ptr %4, align 4
  store i32 %16, ptr %7, align 4
  switch i32 %15, label %17 [
    i32 3, label %19
    i32 5, label %21
  ]

17:                                               ; preds = %2
  %18 = load i32, ptr %7, align 4
  store atomic i32 %18, ptr %12 monotonic, align 4
  br label %23

19:                                               ; preds = %2
  %20 = load i32, ptr %7, align 4
  store atomic i32 %20, ptr %12 release, align 4
  br label %23

21:                                               ; preds = %2
  %22 = load i32, ptr %7, align 4
  store atomic i32 %22, ptr %12 seq_cst, align 4
  br label %23

23:                                               ; preds = %17, %19, %21
  %24 = load i32, ptr %9, align 4
  ret i32 %24
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZNSt8ios_base4setfESt13_Ios_Fmtflags(ptr noundef nonnull align 8 dereferenceable(216) %0, i32 noundef %1) #4 comdat align 2 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %"class.std::ios_base", ptr %6, i32 0, i32 3
  %8 = load i32, ptr %7, align 8
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %4, align 4
  %10 = getelementptr inbounds %"class.std::ios_base", ptr %6, i32 0, i32 3
  %11 = call noundef nonnull align 4 dereferenceable(4) ptr @_ZStoRRSt13_Ios_FmtflagsS_(ptr noundef nonnull align 4 dereferenceable(4) %10, i32 noundef %9)
  %12 = load i32, ptr %5, align 4
  ret i32 %12
}

; Function Attrs: mustprogress noinline optnone uwtable
define linkonce_odr dso_local noundef nonnull align 4 dereferenceable(4) ptr @_ZStoRRSt13_Ios_FmtflagsS_(ptr noundef nonnull align 4 dereferenceable(4) %0, i32 noundef %1) #4 comdat {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = load i32, ptr %5, align 4
  %7 = load i32, ptr %4, align 4
  %8 = call noundef i32 @_ZStorSt13_Ios_FmtflagsS_(i32 noundef %6, i32 noundef %7)
  %9 = load ptr, ptr %3, align 8
  store i32 %8, ptr %9, align 4
  ret ptr %9
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZStorSt13_Ios_FmtflagsS_(i32 noundef %0, i32 noundef %1) #5 comdat {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = or i32 %5, %6
  ret i32 %7
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %0, i32 noundef %1) #5 comdat {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = and i32 %5, %6
  ret i32 %7
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind uwtable
define linkonce_odr hidden void @__clang_call_terminate(ptr noundef %0) #7 comdat {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #3
  call void @_ZSt9terminatev() #8
  unreachable
}

declare ptr @__cxa_begin_catch(ptr)

declare void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZSt23__cmpexch_failure_orderSt12memory_order(i32 noundef %0) #5 comdat personality ptr @__gxx_personality_v0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %3, i32 noundef 65535)
  %5 = call noundef i32 @_ZSt24__cmpexch_failure_order2St12memory_order(i32 noundef %4) #3
  %6 = load i32, ptr %2, align 4
  %7 = call noundef i32 @_ZStanSt12memory_orderSt23__memory_order_modifier(i32 noundef %6, i32 noundef -65536)
  %8 = invoke noundef i32 @_ZStorSt12memory_orderSt23__memory_order_modifier(i32 noundef %5, i32 noundef %7)
          to label %9 unwind label %10

9:                                                ; preds = %1
  ret i32 %8

10:                                               ; preds = %1
  %11 = landingpad { ptr, i32 }
          catch ptr null
  %12 = extractvalue { ptr, i32 } %11, 0
  call void @__clang_call_terminate(ptr %12) #8
  unreachable
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZStorSt12memory_orderSt23__memory_order_modifier(i32 noundef %0, i32 noundef %1) #5 comdat {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = or i32 %5, %6
  ret i32 %7
}

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_ZSt24__cmpexch_failure_order2St12memory_order(i32 noundef %0) #5 comdat {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %14

6:                                                ; preds = %1
  %7 = load i32, ptr %2, align 4
  %8 = icmp eq i32 %7, 3
  br i1 %8, label %9, label %10

9:                                                ; preds = %6
  br label %12

10:                                               ; preds = %6
  %11 = load i32, ptr %2, align 4
  br label %12

12:                                               ; preds = %10, %9
  %13 = phi i32 [ 0, %9 ], [ %11, %10 ]
  br label %14

14:                                               ; preds = %12, %5
  %15 = phi i32 [ 2, %5 ], [ %13, %12 ]
  ret i32 %15
}

; Function Attrs: noinline uwtable
define internal void @_GLOBAL__sub_I_test.cpp() #0 section ".text.startup" {
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }
attributes #4 = { mustprogress noinline optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noinline noreturn nounwind uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0 (git@github.com:llvm/llvm-project.git 88bf774c565080e30e0a073676c316ab175303af)"}
