// Testbench del flip-flop JK con if - else if (ejercicio 9)
`timescale 1ns/1ps

module JK_FF_tb;

  reg  iJ, iK, iCLK;     // entradas
  wire oQ, oQnot;        // salidas

  // Instancia del flip-flop JK (conexión por nombre)
  JK_FF uut (.iJ(iJ), .iK(iK), .iCLK(iCLK), .oQ(oQ), .oQnot(oQnot));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  initial
  begin
    iJ = 0; iK = 1;        // t = 0:   RESET    -> en 10 oQ = 0
    #15 iJ = 1; iK = 0;    // t = 15:  SET      -> en 30 oQ = 1
    #20 iJ = 0; iK = 0;    // t = 35:  MANTIENE -> en 50 oQ = 1
    #20 iJ = 0; iK = 1;    // t = 55:  RESET    -> en 70 oQ = 0
    #20 iJ = 1; iK = 1;    // t = 75:  TOGGLE   -> 1 en 90, 0 en 110,
                           //                      1 en 130
    #65 $finish;           // t = 140
  end

  initial
    $monitor("t = %0t ns  iCLK = %b  iJ = %b  iK = %b  oQ = %b  oQnot = %b",
             $time, iCLK, iJ, iK, oQ, oQnot);

endmodule