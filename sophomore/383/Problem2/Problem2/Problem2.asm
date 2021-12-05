;
; Problem2.asm
;
; Created: 10/24/2017 8:17:33 PM
; Author : Chris Rudel
;


.include "m328pdef.inc"

start:
ldi r18, 1	;Loads 1 into r18
ldi r16, 0	; Loads 0 into r17
ldi zh, 0x01; Sets high end of z to 01
ldi zl, 0x00; sets low end of z to 00

loop:
cpi r16, 10	;Checks comparison of r16 and 9
breq intermediate	;If the same it branches
inc r16 ;Raises r16 by 1
st z, r18	;Loads the number in r18 to the memory space 0x0100
inc zl ;Increments zl
inc r18 ;Increments the number to be stored
rjmp loop
intermediate:
ldi zl, 0x00; Resets zl to 0
ldi r16,0
loop2:
cpi r16, 10	;Checks comparison of r16 and 9
breq end	;If the same it branches
ld r20, z	; Loads z into r20
inc r16
inc zl ;Increments zl
out portB, r20	;Outputs r20
rjmp loop2	;Loops back
end:
nop ;Halts