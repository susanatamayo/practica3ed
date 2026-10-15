// ============================================================
// Práctica 3 - Ejercicio 2 en la DE0-CV
// Reloj de operación libre (equivalente sintetizable de always)
// ============================================================
//
// - always #10 clock = ~clock no es sintetizable, así que el
//   reloj se genera dividiendo el oscilador de 50 MHz.
// - Cada 25 000 000 pulsos (0,5 s) se invierte oCLOCK:
//   período = 1 s (1 Hz), duty cycle = 50 %.
// - Igual que always: oscila indefinidamente.
// - $finish no tiene equivalente en hardware (la tarjeta no
//   "termina"); el reloj solo se detiene mientras se mantiene
//   presionado iRST (KEY0, activo en bajo).
// ============================================================

module ejercicio2_fpga (iCLK_50, iRST, oCLOCK);
  input      iCLK_50;          // reloj de 50 MHz de la tarjeta
  input      iRST;             // KEY0: 0 al presionar
  output reg oCLOCK;           // reloj lento -> LEDR0

  parameter MEDIO_PERIODO = 25000000;  // 0,5 s a 50 MHz

  reg [24:0] cont;             // contador divisor de frecuencia

  always @(posedge iCLK_50 or negedge iRST)
    if (~iRST)
    begin
      cont   <= 0;
      oCLOCK <= 1'b0;          // el reloj arranca en 0
    end
    else if (cont == MEDIO_PERIODO - 1)
    begin
      cont   <= 0;
      oCLOCK <= ~oCLOCK;       // equivalente a clock = ~clock
    end
    else
      cont <= cont + 1;

endmodule