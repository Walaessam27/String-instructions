 
  .model small
      .8086
      .data
    input_string1 db 100   ; First input string
    input_string2 db 100   ; Second input string
    concat_string db 200   ; Concatenated string

    msg_input db 'Enter a string (# to end): $'
    msg_output db 'Concatenated string: $'

.code
_start:
  
    ; Initialize data segment registers
    mov ax, @data
    mov ds, ax
    mov es, ax

    ; Read the first string
    lea si, [input_string1]
    call read_string

    ; Read the second string
    lea si, [input_string2]
    call read_string

    ; Concatenate strings
    lea si, [input_string1]
    lea di, [concat_string]
    call concat_strings

    ; Display the concatenated string
    lea si, [msg_output]
    call print_string

    lea si, [concat_string]
    call print_string

    ; Terminate program
    int 20h


; Function to read a string from the user
read_string:
    mov ah, 09h     ; DOS function to print string
    int 21h

    ; Read characters until '#' is entered
read_loop:
    mov ah, 01h     ; DOS function to read a character
    int 21h

    ; Check if the character is '#' (end of input)
    cmp al, '#'
    je end_read

    ; Store character in memory
    stosb
    jmp read_loop

end_read:
    mov byte [si], 0   ; Null-terminate the string
    ret

; Function to concatenate two strings
concat_strings:
    rep movsb       ; Copy the first string to destination
   lea si, [input_string2]  ; Set source to the second string
    rep movsb       ; Append the second string to the end
    ret

; Function to print a string
print_string:
    mov ah, 09h     ; DOS function to print string
    int 21h
    ret
