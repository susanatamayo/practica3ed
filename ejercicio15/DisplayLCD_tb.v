// Testbench del controlador LCD (ejercicio 15)
`timescale 1ns/1ps

module DisplayLCD_tb;

  reg        CLK, RST;                   // entradas
  wire       E, RS, RW, INIlisto;        // salidas
  wire [7:0] DATOS;

  // Instancia del controlador
  DisplayLCD uut (.CLK(CLK), .RST(RST), .E(E), .RS(RS), .RW(RW),
                  .INIlisto(INIlisto), .DATOS(DATOS));

  // Reloj de 50 MHz (período de 20 ns), igual al de la tarjeta
  initial CLK = 1'b0;
  always  #10 CLK = ~CLK;

  initial
  begin
    RST = 0;                // pulsador presionado -> reset
    #1000 RST = 1;          // se suelta a 1 us
    #25000000 $finish;      // 25 ms (la secuencia dura ~23 ms)
  end

  // Muestra en consola cada byte que la LCD toma (flanco de
  // bajada de E). Se omiten los 00H de las esperas.
  always @ (negedge E)
    if (RS)
      $display("t = %0t ns  CARACTER     %h  '%c'", $time, DATOS, DATOS);
    else if (DATOS != 8'h00)
      $display("t = %0t ns  INSTRUCCION  %h", $time, DATOS);

endmodule