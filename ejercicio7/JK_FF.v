// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 7: Flip-flop JK hecho con flip-flop D y compuertas
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - Ecuación característica del flip-flop JK:
//     Q(t+1) = J·Q' + K'·Q
// - assign JK = (iJ & ~oQ) | (~iK & oQ): implementa esa ecuación
//   con compuertas AND, OR y NOT, y su resultado se conecta como
//   entrada D del flip-flop D.
// - D_FF JK1 (...): instancia del flip-flop D (modelado
//   estructural, igual que el flip-flop T del ejercicio 6).
// - Reset asincrónico activo en bajo heredado del flip-flop D.
// - A diferencia del ejercicio 6, aquí la guía usa los nombres
//   correctos (oQ, iJ, iK), así que compila sin cambios.
//
// TABLA DE FUNCIONAMIENTO
// ------------------------------------------------------------
//   iRST | iCLK       | iJ iK | oQ(t+1)
//   -----+------------+-------+-----------------
//    0   | X          | X  X  | 0
//    1   | subida (^) | 0  0  | Q   (mantiene)
//    1   | subida (^) | 0  1  | 0   (reset)
//    1   | subida (^) | 1  0  | 1   (set)
//    1   | subida (^) | 1  1  | Q'  (toggle)
// ============================================================

// Flip-flop JK hecho con flip-flop D y compuertas
module JK_FF (oQ, iJ, iK, iCLK, iRST);
  output oQ;
  input  iJ, iK, iCLK, iRST;
  wire   JK;

  assign JK = (iJ & ~oQ) | (~iK & oQ);   // Q(t+1) = J·Q' + K'·Q
  D_FF JK1 (oQ, JK, iCLK, iRST);         // Crea ejemplar del flip-flop D

endmodule

// Flip-flop D con reset asincrónico
module D_FF (Q, D, CLK, RST);
  output reg Q;
  input  D, CLK, RST;

  always @ (posedge CLK or negedge RST)
    if (~RST) Q = 1'b0;
    else      Q = D;

endmodule