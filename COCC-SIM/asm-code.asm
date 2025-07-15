.text 
    lda E %x 
    ldi F 0 ;count
    ldi G 0 ;n
    ldi B 0 :ncönter
    push B

start:
    mov B G
    mov A E 
    cmp
    jz %end
    jmp move

end:
    hlt

move:
    pop B
    mov A G
    cmp
    jnz %rek
    mov A F 
    inc 
    move F A
    ldi B 0
    psuh B
    jmp start

rek:
    mov A G
    dec
    move 

.data 
x = 20