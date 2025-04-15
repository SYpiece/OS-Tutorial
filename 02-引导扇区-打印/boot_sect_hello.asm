mov ah, 0x0e ; 终端模式
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; 'l' 仍在 al 中，记得吗？
mov al, 'o'
int 0x10

jmp $ ; 跳转到当前地址 = 无限循环

; 填充和魔术数字
times 510 - ($-$$) db 0
dw 0xaa55