// Testbench del flip-flop T (ejercicio 6)
`timescale 1ns/1ps

module T_FF_tb;

  reg  iT, iCLK, iRST;   // entradas
  wire oQ;               // salida

  // Instancia del flip-flop T
  T_FF uut (.oQ(oQ), .iT(iT), .iCLK(iCLK), .iRST(iRST));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  initial
  begin
    iRST = 0; iT = 0;   // t = 0:   reset -> oQ = 0
    #15 iRST = 1;       // t = 15:  se libera el reset
        iT = 1;         //          T = 1 -> cambia en 30, 50, 70
    #60 iT = 0;         // t = 75:  T = 0 -> mantiene en 90 y 110
    #40 iT = 1;         // t = 115: T = 1 -> cambia en 130 y 150
    #40 iRST = 0;       // t = 155: reset asincrónico -> oQ = 0 ya
    #15 $finish;        // t = 170
  end

  initial
    $monitor("t = %0t ns  iRST = %b  iCLK = %b  iT = %b  oQ = %b",
             $time, iRST, iCLK, iT, oQ);

endmodule