print:
    pusha

; 核心逻辑:
; while (string[i] != 0) { print string[i]; i++ }

; 字符串末尾（空字节）的比较
start:
    mov al, [bx] ; 字符串的基地址'bx' 
    cmp al, 0 
    je done

    ; 通过BIOS辅助打印字符
    mov ah, 0x0e
    int 0x10 ; 'al' already contains the char

    ; 指针递增并继续循环
    add bx, 1
    jmp start

done:
    popa
    ret



print_nl:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a ; 换行符
    int 0x10
    mov al, 0x0d ; 回车符
    int 0x10
    
    popa
    ret
