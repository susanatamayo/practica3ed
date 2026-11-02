# Pines del ejercicio 8 (flip-flop JK con case) - DE0-CV
set_location_assignment PIN_U13 -to iJ      ;# SW0
set_location_assignment PIN_V13 -to iK      ;# SW1
set_location_assignment PIN_U7  -to iCLK    ;# KEY0 (reloj manual)
set_location_assignment PIN_AA2 -to oQ      ;# LEDR0
set_location_assignment PIN_AA1 -to oQnot   ;# LEDR1

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iJ
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oQ
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oQnot

export_assignments