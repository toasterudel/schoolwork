;
; Problem1.asm
;
; Created: 10/24/2017 8:06:34 PM
; Author : Chris Rudel
; CS 383
;


; Replace with your application code
.include "m328pdef.inc" 

start:
	ldi r16, 1 ; the counter
	ldi r17, 0 ; the sum
main:
	cpi r16, 16  ; check if loop has ran 15 times
	breq end     ; end if ^ is true
	add r17, r16 ; add to the sum
	inc r16		 ; increment the counter
	rjmp main	 ; go back to start of loop
end:
	out portB, r17 ; output
	nop ;