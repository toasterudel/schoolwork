;
; Problem2.asm
;
; Created: 10/24/2017 8:17:33 PM
; Author : Chris Rudel
; CS 383


.include "m328pdef.inc"

start:
	ldi r17, 1	;Loads 1 into r17
	ldi r16, 0	; Loads 0 into r17
	ldi zh, 0x01; Sets high end of z to 01
	ldi zl, 0x00; sets low end of z to 00

loop0:
	cpi r16, 10	;Compares r16 and 10
	breq mid	;If the same it branches
	inc r16		;r16++
	st z, r17	;Loads the number in r17 to the memory space 0x0100
	inc zl		;zl++
	inc r17		;r17++
	rjmp loop0  ;go back to start of loop
mid:
	ldi zl, 0x00; puts zl back at 0
	ldi r16,0	; puts r16 back at 0
loop1:
	cpi r16, 10	;Compares r16 and 10
	breq end	;If =, go to end
	ld r20, z	; Loads z into r20
	inc r16		;r16++
	inc zl		;zl++
	out portB, r20	;Outputs r20
	rjmp loop1	;goes back
end:
	nop ;Halts