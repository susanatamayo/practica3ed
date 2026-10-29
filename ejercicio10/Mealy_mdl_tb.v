// Testbench de la máquina de estados Mealy (ejercicio 10)
`timescale 1ns/1ps

module Mealy_mdl_tb;

  reg  ix, iCLK, iRST;   // entradas
  wire oy;               // salida

  // Instancia de la máquina Mealy
  Mealy_mdl uut (.ix(ix), .oy(oy), .iCLK(iCLK), .iRST(iRST));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  // ix cambia a mitad de ciclo para ver que oy (Mealy) responde
  // de inmediato a la entrada, sin esperar al reloj
  initial
  begin
    iRST = 0; ix = 0;   // t = 0:   reset -> S0, oy = 0
    #15 iRST = 1;       // t = 15:  se libera el reset
        ix = 1;         //          30: S1, 50: S3, 70: S2, 90: S2
    #80 ix = 0;         // t = 95:  en S2 con ix = 0 -> oy = 1 YA
                        //          110: S0 -> oy = 0
    #20 ix = 1;         // t = 115: 130: S1
    #20 ix = 0;         // t = 135: en S1 con ix = 0 -> oy = 1 YA
                        //          150: S0 -> oy = 0
    #20 ix = 1;         // t = 155: 170: S1, 190: S3
    #40 ix = 0;         // t = 195: en S3 con ix = 0 -> oy = 1 YA
                        //          210: S0 -> oy = 0
    #25 $finish;        // t = 220
  end

  initial
    $monitor("t = %0t ns  iRST = %b  ix = %b  estado = %b  oy = %b",
             $time, iRST, ix, uut.Prstate, oy);

endmodule