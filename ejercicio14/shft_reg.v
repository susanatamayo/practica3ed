// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 14: Registro de desplazamiento universal de 4 bits
//               (descripción ESTRUCTURAL, figura 7)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - stage: una etapa del registro = multiplexor 4x1 + flip-flop D.
//     * 1er always: multiplexor; según select elige i0..i3 -> D.
//     * 2do always: flip-flop D con clear asincrónico activo en
//       bajo; en cada flanco de subida guarda D en Q.
// - shft_reg: crea 4 instancias de stage (ST0..ST3) y las conecta
//   como en el diagrama lógico de la figura 7.
//
// CONEXIÓN DE LOS MULTIPLEXORES
// ------------------------------------------------------------
//   mux | select | ST0    ST1  ST2  ST3    | Operación
//   ----+--------+-------------------------+------------------
//   i0  |   00   | A0     A1   A2   A3     | Sin cambio
//   i1  |   01   | A1     A2   A3   irtin  | Derecha
//   i2  |   10   | ilfin  A0   A1   A2     | Izquierda
//   i3  |   11   | I0     I1   I2   I3     | Carga paralela
//
// DIFERENCIA CON EL EJERCICIO 13
// ------------------------------------------------------------
// - Ejercicio 13: comportamiento (qué hace: case + concatenación).
// - Ejercicio 14: estructural (cómo está construido: mux + FF).
// - Puertos: iI (entrada paralela) e iselect[1:0] (= {s1, s0}).
// - Mismo comportamiento: la simulación da los mismos valores.
//
// NOTA A LA GUÍA
// ------------------------------------------------------------
// - El comentario original dice "figura 3-7"; en la guía es la
//   figura 7.
// ============================================================

// Descripción estructural de registro universal de desplazamiento
module shft_reg (iI, iselect, ilfin, irtin, oA, iCLK, iClr);
  input  [3:0] iI;                  // Entrada paralela
  input  [1:0] iselect;             // Seleccionar modo
  input        ilfin, irtin, iCLK, iClr;   // Entradas en serie, reloj, clear
  output [3:0] oA;                  // Salida paralela

  // Crear ejemplares para las cuatro etapas
  //         i0     i1     i2     i3     Q      select   CLK   Clr
  stage ST0 (oA[0], oA[1], ilfin, iI[0], oA[0], iselect, iCLK, iClr);
  stage ST1 (oA[1], oA[2], oA[0], iI[1], oA[1], iselect, iCLK, iClr);
  stage ST2 (oA[2], oA[3], oA[1], iI[2], oA[2], iselect, iCLK, iClr);
  stage ST3 (oA[3], irtin, oA[2], iI[3], oA[3], iselect, iCLK, iClr);

endmodule

// Una etapa del registro de desplazamiento
module stage (i0, i1, i2, i3, Q, select, CLK, Clr);
  input       i0, i1, i2, i3, CLK, Clr;
  input [1:0] select;
  output reg  Q;

  reg D;

  // Multiplexor 4x1
  always @ (i0 or i1 or i2 or i3 or select)
    case (select)
      2'b00: D = i0;
      2'b01: D = i1;
      2'b10: D = i2;
      2'b11: D = i3;
    endcase

  // Flip-flop D
  always @ (posedge CLK or negedge Clr)
    if (~Clr) Q = 1'b0;
    else      Q = D;

endmodule