; 通过 'dx' 寄存器接收数据
; 在示例中假设调用时 dx=0x1234
print_hex:
    pusha

    mov cx, 0 ; 初始化索引变量

; 转换策略：获取 'dx' 的最低4位，转换为ASCII字符
; 数字ASCII值：'0'(0x30)到'9'(0x39)，直接加0x30即可
; 字母A-F：'A'(0x41)到'F'(0x46)，需加0x40
; 然后将ASCII字符移动到结果字符串的正确位置
hex_loop:
    cmp cx, 4 ; 循环4次
    je end
    
    ; 1. 将 'dx' 的最低4位转换为ASCII
    mov ax, dx ; 使用 'ax' 作为工作寄存器
    and ax, 0x000f ; 保留最低4位（如 0x1234 -> 0x0004）
    add al, 0x30 ; 加0x30转换为ASCII字符（如 N -> 'N'）
    cmp al, 0x39 ; 如果结果 > 9（ASCII '9'），需要额外处理字母
    jle step2
    add al, 7 ; 整ASCII值（如58 + 7 = 65 -> 'A'）

step2:
    ; 2. 计算字符串中的存储位置
    ; bx = 基地址 + 字符串长度 - 当前字符索引
    mov bx, HEX_OUT + 5 ; 基地址 + 总长度
    sub bx, cx  ; 调整指针位置
    mov [bx], al ; 复制'al'上的字符道'bx'指向的位置
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ; 递增索引并继续循环
    add cx, 1
    jmp hex_loop

end:
    ; 准备参数并调用打印函数
    ; 注意 print 函数通过 'bx' 接收参数
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000',0 ; 为结果字符串预留内存空间
