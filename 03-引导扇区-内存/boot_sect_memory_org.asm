[org 0x7c00]
mov ah, 0x0e

; 尝试1
; 仍然会失败，因为我们仍然是在寻址指针
; 而不是指针指向的数据，与'org'无关
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; 尝试2
; 用'org'解决了内存偏移问题后，这才是正确的答案
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; 尝试3
; 正如你所料，我们加了两次0x7c00，所以这行不通
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; 尝试4
; 这仍然有效，因为这里没有指针的内存引用
; 所以'org'模式永远不会应用。直接通过计算字节来寻址内存
; 总是有效的，但很不方便
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10


jmp $ ; 无限循环

the_secret:
    ; ASCII码0x58 ('X')存储在零填充之前。
    ; 在此代码中，它位于字节0x2d处（使用'xxd file.bin'检查）
    db "X"

; 零填充和神奇的BIOS数字
times 510-($-$$) db 0
dw 0xaa55