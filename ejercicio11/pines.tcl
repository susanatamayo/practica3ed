# Pines del ejercicio 11 (máquina Moore) - DE0-CV
set_location_assignment PIN_U13 -to ix         ;# SW0
set_location_assignment PIN_U7  -to iCLK       ;# KEY0 (reloj manual)
set_location_assignment PIN_W9  -to iRST       ;# KEY1 (reset)
set_location_assignment PIN_L1  -to {oAB[1]}   ;# LEDR9 (A)
set_location_assignment PIN_L2  -to {oAB[0]}   ;# LEDR8 (B)

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ix
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to {oAB[1]}
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to {oAB[0]}

export_assignments