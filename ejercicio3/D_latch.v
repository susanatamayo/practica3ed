// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 3: Latch D (modelado de comportamiento)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - always @ (icontrol or iD): el bloque se ejecuta cada vez que
//   cambia icontrol o iD (sensible al NIVEL, no al flanco).
// - if (icontrol) oQ = iD:
//     icontrol = 1 -> latch transparente: oQ sigue a iD.
//     icontrol = 0 -> no hay else, oQ conserva su último valor
//                     (memoria).
// - oQ es reg porque se asigna dentro de un always.
//
// TABLA DE FUNCIONAMIENTO
// ------------------------------------------------------------
//   icontrol | iD | oQ
//   ---------+----+------------------
//       0    | X  | sin cambio (guarda)
//       1    | 0  | 0
//       1    | 1  | 1
// ============================================================

module D_latch (oQ, iD, icontrol);
  output oQ;
  input  iD, icontrol;
  reg    oQ;

  always @ (icontrol or iD)
    if (icontrol) oQ = iD;   // Es igual a: if (icontrol == 1)

endmodule