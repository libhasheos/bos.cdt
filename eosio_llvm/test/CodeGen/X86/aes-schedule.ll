; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=x86-64 -mattr=+aes | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=slm | FileCheck %s --check-prefix=CHECK --check-prefix=SLM
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=goldmont | FileCheck %s --check-prefix=CHECK --check-prefix=SLM
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=sandybridge -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,SANDY-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=sandybridge -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=ivybridge -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,SANDY-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=ivybridge -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,SANDY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,HASWELL-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=broadwell -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,BROADWELL-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=broadwell -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,BROADWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,SKYLAKE-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,SKYLAKE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skx -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,SKX-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skx -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,SKX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=btver2 -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,BTVER2-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=btver2 -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,BTVER2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1 -mattr=-avx  | FileCheck %s --check-prefixes=CHECK,ZNVER1-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1 -mattr=-avx2 | FileCheck %s --check-prefixes=CHECK,ZNVER1

define <2 x i64> @test_aesdec(<2 x i64> %a0, <2 x i64> %a1, <2 x i64> *%a2) {
; GENERIC-LABEL: test_aesdec:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aesdec %xmm1, %xmm0 # sched: [7:1.00]
; GENERIC-NEXT:    aesdec (%rdi), %xmm0 # sched: [13:1.00]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aesdec:
; SLM:       # %bb.0:
; SLM-NEXT:    aesdec %xmm1, %xmm0 # sched: [8:5.00]
; SLM-NEXT:    aesdec (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aesdec:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [7:1.00]
; SANDY-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [13:1.00]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aesdec:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; SANDY-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aesdec:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [7:1.00]
; HASWELL-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [13:1.00]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aesdec:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; HASWELL-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aesdec:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [7:1.00]
; BROADWELL-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [12:1.00]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aesdec:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; BROADWELL-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [12:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aesdec:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [4:1.00]
; SKYLAKE-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [10:1.00]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aesdec:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKYLAKE-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aesdec:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [4:1.00]
; SKX-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [10:1.00]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aesdec:
; SKX:       # %bb.0:
; SKX-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKX-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aesdec:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [3:1.00]
; BTVER2-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [8:1.00]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aesdec:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aesdec:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aesdec %xmm1, %xmm0 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aesdec (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aesdec:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaesdec %xmm1, %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vaesdec (%rdi), %xmm0, %xmm0 # sched: [11:0.50]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a2, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aesdec(<2 x i64> %a0, <2 x i64> %a1)
  %3 = call <2 x i64> @llvm.x86.aesni.aesdec(<2 x i64> %2, <2 x i64> %1)
  ret <2 x i64> %3
}
declare <2 x i64> @llvm.x86.aesni.aesdec(<2 x i64>, <2 x i64>)

define <2 x i64> @test_aesdeclast(<2 x i64> %a0, <2 x i64> %a1, <2 x i64> *%a2) {
; GENERIC-LABEL: test_aesdeclast:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [7:1.00]
; GENERIC-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [13:1.00]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aesdeclast:
; SLM:       # %bb.0:
; SLM-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [8:5.00]
; SLM-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aesdeclast:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [7:1.00]
; SANDY-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [13:1.00]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aesdeclast:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; SANDY-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aesdeclast:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [7:1.00]
; HASWELL-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [13:1.00]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aesdeclast:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; HASWELL-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aesdeclast:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [7:1.00]
; BROADWELL-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [12:1.00]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aesdeclast:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; BROADWELL-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [12:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aesdeclast:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [4:1.00]
; SKYLAKE-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [10:1.00]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aesdeclast:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKYLAKE-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aesdeclast:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [4:1.00]
; SKX-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [10:1.00]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aesdeclast:
; SKX:       # %bb.0:
; SKX-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKX-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aesdeclast:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [3:1.00]
; BTVER2-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [8:1.00]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aesdeclast:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aesdeclast:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aesdeclast %xmm1, %xmm0 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aesdeclast (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aesdeclast:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaesdeclast %xmm1, %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vaesdeclast (%rdi), %xmm0, %xmm0 # sched: [11:0.50]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a2, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aesdeclast(<2 x i64> %a0, <2 x i64> %a1)
  %3 = call <2 x i64> @llvm.x86.aesni.aesdeclast(<2 x i64> %2, <2 x i64> %1)
  ret <2 x i64> %3
}
declare <2 x i64> @llvm.x86.aesni.aesdeclast(<2 x i64>, <2 x i64>)

define <2 x i64> @test_aesenc(<2 x i64> %a0, <2 x i64> %a1, <2 x i64> *%a2) {
; GENERIC-LABEL: test_aesenc:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aesenc %xmm1, %xmm0 # sched: [7:1.00]
; GENERIC-NEXT:    aesenc (%rdi), %xmm0 # sched: [13:1.00]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aesenc:
; SLM:       # %bb.0:
; SLM-NEXT:    aesenc %xmm1, %xmm0 # sched: [8:5.00]
; SLM-NEXT:    aesenc (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aesenc:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [7:1.00]
; SANDY-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [13:1.00]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aesenc:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; SANDY-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aesenc:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [7:1.00]
; HASWELL-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [13:1.00]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aesenc:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; HASWELL-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aesenc:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [7:1.00]
; BROADWELL-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [12:1.00]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aesenc:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; BROADWELL-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [12:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aesenc:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [4:1.00]
; SKYLAKE-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [10:1.00]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aesenc:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKYLAKE-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aesenc:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [4:1.00]
; SKX-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [10:1.00]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aesenc:
; SKX:       # %bb.0:
; SKX-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKX-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aesenc:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [3:1.00]
; BTVER2-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [8:1.00]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aesenc:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aesenc:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aesenc %xmm1, %xmm0 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aesenc (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aesenc:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaesenc %xmm1, %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vaesenc (%rdi), %xmm0, %xmm0 # sched: [11:0.50]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a2, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aesenc(<2 x i64> %a0, <2 x i64> %a1)
  %3 = call <2 x i64> @llvm.x86.aesni.aesenc(<2 x i64> %2, <2 x i64> %1)
  ret <2 x i64> %3
}
declare <2 x i64> @llvm.x86.aesni.aesenc(<2 x i64>, <2 x i64>)

define <2 x i64> @test_aesenclast(<2 x i64> %a0, <2 x i64> %a1, <2 x i64> *%a2) {
; GENERIC-LABEL: test_aesenclast:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aesenclast %xmm1, %xmm0 # sched: [7:1.00]
; GENERIC-NEXT:    aesenclast (%rdi), %xmm0 # sched: [13:1.00]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aesenclast:
; SLM:       # %bb.0:
; SLM-NEXT:    aesenclast %xmm1, %xmm0 # sched: [8:5.00]
; SLM-NEXT:    aesenclast (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aesenclast:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [7:1.00]
; SANDY-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [13:1.00]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aesenclast:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; SANDY-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aesenclast:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [7:1.00]
; HASWELL-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [13:1.00]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aesenclast:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; HASWELL-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [13:1.00]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aesenclast:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [7:1.00]
; BROADWELL-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [12:1.00]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aesenclast:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [7:1.00]
; BROADWELL-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [12:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aesenclast:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [4:1.00]
; SKYLAKE-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [10:1.00]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aesenclast:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKYLAKE-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aesenclast:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [4:1.00]
; SKX-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [10:1.00]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aesenclast:
; SKX:       # %bb.0:
; SKX-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [4:1.00]
; SKX-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [10:1.00]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aesenclast:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [3:1.00]
; BTVER2-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [8:1.00]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aesenclast:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [3:1.00]
; BTVER2-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [8:1.00]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aesenclast:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aesenclast %xmm1, %xmm0 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aesenclast (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aesenclast:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaesenclast %xmm1, %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vaesenclast (%rdi), %xmm0, %xmm0 # sched: [11:0.50]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a2, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aesenclast(<2 x i64> %a0, <2 x i64> %a1)
  %3 = call <2 x i64> @llvm.x86.aesni.aesenclast(<2 x i64> %2, <2 x i64> %1)
  ret <2 x i64> %3
}
declare <2 x i64> @llvm.x86.aesni.aesenclast(<2 x i64>, <2 x i64>)

define <2 x i64> @test_aesimc(<2 x i64> %a0, <2 x i64> *%a1) {
; GENERIC-LABEL: test_aesimc:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aesimc %xmm0, %xmm1 # sched: [12:2.00]
; GENERIC-NEXT:    aesimc (%rdi), %xmm0 # sched: [18:2.00]
; GENERIC-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aesimc:
; SLM:       # %bb.0:
; SLM-NEXT:    aesimc %xmm0, %xmm1 # sched: [8:5.00]
; SLM-NEXT:    aesimc (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    por %xmm1, %xmm0 # sched: [1:0.50]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aesimc:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [12:2.00]
; SANDY-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [18:2.00]
; SANDY-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aesimc:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaesimc %xmm0, %xmm0 # sched: [12:2.00]
; SANDY-NEXT:    vaesimc (%rdi), %xmm1 # sched: [18:2.00]
; SANDY-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aesimc:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [14:2.00]
; HASWELL-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [20:2.00]
; HASWELL-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aesimc:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaesimc %xmm0, %xmm0 # sched: [14:2.00]
; HASWELL-NEXT:    vaesimc (%rdi), %xmm1 # sched: [20:2.00]
; HASWELL-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aesimc:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aesimc (%rdi), %xmm1 # sched: [19:2.00]
; BROADWELL-SSE-NEXT:    aesimc %xmm0, %xmm0 # sched: [14:2.00]
; BROADWELL-SSE-NEXT:    por %xmm0, %xmm1 # sched: [1:0.33]
; BROADWELL-SSE-NEXT:    movdqa %xmm1, %xmm0 # sched: [1:0.33]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aesimc:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaesimc (%rdi), %xmm1 # sched: [19:2.00]
; BROADWELL-NEXT:    vaesimc %xmm0, %xmm0 # sched: [14:2.00]
; BROADWELL-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aesimc:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [8:2.00]
; SKYLAKE-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [14:2.00]
; SKYLAKE-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aesimc:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaesimc %xmm0, %xmm0 # sched: [8:2.00]
; SKYLAKE-NEXT:    vaesimc (%rdi), %xmm1 # sched: [14:2.00]
; SKYLAKE-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aesimc:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [8:2.00]
; SKX-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [14:2.00]
; SKX-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aesimc:
; SKX:       # %bb.0:
; SKX-NEXT:    vaesimc %xmm0, %xmm0 # sched: [8:2.00]
; SKX-NEXT:    vaesimc (%rdi), %xmm1 # sched: [14:2.00]
; SKX-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aesimc:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [2:1.00]
; BTVER2-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [7:1.00]
; BTVER2-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.50]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aesimc:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaesimc (%rdi), %xmm1 # sched: [7:1.00]
; BTVER2-NEXT:    vaesimc %xmm0, %xmm0 # sched: [2:1.00]
; BTVER2-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aesimc:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aesimc %xmm0, %xmm1 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aesimc (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.25]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aesimc:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaesimc (%rdi), %xmm1 # sched: [11:0.50]
; ZNVER1-NEXT:    vaesimc %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a1, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aesimc(<2 x i64> %a0)
  %3 = call <2 x i64> @llvm.x86.aesni.aesimc(<2 x i64> %1)
  %4 = or <2 x i64> %2, %3
  ret <2 x i64> %4
}
declare <2 x i64> @llvm.x86.aesni.aesimc(<2 x i64>)

define <2 x i64> @test_aeskeygenassist(<2 x i64> %a0, <2 x i64> *%a1) {
; GENERIC-LABEL: test_aeskeygenassist:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [8:3.67]
; GENERIC-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [8:3.33]
; GENERIC-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; SLM-LABEL: test_aeskeygenassist:
; SLM:       # %bb.0:
; SLM-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [8:5.00]
; SLM-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [8:5.00]
; SLM-NEXT:    por %xmm1, %xmm0 # sched: [1:0.50]
; SLM-NEXT:    retq # sched: [4:1.00]
;
; SANDY-SSE-LABEL: test_aeskeygenassist:
; SANDY-SSE:       # %bb.0:
; SANDY-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [8:3.67]
; SANDY-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [8:3.33]
; SANDY-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SANDY-SSE-NEXT:    retq # sched: [1:1.00]
;
; SANDY-LABEL: test_aeskeygenassist:
; SANDY:       # %bb.0:
; SANDY-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [8:3.67]
; SANDY-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [8:3.33]
; SANDY-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SANDY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-SSE-LABEL: test_aeskeygenassist:
; HASWELL-SSE:       # %bb.0:
; HASWELL-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [29:7.00]
; HASWELL-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [34:7.00]
; HASWELL-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; HASWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; HASWELL-LABEL: test_aeskeygenassist:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [29:7.00]
; HASWELL-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [34:7.00]
; HASWELL-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; HASWELL-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-SSE-LABEL: test_aeskeygenassist:
; BROADWELL-SSE:       # %bb.0:
; BROADWELL-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [29:7.00]
; BROADWELL-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [33:7.00]
; BROADWELL-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; BROADWELL-SSE-NEXT:    retq # sched: [7:1.00]
;
; BROADWELL-LABEL: test_aeskeygenassist:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [29:7.00]
; BROADWELL-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [33:7.00]
; BROADWELL-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-SSE-LABEL: test_aeskeygenassist:
; SKYLAKE-SSE:       # %bb.0:
; SKYLAKE-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [20:6.00]
; SKYLAKE-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [25:6.00]
; SKYLAKE-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SKYLAKE-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_aeskeygenassist:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [20:6.00]
; SKYLAKE-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [25:6.00]
; SKYLAKE-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-SSE-LABEL: test_aeskeygenassist:
; SKX-SSE:       # %bb.0:
; SKX-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [20:6.00]
; SKX-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [25:6.00]
; SKX-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.33]
; SKX-SSE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_aeskeygenassist:
; SKX:       # %bb.0:
; SKX-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [20:6.00]
; SKX-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [25:6.00]
; SKX-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.33]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; BTVER2-SSE-LABEL: test_aeskeygenassist:
; BTVER2-SSE:       # %bb.0:
; BTVER2-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [2:1.00]
; BTVER2-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [7:1.00]
; BTVER2-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.50]
; BTVER2-SSE-NEXT:    retq # sched: [4:1.00]
;
; BTVER2-LABEL: test_aeskeygenassist:
; BTVER2:       # %bb.0:
; BTVER2-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [7:1.00]
; BTVER2-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [2:1.00]
; BTVER2-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.50]
; BTVER2-NEXT:    retq # sched: [4:1.00]
;
; ZNVER1-SSE-LABEL: test_aeskeygenassist:
; ZNVER1-SSE:       # %bb.0:
; ZNVER1-SSE-NEXT:    aeskeygenassist $7, %xmm0, %xmm1 # sched: [4:0.50]
; ZNVER1-SSE-NEXT:    aeskeygenassist $7, (%rdi), %xmm0 # sched: [11:0.50]
; ZNVER1-SSE-NEXT:    por %xmm1, %xmm0 # sched: [1:0.25]
; ZNVER1-SSE-NEXT:    retq # sched: [1:0.50]
;
; ZNVER1-LABEL: test_aeskeygenassist:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    vaeskeygenassist $7, (%rdi), %xmm1 # sched: [11:0.50]
; ZNVER1-NEXT:    vaeskeygenassist $7, %xmm0, %xmm0 # sched: [4:0.50]
; ZNVER1-NEXT:    vpor %xmm1, %xmm0, %xmm0 # sched: [1:0.25]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %1 = load <2 x i64>, <2 x i64> *%a1, align 16
  %2 = call <2 x i64> @llvm.x86.aesni.aeskeygenassist(<2 x i64> %a0, i8 7)
  %3 = call <2 x i64> @llvm.x86.aesni.aeskeygenassist(<2 x i64> %1, i8 7)
  %4 = or <2 x i64> %2, %3
  ret <2 x i64> %4
}
declare <2 x i64> @llvm.x86.aesni.aeskeygenassist(<2 x i64>, i8)
