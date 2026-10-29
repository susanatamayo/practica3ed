// ============================================================
// Estímulo para probar el circuito secuencial (ejercicio 12)
// ============================================================
// - Primer initial: 16 cambios del reloj cada 5 ns = 8 ciclos
//   con período de 10 ns (flancos de subida en 10, 20, ..., 80).
// - Segundo initial: x cambia cada 10 ns en los flancos de
//   BAJADA del reloj (15, 25, 35, ...), así está estable en cada
//   flanco de subida.
// - No tiene $finish: la simulación termina sola cuando ya no
//   hay más eventos (t = 95 ns).
// ============================================================

`timescale 1ns/1ps

module testTcircuit;
  reg  x, CLK, RST;            // entradas del circuito
  wire y, A, B;                // salidas del circuito

  Tcircuit TC (x, y, A, B, CLK, RST);   // se crea un ejemplar del circuito

  initial
  begin
    RST = 0;                   // reset activo -> AB = 00
    CLK = 0;
    #5 RST = 1;                // se libera el reset
    repeat (16)
      #5 CLK = ~CLK;           // 8 ciclos de 10 ns
  end

  initial
  begin
    x = 0;
    #15 x = 1;
    repeat (8)
      #10 x = ~x;              // x alterna en los flancos de bajada
  end

  initial
    $monitor("t = %0t ns  RST = %b  CLK = %b  x = %b  AB = %b%b  y = %b",
             $time, RST, CLK, x, A, B, y);

endmodule