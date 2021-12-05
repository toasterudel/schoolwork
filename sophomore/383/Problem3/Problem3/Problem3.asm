;
; Problem3.asm
;
; Created: 10/24/2017 8:21:24 PM
; Author : chris
;

.include "m328pdef.inc"
; Replace with your application code
start:
ldi zh, 0x01	;Set zh
ldi zl, 0x00	;Set zl
ld r16, z ; Load z into r16
ldi zl, 0x01	;Set zl to 0x01
ld r17, z ;Load the new z into r17
cp r16, r17 ;Compare r16 to r17
brge greater	;If r16 is greater than or equal to r17 branch
out portB, r17	;Output r17
rjmp end ; End
greater:
out portB, r16	;If r16 was greater or equal output that number
end:
nop ;Halt