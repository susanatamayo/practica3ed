# ============================================================
# Ejercicio 1 - Crea el proyecto de Quartus y asigna los pines
# Tarjeta: DE0-CV (Cyclone V 5CEBA4F23C7)
# ============================================================

project_new ejercicio1_fpga -overwrite

# Dispositivo y archivo principal
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CEBA4F23C7
set_global_assignment -name TOP_LEVEL_ENTITY ejercicio1_fpga
set_global_assignment -name VERILOG_FILE ejercicio1_fpga.v

# Pines
set_location_assignment PIN_M9  -to iCLK_50   ;# reloj de 50 MHz
set_location_assignment PIN_U7  -to iRST      ;# KEY0
set_location_assignment PIN_AA2 -to oCLOCK    ;# LEDR0
set_location_assignment PIN_L1  -to oFIN      ;# LEDR9

# Estándar de voltaje de la DE0-CV
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iCLK_50
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to iRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oCLOCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to oFIN

project_close