# Pines del ejercicio 10 (máquina Mealy) - DE0-CV
set_location_assignment PIN_U13 -to ix             ;# SW0
set_location_assignment PIN_U7  -to iCLK           ;# KEY0 (reloj manual)
set_location_assignment PIN_W9  -to iRST           ;# KEY1 (reset)
set_location_assignment PIN_AA2 -to oy             ;# LEDR0
set_location_assignment PIN_L1  -to {oEstado[1]}   ;# LEDR9 (A)
set_location_assignment PIN_L2  -to {oEstado[0]}   ;# LEDR8 (B)

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to ix
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oy
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to {oEstado[1]}
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to {oEstado[0]}

export_assignments