// Testbench del latch D (ejercicio 3)
`timescale 1ns/1ps

module D_latch_tb;

  reg  iD, icontrol;   // entradas (las genera el testbench)
  wire oQ;             // salida del latch

  // Instancia del latch
  D_latch uut (.oQ(oQ), .iD(iD), .icontrol(icontrol));

  initial
  begin
    icontrol = 0; iD = 0;   // oQ empieza desconocido (x)
    #10 icontrol = 1;       // habilitado: oQ = iD = 0
    #10 iD = 1;             // transparente: oQ = 1
    #10 iD = 0;             // oQ = 0
    #10 iD = 1;             // oQ = 1
    #10 icontrol = 0;       // se deshabilita: guarda oQ = 1
    #10 iD = 0;             // oQ se mantiene en 1
    #10 iD = 1;             // oQ se mantiene en 1
    #10 iD = 0;             // oQ se mantiene en 1
    #10 icontrol = 1;       // se habilita otra vez: oQ = iD = 0
    #10 iD = 1;             // oQ = 1
    #10 $finish;
  end

  initial
    $monitor("t = %0t ns  icontrol = %b  iD = %b  oQ = %b",
             $time, icontrol, iD, oQ);

endmodule