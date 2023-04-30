    ORG 10000h
    MOV AX, CS
    MOV DS, AX
    MOV ES, AX
    MOV AX, 0x00
    MOV SS, AX
    MOV SP, 0x7c00
    ; 打印字符串
    MOV AX, 1301h
    MOV BX, 000fh
    MOV DX, 0100h ; 0100H -> 第二行
    MOV CX, 10
    MOV SI, BOOTSUCCESS_MESSAGE
    CALL print

    MOV AX, 1301h
    MOV BX, 000fh
    MOV DX, 0200h ; 0200H -> 第三行
    MOV CX, 12
    MOV SI, LOADERING_MESSAGE
    CALL print
    HLT
; PRINT Func
print:
    PUSH AX
    MOV AX, DS
    MOV ES, AX
    POP AX
    MOV BP, SI
    INT 10h
    RET

; MESSAGE
BOOTSUCCESS_MESSAGE:    DB "Boot -> OK"
LOADERING_MESSAGE:      DB "Loadering -> Start"