// Testbench de la máquina de estados Moore (ejercicio 11)
`timescale 1ns/1ps

module Moore_mdl_tb;

  reg        ix, iCLK, iRST;   // entradas
  wire [1:0] oAB;              // salida (estado)

  // Instancia de la máquina Moore
  Moore_mdl uut (.ix(ix), .oAB(oAB), .iCLK(iCLK), .iRST(iRST));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  // ix cambia a mitad de ciclo: oAB (Moore) NO responde hasta
  // el siguiente flanco del reloj
  initial
  begin
    iRST = 0; ix = 1;   // t = 0:   reset -> S0 (oAB = 00)
    #15 iRST = 1;       // t = 15:  ix = 1 -> 30: se queda en S0
    #20 ix = 0;         // t = 35:  50: S1 (01)
    #20 ix = 1;         // t = 55:  70: S2 (10), 90: S2
    #40 ix = 0;         // t = 95:  110: S3 (11), 130: S0 (00),
                        //          150: S1 (01), 170: S3 (11)
    #80 ix = 1;         // t = 175: 190: se queda en S3
    #25 $finish;        // t = 200
  end

  initial
    $monitor("t = %0t ns  iRST = %b  ix = %b  oAB = %b",
             $time, iRST, ix, oAB);

endmodule