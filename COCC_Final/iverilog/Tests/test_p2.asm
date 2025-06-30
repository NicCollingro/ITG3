.text
	ldi A 0x11
	ldi B 0x22
	ldi C 0x33
	ldi D 0x44
	ldi E 0x55
	ldi F 0x66
	ldi G 0x77

	rout A
	rout B
	rout C
	rout D
	rout E
	rout F
	rout G
	
	mout %gx
	mout %gy
	mout %gz

	ldi A 0
	ldi B 0
	ldi C 0
	ldi D 0
	ldi E 0
	ldi F 0
	ldi G 0

	rin A
	rin B
	rin C
	rout A
	rout B
	rout C

	min %gx
	min %gy
	min %gz
	mout %gx
	mout %gy
	mout %gz

	hlt

.data
	gx = 0xaa
	gy = 0xbb
	gz = 0xcc
