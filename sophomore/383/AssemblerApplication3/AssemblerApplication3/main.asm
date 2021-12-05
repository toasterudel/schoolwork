;
; AssemblerApplication3.asm
;
; Created: 10/12/2017 7:15:32 PM
; Author : chris
;


; Replace with your application code
.include "m325def.inc"
init:
.def i = r16
.def n = r17
.def sum = r18
main:
	ldi i, 1
	ldi n, 2
	ldi sum, 0
	rjmp CMP
CMP:
	cp i,n
	brlt LOOP
LOOP
	mul i,i
	add sum, r0
	inc i
	rjmp CMP	