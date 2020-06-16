#define __SFR_OFFSET 0
#include "avr/io.h"
#include <avr/interrupt.h>
#include <avr/portpins.h>

.text
.global loop
.global setup
.global rock
.global paper
.global scissors
.global one
.global two

setup:
  ldi r16, 0b00000000
  ldi r17, 0b11111111
  ldi r18, 0b00000111
  ldi r19, 0
  out DDRB, r16
  out DDRD, r17
loop:
  out PORTB, r16
  rjmp loop


rock:
  sbis PIND, 7
