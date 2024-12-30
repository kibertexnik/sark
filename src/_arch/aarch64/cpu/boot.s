//--------------------------------
// Public Code
//--------------------------------
.section .text._start

//--------------------------------
// fn_start()
//--------------------------------
_start:
  // Infinitely wait for events
.L_parking_loop:
  wfe
  b .L_parking_loop

.size _start, . - _start
.type _start, function
.global _start
