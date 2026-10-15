// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 6: Flip-flop T hecho con flip-flop D y compuertas
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - Ecuación característica del flip-flop T: Q(t+1) = Q xor T
//     T = 0 -> Q(t+1) = Q   (mantiene)
//     T = 1 -> Q(t+1) = Q'  (cambia / toggle)
// - assign DT = oQ ^ iT: una XOR calcula la ecuación y la
//   entrega como entrada D del flip-flop D.
// - D_FF D1 (...): instancia del flip-flop D (modelado
//   estructural: un módulo dentro de otro).
// - Reset asincrónico activo en bajo heredado del flip-flop D.
//
// CORRECCIÓN A LA GUÍA
// ------------------------------------------------------------
// - La guía escribe assign DT = Q ^ T; pero en el módulo T_FF
//   las señales se llaman oQ e iT. Se corrigió a oQ ^ iT para
//   que compile.
//
// TABLA DE FUNCIONAMIENTO
// ------------------------------------------------------------
//   iRST | iCLK       | iT | oQ(t+1)
//   -----+------------+----+-------------
//    0   | X          | X  | 0
//    1   | subida (^) | 0  | Q  (mantiene)
//    1   | subida (^) | 1  | Q' (cambia)
// ============================================================

// Flip-flop T hecho con flip-flop D y compuertas
module T_FF (oQ, iT, iCLK, iRST);
  output oQ;
  input  iT, iCLK, iRST;
  wire   DT;

  assign DT = oQ ^ iT;              // Q(t+1) = Q xor T
  D_FF D1 (oQ, DT, iCLK, iRST);     // Crea ejemplar del flip-flop D

endmodule

// Flip-flop D con reset asincrónico
module D_FF (Q, D, CLK, RST);
  output reg Q;
  input  D, CLK, RST;

  always @ (posedge CLK or negedge RST)
    if (~RST) Q = 1'b0;
    else      Q = D;

endmodule