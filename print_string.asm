;
; print string function
;

print_string:
    mov ah, 0x0e

    loop:
        mov al, [bx]
        cmp al, 0
        je the_end
        int 0x10
        inc bx
        jmp loop

    the_end:
        ret