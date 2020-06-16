;
; Problem6.asm
;
; Created: 10/24/2017 8:06:34 PM
; Author : Chris Rudel
; CS 383
;


.include "m328pdef.inc"
start:
	.def lSum = r16	;lower byte of sum
	.def hSum = r17	;higher byte of sum
	.def empty = r18;defines empty for carry
	.def i = r19 ;defines counter
	.def get = r20 ;gets number from memory

main:
	ldi r21, 5 ; loads 5 into r21
	sts 0x0100, r21 ; 
	ldi lSum, 0 ; sets lower sum to 0
	ldi hSum, 0 ; sets higher sum to 0
	ldi empty, 0	; sets empty to 0
	ldi zl, 0x00	; sets lower of z
	ldi zh, 0x01	; sets higher of z
	ldi i, 0		; sets counter to 0
	ld get, z		; gets number out of mem
	inc get			; get++
loop:
	cp i, get	; Compares counter to memory number
	breq end	; If equal go to end
	add lSum, i	; adds counter to lower
	adc hSum, empty	; add carry into higher
	inc i		; i++
	rjmp loop	; goes back to the loop
end:
	out PORTB, lSum	; Output lower
	out PORTC, hSum	; Output higher
	nop	; Halts the program