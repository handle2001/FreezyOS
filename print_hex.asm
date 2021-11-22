print_hex:
  pusha           ; be a good jack, save to the stack!
  mov cx, 4       ; loop counter set to 4 (16 bits / 4 bit nibbles)

  char_loop:
    dec cx

    mov ax, dx    ; move the hex value we're printing into ax
    shr dx, 4     ; chop the least nibble off
    and ax, 0xf   ; mask everything but the last nibble

    mov bx, HEX_OUT ; move the address of the final string into bx
    add bx, 2       ; skip the "0x"
    add bx, cx      ; skip to the character we're on

    cmp ax, 10    ; in hex, values >= 10 are alphabetic
    jl set_value  ; if value is < 10, it's a number
    add byte [bx], 7 ; we only get here if this nibble is a letter
                     ; since there is a gap of 7 between ASCII numbers
                     ; and letters, this covers the gap
    jl set_value

  set_value:
    add byte [bx], al ; [bx] already points to an ASCII value, so add
                      ; the raw hex value to get the right ASCII value
    cmp cx, 0         ; if  program counter is zero, we're done
    je print_hex_done
    jmp char_loop     ; otherwise do the next value

  print_hex_done:
    mov bx, HEX_OUT   ; move our updated HEX_OUT to bx as argument for
    call print_string ; print_string

    popa             ; restore the register values from stack
    ret 

; global variables
HEX_OUT: db "0x000", 0