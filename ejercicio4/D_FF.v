// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 4: Flip-flop D (disparado por flanco de subida)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - always @ (posedge iCLK): el bloque se ejecuta SOLO cuando
//   el reloj pasa de 0 a 1 (flanco de subida).
// - oQ = iD: en ese instante la salida copia la entrada D.
// - Entre flancos, aunque iD cambie, oQ conserva su valor.
// - oQ es reg porque se asigna dentro de un always.
//
// DIFERENCIA CON EL LATCH D (ejercicio 3)
// ------------------------------------------------------------
// - Latch: sensible al NIVEL; copia D mientras control = 1.
// - Flip-flop: sensible al FLANCO; copia D solo en el instante
//   del flanco de subida del reloj.
//
// TABLA DE FUNCIONAMIENTO
// ------------------------------------------------------------
//   iCLK          | iD | oQ(t+1)
//   --------------+----+-------------
//   0, 1 o bajada | X  | sin cambio
//   subida (^)    | 0  | 0
//   subida (^)    | 1  | 1
// ============================================================

module D_FF (oQ, iD, iCLK);
  output oQ;
  input  iD, iCLK;
  reg    oQ;

  always @ (posedge iCLK)
    oQ = iD;

endmodule