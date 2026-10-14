// Testbench del flip-flop D (ejercicio 4)
`timescale 1ns/1ps

module D_FF_tb;

  reg  iD, iCLK;   // entradas
  wire oQ;         // salida

  // Instancia del flip-flop
  D_FF uut (.oQ(oQ), .iD(iD), .iCLK(iCLK));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, 90, 110 ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  // Estímulos de D (cambian ENTRE flancos)
  initial
  begin
    iD = 0;          // t = 0   -> en 10 ns oQ = 0
    #15 iD = 1;      // t = 15  -> en 30 ns oQ = 1
    #20 iD = 0;      // t = 35  -> en 50 ns oQ = 0
    #20 iD = 1;      // t = 55  -> pulso corto entre flancos...
    #10 iD = 0;      // t = 65  -> ...se ignora: en 70 ns oQ sigue en 0
    #10 iD = 1;      // t = 75  -> en 90 ns oQ = 1
    #45 $finish;     // t = 120
  end

  initial
    $monitor("t = %0t ns  iCLK = %b  iD = %b  oQ = %b",
             $time, iCLK, iD, oQ);

endmodule