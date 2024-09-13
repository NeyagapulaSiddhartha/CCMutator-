; ModuleID = '/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CompareExchange/test/test.ll'
source_filename = "/home/cs23mtech12010/CCM/CCMutator/llvm-project/llvm/lib/Transforms/CompareExchange/test/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-conda-linux-gnu"

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
  call void @__clang_call_terminate(ptr %21) #9
  unreachable

22:                                               ; preds = %17, %15, %13
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
  %7 = alloca i8, align 1
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i8, align 1
  %15 = alloca ptr, align 8
  %16 = alloca ptr, align 8
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca ptr, align 8
  %20 = alloca ptr, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store i32 0, ptr %23, align 4
  %24 = call noundef i32 @_ZNSt13__atomic_baseIiEaSEi(ptr noundef nonnull align 4 dereferenceable(4) @ai, i32 noundef 3) #3
  call void @_Z7valsoutv()
  %25 = load i32, ptr @new_val, align 4
  store ptr @ai, ptr %15, align 8
  store ptr @tst_val, ptr %16, align 8
  store i32 %25, ptr %17, align 4
  store i32 5, ptr %18, align 4
  %26 = load ptr, ptr %15, align 8
  %27 = load ptr, ptr %16, align 8
  %28 = load i32, ptr %17, align 4
  %29 = load i32, ptr %18, align 4
  %30 = load i32, ptr %18, align 4
  %31 = call noundef i32 @_ZSt23__cmpexch_failure_orderSt12memory_order(i32 noundef %30) #3
  store ptr %26, ptr %8, align 8
  store ptr %27, ptr %9, align 8
  store i32 %28, ptr %10, align 4
  store i32 %29, ptr %11, align 4
  store i32 %31, ptr %12, align 4
  %32 = load ptr, ptr %8, align 8
  %33 = load i32, ptr %11, align 4
  %34 = load ptr, ptr %9, align 8
  %35 = load i32, ptr %10, align 4
  store i32 %35, ptr %13, align 4
  %36 = load i32, ptr %12, align 4
  switch i32 %33, label %37 [
    i32 1, label %38
    i32 2, label %38
    i32 3, label %39
    i32 4, label %40
    i32 5, label %41
  ]

37:                                               ; preds = %0
  switch i32 %36, label %42 [
    i32 1, label %48
    i32 2, label %48
    i32 5, label %54
  ]

38:                                               ; preds = %0, %0
  switch i32 %36, label %70 [
    i32 1, label %76
    i32 2, label %76
    i32 5, label %82
  ]

39:                                               ; preds = %0
  switch i32 %36, label %98 [
    i32 1, label %104
    i32 2, label %104
    i32 5, label %110
  ]

40:                                               ; preds = %0
  switch i32 %36, label %126 [
    i32 1, label %132
    i32 2, label %132
    i32 5, label %138
  ]

41:                                               ; preds = %0
  switch i32 %36, label %154 [
    i32 1, label %160
    i32 2, label %160
    i32 5, label %166
  ]

42:                                               ; preds = %37
  %43 = load i32, ptr %34, align 4
  %44 = load i32, ptr %13, align 4
  %45 = cmpxchg ptr %32, i32 %43, i32 %44 acq_rel monotonic, align 4
  %46 = extractvalue { i32, i1 } %45, 0
  %47 = extractvalue { i32, i1 } %45, 1
  br i1 %47, label %62, label %61

48:                                               ; preds = %37, %37
  %49 = load i32, ptr %34, align 4
  %50 = load i32, ptr %13, align 4
  %51 = cmpxchg ptr %32, i32 %49, i32 %50 monotonic monotonic, align 4
  %52 = extractvalue { i32, i1 } %51, 0
  %53 = extractvalue { i32, i1 } %51, 1
  br i1 %53, label %65, label %64

54:                                               ; preds = %37
  %55 = load i32, ptr %34, align 4
  %56 = load i32, ptr %13, align 4
  %57 = cmpxchg ptr %32, i32 %55, i32 %56 monotonic monotonic, align 4
  %58 = extractvalue { i32, i1 } %57, 0
  %59 = extractvalue { i32, i1 } %57, 1
  br i1 %59, label %68, label %67

60:                                               ; preds = %68, %65, %62
  br label %182

61:                                               ; preds = %42
  store i32 %46, ptr %34, align 4
  br label %62

62:                                               ; preds = %61, %42
  %63 = zext i1 %47 to i8
  store i8 %63, ptr %14, align 1
  br label %60

64:                                               ; preds = %48
  store i32 %52, ptr %34, align 4
  br label %65

65:                                               ; preds = %64, %48
  %66 = zext i1 %53 to i8
  store i8 %66, ptr %14, align 1
  br label %60

67:                                               ; preds = %54
  store i32 %58, ptr %34, align 4
  br label %68

68:                                               ; preds = %67, %54
  %69 = zext i1 %59 to i8
  store i8 %69, ptr %14, align 1
  br label %60

70:                                               ; preds = %38
  %71 = load i32, ptr %34, align 4
  %72 = load i32, ptr %13, align 4
  %73 = cmpxchg ptr %32, i32 %71, i32 %72 monotonic monotonic, align 4
  %74 = extractvalue { i32, i1 } %73, 0
  %75 = extractvalue { i32, i1 } %73, 1
  br i1 %75, label %90, label %89

76:                                               ; preds = %38, %38
  %77 = load i32, ptr %34, align 4
  %78 = load i32, ptr %13, align 4
  %79 = cmpxchg ptr %32, i32 %77, i32 %78 monotonic monotonic, align 4
  %80 = extractvalue { i32, i1 } %79, 0
  %81 = extractvalue { i32, i1 } %79, 1
  br i1 %81, label %93, label %92

82:                                               ; preds = %38
  %83 = load i32, ptr %34, align 4
  %84 = load i32, ptr %13, align 4
  %85 = cmpxchg ptr %32, i32 %83, i32 %84 monotonic monotonic, align 4
  %86 = extractvalue { i32, i1 } %85, 0
  %87 = extractvalue { i32, i1 } %85, 1
  br i1 %87, label %96, label %95

88:                                               ; preds = %96, %93, %90
  br label %182

89:                                               ; preds = %70
  store i32 %74, ptr %34, align 4
  br label %90

90:                                               ; preds = %89, %70
  %91 = zext i1 %75 to i8
  store i8 %91, ptr %14, align 1
  br label %88

92:                                               ; preds = %76
  store i32 %80, ptr %34, align 4
  br label %93

93:                                               ; preds = %92, %76
  %94 = zext i1 %81 to i8
  store i8 %94, ptr %14, align 1
  br label %88

95:                                               ; preds = %82
  store i32 %86, ptr %34, align 4
  br label %96

96:                                               ; preds = %95, %82
  %97 = zext i1 %87 to i8
  store i8 %97, ptr %14, align 1
  br label %88

98:                                               ; preds = %39
  %99 = load i32, ptr %34, align 4
  %100 = load i32, ptr %13, align 4
  %101 = cmpxchg ptr %32, i32 %99, i32 %100 release monotonic, align 4
  %102 = extractvalue { i32, i1 } %101, 0
  %103 = extractvalue { i32, i1 } %101, 1
  br i1 %103, label %118, label %117

104:                                              ; preds = %39, %39
  %105 = load i32, ptr %34, align 4
  %106 = load i32, ptr %13, align 4
  %107 = cmpxchg ptr %32, i32 %105, i32 %106 release acquire, align 4
  %108 = extractvalue { i32, i1 } %107, 0
  %109 = extractvalue { i32, i1 } %107, 1
  br i1 %109, label %121, label %120

110:                                              ; preds = %39
  %111 = load i32, ptr %34, align 4
  %112 = load i32, ptr %13, align 4
  %113 = cmpxchg ptr %32, i32 %111, i32 %112 release seq_cst, align 4
  %114 = extractvalue { i32, i1 } %113, 0
  %115 = extractvalue { i32, i1 } %113, 1
  br i1 %115, label %124, label %123

116:                                              ; preds = %124, %121, %118
  br label %182

117:                                              ; preds = %98
  store i32 %102, ptr %34, align 4
  br label %118

118:                                              ; preds = %117, %98
  %119 = zext i1 %103 to i8
  store i8 %119, ptr %14, align 1
  br label %116

120:                                              ; preds = %104
  store i32 %108, ptr %34, align 4
  br label %121

121:                                              ; preds = %120, %104
  %122 = zext i1 %109 to i8
  store i8 %122, ptr %14, align 1
  br label %116

123:                                              ; preds = %110
  store i32 %114, ptr %34, align 4
  br label %124

124:                                              ; preds = %123, %110
  %125 = zext i1 %115 to i8
  store i8 %125, ptr %14, align 1
  br label %116

126:                                              ; preds = %40
  %127 = load i32, ptr %34, align 4
  %128 = load i32, ptr %13, align 4
  %129 = cmpxchg ptr %32, i32 %127, i32 %128 acq_rel monotonic, align 4
  %130 = extractvalue { i32, i1 } %129, 0
  %131 = extractvalue { i32, i1 } %129, 1
  br i1 %131, label %146, label %145

132:                                              ; preds = %40, %40
  %133 = load i32, ptr %34, align 4
  %134 = load i32, ptr %13, align 4
  %135 = cmpxchg ptr %32, i32 %133, i32 %134 acq_rel acquire, align 4
  %136 = extractvalue { i32, i1 } %135, 0
  %137 = extractvalue { i32, i1 } %135, 1
  br i1 %137, label %149, label %148

138:                                              ; preds = %40
  %139 = load i32, ptr %34, align 4
  %140 = load i32, ptr %13, align 4
  %141 = cmpxchg ptr %32, i32 %139, i32 %140 acq_rel seq_cst, align 4
  %142 = extractvalue { i32, i1 } %141, 0
  %143 = extractvalue { i32, i1 } %141, 1
  br i1 %143, label %152, label %151

144:                                              ; preds = %152, %149, %146
  br label %182

145:                                              ; preds = %126
  store i32 %130, ptr %34, align 4
  br label %146

146:                                              ; preds = %145, %126
  %147 = zext i1 %131 to i8
  store i8 %147, ptr %14, align 1
  br label %144

148:                                              ; preds = %132
  store i32 %136, ptr %34, align 4
  br label %149

149:                                              ; preds = %148, %132
  %150 = zext i1 %137 to i8
  store i8 %150, ptr %14, align 1
  br label %144

151:                                              ; preds = %138
  store i32 %142, ptr %34, align 4
  br label %152

152:                                              ; preds = %151, %138
  %153 = zext i1 %143 to i8
  store i8 %153, ptr %14, align 1
  br label %144

154:                                              ; preds = %41
  %155 = load i32, ptr %34, align 4
  %156 = load i32, ptr %13, align 4
  %157 = cmpxchg ptr %32, i32 %155, i32 %156 seq_cst monotonic, align 4
  %158 = extractvalue { i32, i1 } %157, 0
  %159 = extractvalue { i32, i1 } %157, 1
  br i1 %159, label %174, label %173

160:                                              ; preds = %41, %41
  %161 = load i32, ptr %34, align 4
  %162 = load i32, ptr %13, align 4
  %163 = cmpxchg ptr %32, i32 %161, i32 %162 seq_cst acquire, align 4
  %164 = extractvalue { i32, i1 } %163, 0
  %165 = extractvalue { i32, i1 } %163, 1
  br i1 %165, label %177, label %176

166:                                              ; preds = %41
  %167 = load i32, ptr %34, align 4
  %168 = load i32, ptr %13, align 4
  %169 = cmpxchg ptr %32, i32 %167, i32 %168 seq_cst seq_cst, align 4
  %170 = extractvalue { i32, i1 } %169, 0
  %171 = extractvalue { i32, i1 } %169, 1
  br i1 %171, label %180, label %179

172:                                              ; preds = %180, %177, %174
  br label %182

173:                                              ; preds = %154
  store i32 %158, ptr %34, align 4
  br label %174

174:                                              ; preds = %173, %154
  %175 = zext i1 %159 to i8
  store i8 %175, ptr %14, align 1
  br label %172

176:                                              ; preds = %160
  store i32 %164, ptr %34, align 4
  br label %177

177:                                              ; preds = %176, %160
  %178 = zext i1 %165 to i8
  store i8 %178, ptr %14, align 1
  br label %172

179:                                              ; preds = %166
  store i32 %170, ptr %34, align 4
  br label %180

180:                                              ; preds = %179, %166
  %181 = zext i1 %171 to i8
  store i8 %181, ptr %14, align 1
  br label %172

182:                                              ; preds = %172, %144, %116, %88, %60
  %183 = load i8, ptr %14, align 1
  %184 = trunc i8 %183 to i1
  %185 = zext i1 %184 to i8
  store i8 %185, ptr @exchanged, align 1
  call void @_Z7valsoutv()
  %186 = load i32, ptr @new_val, align 4
  store ptr @ai, ptr %19, align 8
  store ptr @tst_val, ptr %20, align 8
  store i32 %186, ptr %21, align 4
  store i32 5, ptr %22, align 4
  %187 = load ptr, ptr %19, align 8
  %188 = load ptr, ptr %20, align 8
  %189 = load i32, ptr %21, align 4
  %190 = load i32, ptr %22, align 4
  %191 = load i32, ptr %22, align 4
  %192 = call noundef i32 @_ZSt23__cmpexch_failure_orderSt12memory_order(i32 noundef %191) #3
  store ptr %187, ptr %1, align 8
  store ptr %188, ptr %2, align 8
  store i32 %189, ptr %3, align 4
  store i32 %190, ptr %4, align 4
  store i32 %192, ptr %5, align 4
  %193 = load ptr, ptr %1, align 8
  %194 = load i32, ptr %4, align 4
  %195 = load ptr, ptr %2, align 8
  %196 = load i32, ptr %3, align 4
  store i32 %196, ptr %6, align 4
  %197 = load i32, ptr %5, align 4
  switch i32 %194, label %198 [
    i32 1, label %199
    i32 2, label %199
    i32 3, label %200
    i32 4, label %201
    i32 5, label %202
  ]

198:                                              ; preds = %182
  switch i32 %197, label %203 [
    i32 1, label %209
    i32 2, label %209
    i32 5, label %215
  ]

199:                                              ; preds = %182, %182
  switch i32 %197, label %231 [
    i32 1, label %237
    i32 2, label %237
    i32 5, label %243
  ]

200:                                              ; preds = %182
  switch i32 %197, label %259 [
    i32 1, label %265
    i32 2, label %265
    i32 5, label %271
  ]

201:                                              ; preds = %182
  switch i32 %197, label %287 [
    i32 1, label %293
    i32 2, label %293
    i32 5, label %299
  ]

202:                                              ; preds = %182
  switch i32 %197, label %315 [
    i32 1, label %321
    i32 2, label %321
    i32 5, label %327
  ]

203:                                              ; preds = %198
  %204 = load i32, ptr %195, align 4
  %205 = load i32, ptr %6, align 4
  %206 = cmpxchg ptr %193, i32 %204, i32 %205 monotonic monotonic, align 4
  %207 = extractvalue { i32, i1 } %206, 0
  %208 = extractvalue { i32, i1 } %206, 1
  br i1 %208, label %223, label %222

209:                                              ; preds = %198, %198
  %210 = load i32, ptr %195, align 4
  %211 = load i32, ptr %6, align 4
  %212 = cmpxchg ptr %193, i32 %210, i32 %211 monotonic acquire, align 4
  %213 = extractvalue { i32, i1 } %212, 0
  %214 = extractvalue { i32, i1 } %212, 1
  br i1 %214, label %226, label %225

215:                                              ; preds = %198
  %216 = load i32, ptr %195, align 4
  %217 = load i32, ptr %6, align 4
  %218 = cmpxchg ptr %193, i32 %216, i32 %217 monotonic seq_cst, align 4
  %219 = extractvalue { i32, i1 } %218, 0
  %220 = extractvalue { i32, i1 } %218, 1
  br i1 %220, label %229, label %228

221:                                              ; preds = %229, %226, %223
  br label %343

222:                                              ; preds = %203
  store i32 %207, ptr %195, align 4
  br label %223

223:                                              ; preds = %222, %203
  %224 = zext i1 %208 to i8
  store i8 %224, ptr %7, align 1
  br label %221

225:                                              ; preds = %209
  store i32 %213, ptr %195, align 4
  br label %226

226:                                              ; preds = %225, %209
  %227 = zext i1 %214 to i8
  store i8 %227, ptr %7, align 1
  br label %221

228:                                              ; preds = %215
  store i32 %219, ptr %195, align 4
  br label %229

229:                                              ; preds = %228, %215
  %230 = zext i1 %220 to i8
  store i8 %230, ptr %7, align 1
  br label %221

231:                                              ; preds = %199
  %232 = load i32, ptr %195, align 4
  %233 = load i32, ptr %6, align 4
  %234 = cmpxchg ptr %193, i32 %232, i32 %233 acquire monotonic, align 4
  %235 = extractvalue { i32, i1 } %234, 0
  %236 = extractvalue { i32, i1 } %234, 1
  br i1 %236, label %251, label %250

237:                                              ; preds = %199, %199
  %238 = load i32, ptr %195, align 4
  %239 = load i32, ptr %6, align 4
  %240 = cmpxchg ptr %193, i32 %238, i32 %239 acquire acquire, align 4
  %241 = extractvalue { i32, i1 } %240, 0
  %242 = extractvalue { i32, i1 } %240, 1
  br i1 %242, label %254, label %253

243:                                              ; preds = %199
  %244 = load i32, ptr %195, align 4
  %245 = load i32, ptr %6, align 4
  %246 = cmpxchg ptr %193, i32 %244, i32 %245 acquire seq_cst, align 4
  %247 = extractvalue { i32, i1 } %246, 0
  %248 = extractvalue { i32, i1 } %246, 1
  br i1 %248, label %257, label %256

249:                                              ; preds = %257, %254, %251
  br label %343

250:                                              ; preds = %231
  store i32 %235, ptr %195, align 4
  br label %251

251:                                              ; preds = %250, %231
  %252 = zext i1 %236 to i8
  store i8 %252, ptr %7, align 1
  br label %249

253:                                              ; preds = %237
  store i32 %241, ptr %195, align 4
  br label %254

254:                                              ; preds = %253, %237
  %255 = zext i1 %242 to i8
  store i8 %255, ptr %7, align 1
  br label %249

256:                                              ; preds = %243
  store i32 %247, ptr %195, align 4
  br label %257

257:                                              ; preds = %256, %243
  %258 = zext i1 %248 to i8
  store i8 %258, ptr %7, align 1
  br label %249

259:                                              ; preds = %200
  %260 = load i32, ptr %195, align 4
  %261 = load i32, ptr %6, align 4
  %262 = cmpxchg ptr %193, i32 %260, i32 %261 release monotonic, align 4
  %263 = extractvalue { i32, i1 } %262, 0
  %264 = extractvalue { i32, i1 } %262, 1
  br i1 %264, label %279, label %278

265:                                              ; preds = %200, %200
  %266 = load i32, ptr %195, align 4
  %267 = load i32, ptr %6, align 4
  %268 = cmpxchg ptr %193, i32 %266, i32 %267 release acquire, align 4
  %269 = extractvalue { i32, i1 } %268, 0
  %270 = extractvalue { i32, i1 } %268, 1
  br i1 %270, label %282, label %281

271:                                              ; preds = %200
  %272 = load i32, ptr %195, align 4
  %273 = load i32, ptr %6, align 4
  %274 = cmpxchg ptr %193, i32 %272, i32 %273 release seq_cst, align 4
  %275 = extractvalue { i32, i1 } %274, 0
  %276 = extractvalue { i32, i1 } %274, 1
  br i1 %276, label %285, label %284

277:                                              ; preds = %285, %282, %279
  br label %343

278:                                              ; preds = %259
  store i32 %263, ptr %195, align 4
  br label %279

279:                                              ; preds = %278, %259
  %280 = zext i1 %264 to i8
  store i8 %280, ptr %7, align 1
  br label %277

281:                                              ; preds = %265
  store i32 %269, ptr %195, align 4
  br label %282

282:                                              ; preds = %281, %265
  %283 = zext i1 %270 to i8
  store i8 %283, ptr %7, align 1
  br label %277

284:                                              ; preds = %271
  store i32 %275, ptr %195, align 4
  br label %285

285:                                              ; preds = %284, %271
  %286 = zext i1 %276 to i8
  store i8 %286, ptr %7, align 1
  br label %277

287:                                              ; preds = %201
  %288 = load i32, ptr %195, align 4
  %289 = load i32, ptr %6, align 4
  %290 = cmpxchg ptr %193, i32 %288, i32 %289 acq_rel monotonic, align 4
  %291 = extractvalue { i32, i1 } %290, 0
  %292 = extractvalue { i32, i1 } %290, 1
  br i1 %292, label %307, label %306

293:                                              ; preds = %201, %201
  %294 = load i32, ptr %195, align 4
  %295 = load i32, ptr %6, align 4
  %296 = cmpxchg ptr %193, i32 %294, i32 %295 acq_rel acquire, align 4
  %297 = extractvalue { i32, i1 } %296, 0
  %298 = extractvalue { i32, i1 } %296, 1
  br i1 %298, label %310, label %309

299:                                              ; preds = %201
  %300 = load i32, ptr %195, align 4
  %301 = load i32, ptr %6, align 4
  %302 = cmpxchg ptr %193, i32 %300, i32 %301 acq_rel seq_cst, align 4
  %303 = extractvalue { i32, i1 } %302, 0
  %304 = extractvalue { i32, i1 } %302, 1
  br i1 %304, label %313, label %312

305:                                              ; preds = %313, %310, %307
  br label %343

306:                                              ; preds = %287
  store i32 %291, ptr %195, align 4
  br label %307

307:                                              ; preds = %306, %287
  %308 = zext i1 %292 to i8
  store i8 %308, ptr %7, align 1
  br label %305

309:                                              ; preds = %293
  store i32 %297, ptr %195, align 4
  br label %310

310:                                              ; preds = %309, %293
  %311 = zext i1 %298 to i8
  store i8 %311, ptr %7, align 1
  br label %305

312:                                              ; preds = %299
  store i32 %303, ptr %195, align 4
  br label %313

313:                                              ; preds = %312, %299
  %314 = zext i1 %304 to i8
  store i8 %314, ptr %7, align 1
  br label %305

315:                                              ; preds = %202
  %316 = load i32, ptr %195, align 4
  %317 = load i32, ptr %6, align 4
  %318 = cmpxchg ptr %193, i32 %316, i32 %317 seq_cst monotonic, align 4
  %319 = extractvalue { i32, i1 } %318, 0
  %320 = extractvalue { i32, i1 } %318, 1
  br i1 %320, label %335, label %334

321:                                              ; preds = %202, %202
  %322 = load i32, ptr %195, align 4
  %323 = load i32, ptr %6, align 4
  %324 = cmpxchg ptr %193, i32 %322, i32 %323 seq_cst acquire, align 4
  %325 = extractvalue { i32, i1 } %324, 0
  %326 = extractvalue { i32, i1 } %324, 1
  br i1 %326, label %338, label %337

327:                                              ; preds = %202
  %328 = load i32, ptr %195, align 4
  %329 = load i32, ptr %6, align 4
  %330 = cmpxchg ptr %193, i32 %328, i32 %329 seq_cst seq_cst, align 4
  %331 = extractvalue { i32, i1 } %330, 0
  %332 = extractvalue { i32, i1 } %330, 1
  br i1 %332, label %341, label %340

333:                                              ; preds = %341, %338, %335
  br label %343

334:                                              ; preds = %315
  store i32 %319, ptr %195, align 4
  br label %335

335:                                              ; preds = %334, %315
  %336 = zext i1 %320 to i8
  store i8 %336, ptr %7, align 1
  br label %333

337:                                              ; preds = %321
  store i32 %325, ptr %195, align 4
  br label %338

338:                                              ; preds = %337, %321
  %339 = zext i1 %326 to i8
  store i8 %339, ptr %7, align 1
  br label %333

340:                                              ; preds = %327
  store i32 %331, ptr %195, align 4
  br label %341

341:                                              ; preds = %340, %327
  %342 = zext i1 %332 to i8
  store i8 %342, ptr %7, align 1
  br label %333

343:                                              ; preds = %333, %305, %277, %249, %221
  %344 = load i8, ptr %7, align 1
  %345 = trunc i8 %344 to i1
  %346 = zext i1 %345 to i8
  store i8 %346, ptr @exchanged, align 1
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

23:                                               ; preds = %21, %19, %17
  %24 = load i32, ptr %9, align 4
  ret i32 %24
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #7

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
define linkonce_odr hidden void @__clang_call_terminate(ptr noundef %0) #8 comdat {
  %2 = call ptr @__cxa_begin_catch(ptr %0) #3
  call void @_ZSt9terminatev() #9
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
  call void @__clang_call_terminate(ptr %12) #9
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
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { noinline noreturn nounwind uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = !{i32 7, !"Dwarf Version", i32 5}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"PIE Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{i32 7, !"frame-pointer", i32 2}
!7 = !{!"clang version 18.1.7 (https://github.com/conda-forge/clangdev-feedstock 1b91969d0c6b64ef555f9c04fc02d7758335f4b3)"}
