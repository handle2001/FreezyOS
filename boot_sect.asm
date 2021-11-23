;
[org 0x7c00]

mov [BOOT_DRIVE], dl  ; BIOS stores the boot drive in dl

mov bp, 0x8000    ; stash the stack way out the way
mov sp, bp

xor ax, ax
mov es, ax        ; ES = 0
mov bx, 0x9000    ; Load 5 sectors into 0x0000(ES):0x9000(BX)
mov dh, 2
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]  ; print the first loaded word
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

; global  variables
BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

; Now put some recognizable data on our "disk"
times 256 dw 0xdada
times 256 dw 0xface
