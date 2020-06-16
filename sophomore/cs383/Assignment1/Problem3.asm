;
; Problem3.asm
;
; Created: 10/24/2017 8:06:34 PM
; Author : Chris Rudel
; CS 383
;


.include "m328pdef.inc"
; Replace with your application code
start:
	ldi zl, 0x00	;Set zl to 0 in hex
	ldi zh, 0x01	;Set zh to 1 in hex
	ld r16, z		;Load z to r16
	ldi zl, 0x01	;Set zl to the hex value 1
	ld r17, z		;Load the new z into r17
	cp r16, r17		;Compare r16 to r17
	brge gThan	;Branch if r16>=r17
	out portB, r17	;Output if r17>r16
	rjmp end	    ; End 
gThan:
	out portB, r16	;Output if r16>=r17
end:
	nop ;Halt