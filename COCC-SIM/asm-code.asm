.text 
    lda E %x 
    ldi F 0 ;Help
    ldi G 0 ;End
    ldi B 0
    push B
    push B
start:
    pop B 
    lda A %x
    cmp 
    jz %end ;wenn 

    pop B
    ldi A 0 ;0 für Help 
    cmp     ;1 für End
    jz %ringHelp
    jmp %ringEnd

end:

    hlt

ringHelp:
    mov B F
    lda A %x
    cmp 
    jz %helpEnd

    

ringEnd:

helpEnd:
    mov G H
    jmp %end

.data 
x = 20