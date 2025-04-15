[org 0x7c00] ; 告知汇编器引导扇区代码的偏移量

; 主程序确保参数就绪后调用函数
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

; 程序结束！进入无限循环
jmp $

; 注意：子程序应在主程序之后引入
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"


; 数据
HELLO:
    db 'Hello, World', 0

GOODBYE:
    db 'Goodbye', 0

; 填充和魔术数字
times 510-($-$$) db 0
dw 0xaa55
