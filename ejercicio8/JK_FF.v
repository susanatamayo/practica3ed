// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 8: Flip-flop JK - descripción funcional a partir de
//              su tabla característica (primera alternativa: case)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - always @ (posedge iCLK): se ejecuta en el flanco de subida.
// - case ({iJ, iK}): {iJ, iK} concatena J y K en un número de
//   2 bits (J = bit izquierdo, K = bit derecho) y se compara con
//   cada caso; se ejecuta el primero que coincida.
// - assign oQnot = ~oQ: salida complementada Q'.
//
// DIFERENCIA CON EL EJERCICIO 7
// ------------------------------------------------------------
// - Ejercicio 7: estructural (ecuación característica + flip-flop
//   D instanciado).
// - Ejercicio 8: de comportamiento (tabla característica con case).
// - Este módulo NO tiene reset: oQ empieza en x (desconocido).
//   Desde x, mantener (00) y toggle (11) siguen dando x; solo
//   set (10) o reset (01) fijan un valor conocido.
//
// TABLA CARACTERÍSTICA
// ------------------------------------------------------------
//   iCLK       | iJ iK | oQ(t+1)
//   -----------+-------+-----------------
//   subida (^) | 0  0  | Q   (mantiene)
//   subida (^) | 0  1  | 0   (reset)
//   subida (^) | 1  0  | 1   (set)
//   subida (^) | 1  1  | Q'  (toggle)
// ============================================================

module JK_FF (iJ, iK, iCLK, oQ, oQnot);
  output oQ, oQnot;
  input  iJ, iK, iCLK;
  reg    oQ;

  assign oQnot = ~oQ;          // salida complementada

  always @ (posedge iCLK)
    case ({iJ, iK})
      2'b00: oQ = oQ;          // mantiene
      2'b01: oQ = 1'b0;        // reset
      2'b10: oQ = 1'b1;        // set
      2'b11: oQ = ~oQ;         // toggle
    endcase

endmodule