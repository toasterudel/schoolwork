/* Katie Prescott & Chris Rudel */

#include "avr/io.h"
.global loop
.global setup
.global Long
.global dash
.global Short
.global dit
.global Stp
.global gap
setup:
  ldi r16, 0b00100000
  sts DDRB, r16

loop:
  call Long
  call Long
  call Long
  
  call Stp
  
  call Short
  call Short
  call Short
  
  call Stp
  
  call Long
  call Long
  call Long
  
  call Stp

  jmp loop

Long:
  ldi r16, 0b00100000
  sts PORTB, r16
  call dash
  ldi r17, 0b00000000
  sts PORTB, r17
  call dash
  ret
  
Short:
  ldi r16, 0b00100000
  sts PORTB, r16
  call dit
  ldi r17, 0b00000000
  sts PORTB, r17
  call dit
  ret
  
Stp:
  ldi r17, 0b00000000
  sts PORTB, r17
  call gap
  ret

dash:
    LDI r17, 250
L1: LDI R18, 125
L2: LDI R19, 125
L3:
    NOP
    NOP
    DEC R19
    BRNE L3
    DEC R18
    BRNE L2
    DEC R17
    BRNE L1
ret

dit:
    LDI r17, 100
L01: LDI R18, 100
L02: LDI R19, 100
L03:
    NOP
    NOP
    DEC R19
    BRNE L03
    DEC R18
    BRNE L02
    DEC R17
    BRNE L01
ret

gap:
    LDI r17, 250
L001: LDI R18, 150
L002: LDI R19, 150
L003:
    NOP
    NOP
    DEC R19
    BRNE L003
    DEC R18
    BRNE L002
    DEC R17
    BRNE L001
ret
