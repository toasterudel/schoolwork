#include "avr/io.h"
#define __SFR_OFFSET 0

.global loop
.global setup
setup:
  ldi r16, 0xFF
  ldi r17, 0xFF
  out DDRB, r16

loop:
  out PORTB, r17
