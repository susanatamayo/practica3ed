`timescale 1ns/1ps

module ejercicio1_tb;

  reg clock;

  // Alternativa 1: reloj con repeat
  initial
  begin
    clock = 1'b0;
    repeat (30)
      #10 clock = ~clock;
  end

  // Muestra en consola cada cambio del reloj
  initial
    $monitor("t = %0t ns  clock = %b", $time, clock);

endmodule