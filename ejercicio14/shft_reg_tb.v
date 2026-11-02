// Testbench del registro de desplazamiento estructural (ejercicio 14)
// Mismo estímulo del ejercicio 13 para comparar los resultados
`timescale 1ns/1ps

module shft_reg_tb;

  reg  [3:0] iI;                       // entrada paralela
  reg  [1:0] iselect;                  // modo {s1, s0}
  reg        ilfin, irtin, iCLK, iClr; // entradas
  wire [3:0] oA;                       // salida

  // Instancia del registro
  shft_reg uut (.iI(iI), .iselect(iselect), .ilfin(ilfin), .irtin(irtin),
                .oA(oA), .iCLK(iCLK), .iClr(iClr));

  // Reloj de 20 ns: flancos de subida en 10, 30, 50, 70, ... ns
  initial iCLK = 1'b0;
  always  #10 iCLK = ~iCLK;

  initial
  begin
    iClr = 0; iselect = 2'b00;         // t = 0:   CLEAR -> 0000
    iI = 4'b0000; irtin = 0; ilfin = 0;
    #15 iClr = 1;                      // t = 15:  se libera el Clear
        iselect = 2'b11;               //          CARGA PARALELA
        iI = 4'b1011;                  //          30: oA = 1011
    #20 iselect = 2'b00;               // t = 35:  SIN CAMBIO
                                       //          50: oA = 1011
    #20 iselect = 2'b01;               // t = 55:  DERECHA
        irtin = 1;                     //          70: oA = 1101
    #20 irtin = 0;                     // t = 75:  90: oA = 0110
    #20 iselect = 2'b10;               // t = 95:  IZQUIERDA
        ilfin = 1;                     //          110: oA = 1101
    #20 ilfin = 0;                     // t = 115: 130: oA = 1010
    #20 iClr = 0;                      // t = 135: CLEAR asincrónico
                                       //          oA = 0000 YA
    #15 $finish;                       // t = 150
  end

  initial
    $monitor("t = %0t ns  iClr = %b  iselect = %b  iI = %b  irtin = %b  ilfin = %b  oA = %b",
             $time, iClr, iselect, iI, irtin, ilfin, oA);

endmodule