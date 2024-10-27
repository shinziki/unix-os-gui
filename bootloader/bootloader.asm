; bootloader.asm
[bits 16]           ; 16-bit code
[org 0x7c00]       ; Load address

; Print a message
mov ah, 0x0E       ; BIOS teletype function
mov si, message    ; Point to message
call print_string

; Hang the system
jmp $

; Message to display
message db 'Hello, MyOS!', 0

print_string:
    lodsb          ; Load byte at DS:SI into AL
    cmp al, 0      ; Check for end of string
    je .done       ; If null terminator, we're done
    int 0x10       ; Call BIOS to print character
    jmp print_string ; Repeat for the next character

.done:
    ret

; Boot signature
times 510 - ($ - $$) db 0 ; Pad with zeroes
dw 0xAA55                  ; Boot signature
