; bootloader.asm
[org 0x7c00]          ; Origin of the bootloader

; Print a message
mov ah, 0x0E         ; BIOS teletype output function
mov si, msg          ; Load the address of the message
call print           ; Call print function

; Hang the system
jmp $

print:
    mov cx, 0        ; Clear CX
.loop:
    lodsb            ; Load byte at DS:SI into AL
    cmp al, 0        ; Check for null terminator
    je .done         ; If null, we're done
    int 0x10         ; BIOS interrupt to print character
    jmp .loop        ; Loop back for next character
.done:
    ret

msg db 'Hello, World!', 0 ; Null-terminated string

times 510 - ($ - $$) db 0  ; Fill the rest of the sector with 0
dw 0xAA55                  ; Boot signature
