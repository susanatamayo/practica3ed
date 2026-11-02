# Pines del ejercicio 6 (flip-flop T) - DE0-CV
set_location_assignment PIN_U13 -to iT     ;# SW0
set_location_assignment PIN_U7  -to iCLK   ;# KEY0 (reloj manual)
set_location_assignment PIN_W9  -to iRST   ;# KEY1 (reset)
set_location_assignment PIN_AA2 -to oQ     ;# LEDR0

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oQ

export_assignments