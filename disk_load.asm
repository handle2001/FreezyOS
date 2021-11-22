disk_load:
    push dx             ; save DH to stack so we can compare later
    mov ah, 0x02        ; BIOS disk read function
    mov al, dh          ; read dh sectors
    mov ch, 0x00        ; read cylinder 0
    mov dh, 0x00        ; read head 0
    mov cl, 0x02        ; read sector 2

    int 0x13        ; Do the read

    jc disk_error   ; if carry flag is set after the read, an 
                    ; error occurred

    pop dx      ; recall how many sectors we wanted to read
    cmp dh, al  ; CPU stores number of sectors read in al
                ; compare this to dh to confirm we read
                ; all sectors successfully

    jne disk_error
    ret

    disk_error:
        mov bx, DISK_ERROR_MSG
        call print_string
        jmp $

; Variabls
DISK_ERROR_MSG db "Disk read error!", 0