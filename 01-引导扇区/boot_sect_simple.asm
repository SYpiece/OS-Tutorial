; 一个简单的无限循环的引导扇区程序
loop:
    jmp loop
times 510-($-$$) db 0
dw 0xaa55