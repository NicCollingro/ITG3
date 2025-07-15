; Rekursive Bestimmung der Summe
;
; Idee:
; Rekursion füllt Stack mit Argumenten und Rückstprungadresse bis n=1
; Jeder Call erzeugt 'push R' auf Stack
; Stack: 4 R0 3 R1 2 R2 1 R3
; Nach Rückkehr lies die drei obersten Stackeinträge ein
; Stack: 4 R0 3 R1 2 R2 1 
; und addiere beiden Argumente, schiebe sie auf den Stack und R
; Stack: 4 R0 3 R1 3 R2


.text
	ldx A %n
	push A			; Funktionsargument -> Stack
	call %fkt		; Aufruf
	pop A			; hole Ergebnis
	rout A
	hlt

fkt:	
	pop G			; Lies Rücksprungadresse und
	pop A			; Argumentliste (hier nur 1 Argument)

	ldi B 1			; Rekursionsbedingung n==1?
	cmp
	jne %rek		
		
end:				; ja => Return
	push A			; und schreibe sie direkt wieder
	push G			; auf den Stack
	ret

rek:
	push A			; und schreibe sie direkt wieder
	push G			; auf den Stack
	dec			; nein => n -> n-1 
	push A			; -> Stack
	call %fkt		; rekursiver Aufruf

	pop A			; lies die zwei obersten Einträge
	pop G			; (und die Rücksprungadresse)
	pop B
	add			; addiere sie
	push A			; und Schreibe Summe 
	push G			; und Rücksprungadresse zurück
	ret			; Return

.data
	n = 5
