;
; Problem4.asm
;
; Created: 10/24/2017 8:21:24 PM
; Author : Christopher Rudel
;CS 383B


.include "m328pdef.inc"

start:
	ldi r20, 0b11001000; Load 200
	sts 0x0100, r20 ; Store 200
	ldi r20, 0b11001001 ;Load 201
	sts 0x0101, r20 ; Store 201	
	ldi r20, 0b11001010 ;Load 202	
	sts 0x0102, r20 ;Store 202
	ldi r20, 0b11001011 ;Load 203
	sts 0x0103, r20 ;Store 203
	ldi r20, 0b11001100 ;Load 204
	sts 0x0104, r20 ;Store 204
	ldi r20, 0b11001101 ;I think you get the idea
	sts 0x0105, r20 
	ldi r20, 0b11001110;206
	sts 0x0106, r20  
	ldi r20, 0b11001111;207
	sts 0x0107, r20 
	ldi r20, 0b11010000 ;208
	sts 0x0108, r20 
	ldi r20, 0b11010001;209
	sts 0x0109, r20 
	ldi r20, 0b11010010;210
	sts 0x010A, r20 
	ldi r20, 0b11010011;211
	sts 0x010B, r20 
	ldi r20, 0b11010100;212
	sts 0x010C, r20 
	ldi r20, 0b11010101;213
	sts 0x010D, r20
	ldi r20, 0b11010110;214
	sts 0x010E, r20 

	.def lSum = r16	;Defines lower byte of sum
	.def hSum = r17	;Defines higher byte of sum
	.def empty = r18	;Empty for carry
	.def i = r19	;counter
	.def get = r20 ;retriever
main:
	ldi zl, 0x00	; Loads the lower z register
	ldi zh, 0x01	; Loads the higher z reg
	ldi lSum, 0	; Loads lower byte as 0
	ldi hSum, 0	; Loads higher as 0
	ldi i, 0	; count starts at 0
loop:
	cpi i, 15	; Checks if i got to 10
	breq end	; If ^ then go to end
	ld get, z	; Sets get to z
	add lSum, get; Adds retrieved value to lSum
	adc hSum, empty	; Add carried value to hSum
	inc i	; i++
	inc zl	; zl++
	rjmp loop	; loop
end:
	out PORTB, lSum	; Output lower
	out PORTC, hSum	; Output higher
	nop	; Halts the program