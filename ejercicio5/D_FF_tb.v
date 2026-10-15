// Testbench del flip-flop D con reset asincrónico (ejercicio 5)
`timescale 1ns/1ps

module D_FF_tb;

  reg  iD, iCLK, iRST;   // entradas
  wire oQ;               // salida

  // Instancia del flip-flop
  D_FF uut (.oQ(oQ), .iD(iD), .iCLK(iCLK), .iRST(iRST));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, 90, 110, 130 ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  initial
  begin
    iRST = 0; iD = 1;   // t = 0:  reset activo -> oQ = 0 desde el inicio
                        //         (en 10 ns el reloj no copia D)
    #15 iRST = 1;       // t = 15: se libera el reset
                        //         en 30 ns oQ = iD = 1
    #20 iD = 0;         // t = 35: en 50 ns oQ = 0
    #20 iD = 1;         // t = 55: en 70 ns oQ = 1
    #20 iRST = 0;       // t = 75: reset a mitad de ciclo -> oQ = 0 YA
                        //         en 90 ns el reloj está bloqueado
    #20 iRST = 1;       // t = 95: se libera; en 110 ns oQ = 1
    #40 $finish;        // t = 135
  end

  initial
    $monitor("t = %0t ns  iRST = %b  iCLK = %b  iD = %b  oQ = %b",
             $time, iRST, iCLK, iD, oQ);

endmodule