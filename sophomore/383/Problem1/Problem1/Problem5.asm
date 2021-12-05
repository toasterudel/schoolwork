;
; Problem5.asm
;
; Created: 10/24/2017 8:06:34 PM
; Author : Chris Rudel
; CS 383
;


.include "m328pdef.inc"
start:
	.def ma = r19	;Sets max to r19
	ldi r20, 0b00000001 ; Loads 1 
	sts 0x0100, r20 ; Stores 1
	ldi r20, 0b00000010	; Loads 2
	sts 0x0101, r20 ; Stores 2
	ldi r20, 0b00000011	; Loads 3
	sts 0x0102, r20 ; Stores 3
	ldi r20, 0b00000100	; Loads 4
	sts 0x0103, r20 ; Stores 4
	ldi r20, 0b00000101	;5
	sts 0x0104, r20 
	ldi r20, 0b00000110	;6
	sts 0x0105, r20 
	ldi r20, 0b00000111	;7
	sts 0x0106, r20 
	ldi r20, 0b00001000 ;8	
	sts 0x0107, r20	
	ldi r20, 0b00001001	;9
	sts 0x0108, r20	
	ldi r20, 0b00001010	;10
	sts 0x0109, r20	
	ldi r20, 0b00001011	;11
	sts 0x010A, r20	
	ldi r20, 0b00001100	;12
	sts 0x010B, r20	
	ldi r20, 0b00001101	;13
	sts 0x010C, r20	
	ldi r20, 0b00001110	;14
	sts 0x010D, r20	
	ldi r20, 0b00001111	;15
	sts 0x010E, r20	

main:
	ldi r17, 0	; counter set to 0
	ldi zl, 0x00	;lower is setup
	ldi zh, 0x01	;higher is setup 
	ld ma, z	;sets max = first element
loop:
	cpi r17, 15	; Check if it got to 15
	breq end	; If ^, go to end
	ld r18, z	; Load z into r18
	cp ma, r18	;Check if max  < z
	brlt loop1	;If ^ branch to loop1
last:
	inc zl	; zl++
	inc r17	; counter++
	rjmp loop	; Back to beginning of loop
loop1:
	ld ma, z	;Replace max with z
	rjmp last	;Finish loop
end:
	out PortB, ma	;Output max
	nop	;Halt the program