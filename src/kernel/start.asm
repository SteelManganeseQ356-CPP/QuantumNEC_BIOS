[bits 64]
extern kernelInit
global _start
_start:
    ; 表示进入内核了
    call kernelInit
    hlt ; 阻塞