.text
    ldx A %x
    ldx B %y
    cmp
    je %equal
    add
    jmp %end
equal:
    sub
end:
    stx A %z
    hlt
.data
    x=5
    y=5
    z=0
