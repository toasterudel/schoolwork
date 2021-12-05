;
; AssemblerApplication2.asm
;
; Created: 10/5/2017 7:30:14 PM
; Author : chris
;
; Replace with your application code
.include "m328pdef.inc"
.def i=16
.def j=17

Main:
	ldi i,5
	ldi j,0
	cpi i,0
	brge Else
	ldi j,i
	rjmp End
Else:
	ldi j,2

E	nd:
	nop