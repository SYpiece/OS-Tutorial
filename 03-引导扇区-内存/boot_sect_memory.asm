mov ah, 0x0e

; 尝试1
; 失败，因为它试图打印内存地址（即指针）
; 而不是其实际内容
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; 尝试2
; 它试图打印'the_secret'的内存地址，这是正确的方法。
; 然而，BIOS将我们的引导扇区二进制文件放置在地址0x7c00
; 所以我们需要事先添加该填充。我们将在尝试3中这样做
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; 尝试3
; 将BIOS起始偏移量0x7c00添加到X的内存地址
; 然后取消引用该指针的内容。
; 我们需要借助另一个寄存器'bx'，因为'mov al, [ax]'是非法的。
; 一个寄存器不能在同一命令中既用作源又用作目标。
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; 尝试4
; 我们尝试走捷径，因为我们知道X存储在我们的二进制的字节0x2d处
; 这很聪明，但无效，我们不想在每次更改代码时都重新计算标签偏移量
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