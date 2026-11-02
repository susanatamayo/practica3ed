# Pines del ejercicio 13 (registro de desplazamiento universal) - DE0-CV
set_location_assignment PIN_U13 -to {iPin[0]}  ;# SW0
set_location_assignment PIN_V13 -to {iPin[1]}  ;# SW1
set_location_assignment PIN_T13 -to {iPin[2]}  ;# SW2
set_location_assignment PIN_T12 -to {iPin[3]}  ;# SW3
set_location_assignment PIN_AA15 -to irtin     ;# SW4
set_location_assignment PIN_AB15 -to ilfin     ;# SW5
set_location_assignment PIN_AB13 -to is0       ;# SW8
set_location_assignment PIN_AB12 -to is1       ;# SW9
set_location_assignment PIN_U7  -to iCLK       ;# KEY0 (reloj manual)
set_location_assignment PIN_W9  -to iClr       ;# KEY1 (clear)
set_location_assignment PIN_AA2 -to {oA[0]}    ;# LEDR0
set_location_assignment PIN_AA1 -to {oA[1]}    ;# LEDR1
set_location_assignment PIN_W2  -to {oA[2]}    ;# LEDR2
set_location_assignment PIN_Y3  -to {oA[3]}    ;# LEDR3

foreach senal {{iPin[0]} {iPin[1]} {iPin[2]} {iPin[3]} irtin ilfin is0 is1 iCLK iClr {oA[0]} {oA[1]} {oA[2]} {oA[3]}} {
  set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to $senal
}

export_assignments