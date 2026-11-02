# Pines del ejercicio 2 - DE0-CV
set_location_assignment PIN_M9  -to iCLK_50
set_location_assignment PIN_U7  -to iRST
set_location_assignment PIN_AA2 -to oCLOCK

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oCLOCK

export_assignments