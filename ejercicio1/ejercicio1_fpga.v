// ============================================================
// Práctica 3 - Ejercicio 1 en la DE0-CV
// Reloj limitado (equivalente sintetizable de initial + repeat)
// ============================================================
//
// - initial, #10 y repeat no son sintetizables, así que el reloj
//   se genera dividiendo el oscilador de 50 MHz de la tarjeta.
// - Cada 25 000 000 pulsos (0,5 s) se invierte oCLOCK:
//   período = 1 s (1 Hz), duty cycle = 50 %.
// - Igual que repeat (30): hace 30 cambios (15 ciclos) y se
//   queda en 0. oFIN se enciende cuando termina.
// - iRST (KEY0, activo en bajo) reinicia todo, como el
//   clock = 1'b0 del initial.
// ============================================================

module ejercicio1_fpga (iCLK_50, iRST, oCLOCK, oFIN);
  input      iCLK_50;          // reloj de 50 MHz de la tarjeta
  input      iRST;             // KEY0: 0 al presionar
  output reg oCLOCK;           // reloj lento -> LEDR0
  output     oFIN;             // LEDR9: terminó de oscilar

  parameter MEDIO_PERIODO = 25000000;  // 0,5 s a 50 MHz

  reg [24:0] cont;             // contador divisor de frecuencia
  reg [4:0]  cambios;          // cuenta los cambios (0 a 30)

  assign oFIN = (cambios == 5'd30);

  always @(posedge iCLK_50 or negedge iRST)
    if (~iRST)
    begin
      cont    <= 0;
      cambios <= 0;
      oCLOCK  <= 1'b0;         // el reloj arranca en 0
    end
    else if (cambios < 5'd30)  // equivalente a repeat (30)
    begin
      if (cont == MEDIO_PERIODO - 1)
      begin
        cont    <= 0;
        oCLOCK  <= ~oCLOCK;    // equivalente a clock = ~clock
        cambios <= cambios + 1;
      end
      else
        cont <= cont + 1;
    end

endmodule