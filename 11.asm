
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; add your code here
   .model small
.8086
.data
    max_length db 100
    prompt1 db "Enter the first string (max 100 characters, press # to finish): $"
    prompt2 db "Enter the second string (max 100 characters, press # to finish): $"
    concat_msg db "Concatenated string: $"
    string1 db 100 dup(0) 
    string2 db 100 dup(0)  
    result db 200 dup(0)   
.code
start:
    mov ax, @data
    mov ds, ax
    mov es, ax  
    mov ah, 09h
    lea dx, prompt1
    int 21h

    mov cx, 0
    lea di, result  

read_first_string:
    mov ah, 01h
    int 21h
    inc cx
    cmp al, '#'  
    je stopRead
    cmp cx, 100
    je stopRead
    stosb
    jmp read_first_string

stopRead:
    mov ah, 09h
    lea dx, prompt2
    int 21h

    mov cx, 0
    lea di, result  

read_second_string:
    mov ah, 01h
    int 21h
    inc cx
    cmp al, '#'
    je stopConcatenate
    cmp cx, 100
    je stopConcatenate
    stosb
    jmp read_second_string

stopConcatenate:
    mov ah, 09h
    lea dx, concat_msg
    int 21h

    lea si, result 

display_result:
    lodsb
    test al, al
    jz done  
    mov ah, 02h  
    int 21h
    jmp display_result

done:
    mov ah, 4Ch
    int 21h
end
ret




