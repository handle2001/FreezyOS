; assumes DH contains the number of sectors to read
disk_load:
    push dx             ; save DH to stack so we can compare later
    ; arguments to int 0x13 follow:
    mov ah, 0x02        ; 0x02 = read, 0x03 = write
    mov al, dh          ; number of sectors to read
    mov ch, 0x00        ; start cylinder
    mov dh, 0x00        ; start head
    mov cl, 0x02        ; start sector 2 (after boot sector)

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

; Variables
DISK_ERROR_MSG db "Disk read error!", 0
