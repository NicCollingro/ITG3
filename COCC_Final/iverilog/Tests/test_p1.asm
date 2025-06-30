.text

alutest:
	ldi A 0xFF
	ldi B 0x0F
	and
	mov G A
	rout A

	ldi A 0xFF
	or
	mov F A
	stx A %out
	mout %out		; OUT: 0xff

	ldi A 0xFF
	xor
	mov E A	
	stx A %out
	mout %out		; OUT: 0xf0

	ldi A 0xFF
	add
	mov D A
	stx A %out
	mout %out		; OUT: 0x(1)0e 

	ldi A 1
	ldi B 2
	sub
	stx A %out
	mout %out		; OUT: 0x(1)ff
	jmp %calltest

calltest:
	ldi A 0x0A
	stx A %out
	mout %out		
	call %load
	stx A %out
	mout %out		; OUT: 0x0a, 0x2a, 0x0a
	jmp %multest		
load:
	push A
	ldi A 42
	call %done
	pop A
	ret
done:
	stx A %out
	mout %out
	ret

multest:
	ldx A %r
	ldi B 4
	add
	stx A %r

	ldx A %i
	dec
	stx A %i

	jnz %multest

	ldx A %r
	stx A %out
	mout %out		; OUT: 0x14
	jmp %divtest

divtest:
	ldx A %n	
	ldx B %d	
	ldi C 0		
loopdivtest:
	cmp 
	jc %donedivtest	
	sub		
	stx A %n	
	mov A C		
	inc		
	mov C A		
	ldx A %n	
	jmp %loopdivtest	
donedivtest:
	stx A %out
	mout %out		; OUT: 0x04
	mov B A		
	mov A C		
	stx A %out
	mout %out		; OUT: 0x19
	jmp %alumultest

alumultest:
	ldx B %fb
	ldx A %fa
	mlo
	stx A %out
	mout %out		; OUT: 0xf4
	ldx A %fa
	mhi
	stx A %out
	mout %out		; OUT: 0x03
	jmp %nottest

nottest:
	ldi A 0xaa
	not
	stx A %out
	mout %out		; OUT: 0x55
	jmp %shifttest

shifttest:
	ldi A 0xaa
	ldi B 4
	shl
	stx A %out
	mout %out		; OUT: 0xa0
	rol
	stx A %out
	mout %out		; OUT: 0x41
	ldi B 2
	shr
	stx A %out
	mout %out		; OUT: 0x10
	jmp %sqrttest

sqrttest:
	ldi A 128		
	sqrt
	stx A %out
	mout %out		; OUT: 0x0b
	ldi A 255		
	sqrt
	stx A %out
	mout %out		; OUT: 0x0f
	hlt

.data
	n = 129		; Zähler
	d = 5		; Nenner
	r = 8
	i = 3
	s = 4
	fa = 44
	fb = 23
	out = 0x5a
