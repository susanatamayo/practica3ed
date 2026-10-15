// Testbench del flip-flop JK (ejercicio 7)
`timescale 1ns/1ps

module JK_FF_tb;

  reg  iJ, iK, iCLK, iRST;   // entradas
  wire oQ;                   // salida

  // Instancia del flip-flop JK
  JK_FF uut (.oQ(oQ), .iJ(iJ), .iK(iK), .iCLK(iCLK), .iRST(iRST));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  initial
  begin
    iRST = 0; iJ = 0; iK = 0;   // t = 0:   reset -> oQ = 0
    #15 iRST = 1;               // t = 15:  se libera el reset
        iJ = 1; iK = 0;         //          SET    -> en 30 oQ = 1
    #20 iJ = 0; iK = 0;         // t = 35:  MANTIENE -> en 50 oQ = 1
    #20 iJ = 0; iK = 1;         // t = 55:  RESET  -> en 70 oQ = 0
    #20 iJ = 1; iK = 1;         // t = 75:  TOGGLE -> 1 en 90, 0 en 110,
                                //                    1 en 130
    #60 iRST = 0;               // t = 135: reset asincrónico -> oQ = 0 ya
    #15 $finish;                // t = 150
  end

  initial
    $monitor("t = %0t ns  iRST = %b  iCLK = %b  iJ = %b  iK = %b  oQ = %b",
             $time, iRST, iCLK, iJ, iK, oQ);

endmodule