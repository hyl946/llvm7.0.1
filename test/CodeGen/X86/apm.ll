; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-linux -mattr=+sse3 | FileCheck %s -check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-linux -mattr=+sse3 | FileCheck %s -check-prefixes=CHECK,X64
; RUN: llc < %s -mtriple=x86_64-win32 -mattr=+sse3 | FileCheck %s -check-prefixes=CHECK,WIN64

; PR8573

define void @foo(i8* %P, i32 %E, i32 %H) nounwind {
; X86-LABEL: foo:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax), %eax
; X86-NEXT:    monitor
; X86-NEXT:    retl
;
; X64-LABEL: foo:
; X64:       # %bb.0: # %entry
; X64-NEXT:    leaq (%rdi), %rax
; X64-NEXT:    movl %esi, %ecx
; X64-NEXT:    monitor
; X64-NEXT:    retq
;
; WIN64-LABEL: foo:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    leaq (%rcx), %rax
; WIN64-NEXT:    movl %edx, %ecx
; WIN64-NEXT:    movl %r8d, %edx
; WIN64-NEXT:    monitor
; WIN64-NEXT:    retq
entry:
  tail call void @llvm.x86.sse3.monitor(i8* %P, i32 %E, i32 %H)
  ret void
}

declare void @llvm.x86.sse3.monitor(i8*, i32, i32) nounwind

define void @bar(i32 %E, i32 %H) nounwind {
; X86-LABEL: bar:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    mwait
; X86-NEXT:    retl
;
; X64-LABEL: bar:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    mwait
; X64-NEXT:    retq
;
; WIN64-LABEL: bar:
; WIN64:       # %bb.0: # %entry
; WIN64-NEXT:    movl %edx, %eax
; WIN64-NEXT:    mwait
; WIN64-NEXT:    retq
entry:
  tail call void @llvm.x86.sse3.mwait(i32 %E, i32 %H)
  ret void
}

declare void @llvm.x86.sse3.mwait(i32, i32) nounwind
