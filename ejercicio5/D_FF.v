// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 5: Flip-flop D con restablecimiento asincrónico
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - always @(posedge iCLK or negedge iRST): el bloque se ejecuta
//   en el flanco de subida del reloj O cuando iRST baja a 0.
// - if (~iRST) oQ = 1'b0: si iRST = 0, la salida se pone en 0
//   de inmediato, sin esperar al reloj -> reset ASINCRÓNICO,
//   activo en bajo. Mientras iRST = 0, el reloj queda bloqueado.
// - else oQ = iD: solo con iRST = 1, el flanco de subida del
//   reloj transfiere D a Q (parte sincrónica).
// - El reset permite fijar un estado inicial conocido; sin él
//   la salida empieza en x (desconocido).
//
// TABLA DE FUNCIONAMIENTO
// ------------------------------------------------------------
//   iRST | iCLK          | iD | oQ(t+1)
//   -----+---------------+----+--------------------------
//    0   | X             | X  | 0 (borrado inmediato)
//    1   | subida (^)    | 0  | 0
//    1   | subida (^)    | 1  | 1
//    1   | 0, 1 o bajada | X  | sin cambio
// ============================================================

module D_FF (oQ, iD, iCLK, iRST);
  output reg oQ;
  input  iD, iCLK, iRST;

  always @(posedge iCLK or negedge iRST)
    if (~iRST) oQ = 1'b0;   // Igual a: if (iRST == 0)
    else       oQ = iD;

endmodule