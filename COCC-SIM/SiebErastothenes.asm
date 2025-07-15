;A = Calc
;B = Calc
;C = Current MinRamPos
;D = Current RamPos
;E = Current Number
;F = 
;G = 0


.text
;Sieve init ist hier statisch also schon erledigt.

init:
	ldi A %b
	mov C A
	ldi G 0
	mov D A

sieveInit:
	lda B
	mov E B
	
sieveInner:
	mov A D
	mov B E
	add
	sta G
	mov D A
	ldi B %p
	cmp
	jz %incMinRamPos
	jnc %incMinRamPos
	jmp %sieveInner

incMinRamPos:
	mov A E
	inc
	mov E A
	mov A C
	inc
	mov C A
	ldi B %p
	cmp
	mov D C
	jc %sieveCheckIfZero
	jmp %end

sieveCheckIfZero:
	mov A D
	lda B
	mov A G
	cmp
	jz %incMinRamPos
	jmp %sieveInner

end:
	hlt

.data
	a = 1
	b = 2
	c = 3
	d = 4
	e = 5
	f = 6
	g = 7
	h = 8
	i = 9
	j = 10
	k = 11
	l = 12
	m = 13
	n = 14
	o = 15
	P = 16
	q = 17
	r = 18
	s = 19
	t = 20
	u = 21
	v = 22
	w = 23
	x = 24
	y = 25
	z = 26
	I = 27
	J = 28
	K = 29
	L = 30
	M = 31
	p = 32
