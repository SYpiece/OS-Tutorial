mov ah, 0x0e ; 终端模式

mov bp, 0x8000 ; 设置远离0x7c00的地址防止被覆盖
mov sp, bp ; 空栈时sp指向bp

push 'A'
push 'B'
push 'C'

; 演示堆栈向下增长特性
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; 此时不要尝试访问[0x8000]，会失败
; 当前只能访问栈顶0x7ffe（见上方）
mov al, [0x8000]
int 0x10


; 使用标准'pop'指令恢复字符
; 我们只能弹出完整字，需用辅助寄存器处理低字节
pop bx
mov al, bl
int 0x10 ; 打印C

pop bx
mov al, bl
int 0x10 ; 打印B

pop bx
mov al, bl
int 0x10 ; 打印A

; 已弹出数据变为无效值
mov al, [0x8000]
int 0x10


jmp $
times 510-($-$$) db 0
dw 0xaa55