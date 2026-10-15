// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 9: Flip-flop JK - descripción funcional a partir de
//              su tabla característica (segunda alternativa:
//              if - else if)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - always @(posedge iCLK): se ejecuta en el flanco de subida.
// - Cada if / else if evalúa una combinación de J y K y asigna
//   el siguiente estado al registro interno rQ.
// - rQ es reg (registro interno). Las salidas se generan con
//   assign: oQ = rQ y oQnot = ~rQ, por eso oQ no es reg.
//
// DIFERENCIA CON EL EJERCICIO 8
// ------------------------------------------------------------
// - Ejercicio 8: case ({iJ, iK}) -> más compacto.
// - Ejercicio 9: if - else if con == y && -> mismo resultado.
// - Ninguno tiene reset: la salida empieza en x hasta que se
//   aplica un set (10) o un reset (01).
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
  reg    rQ;                   // registro interno

  assign oQnot = ~rQ;          // salida complementada
  assign oQ    = rQ;           // salida Q

  always @(posedge iCLK)
  begin
    if ((iJ == 0) && (iK == 0))
    begin
      rQ = rQ;                 // mantiene
    end
    else if ((iJ == 1) && (iK == 0))
    begin
      rQ = 1'b1;               // set
    end
    else if ((iJ == 0) && (iK == 1))
    begin
      rQ = 1'b0;               // reset
    end
    else if ((iJ == 1) && (iK == 1))
    begin
      rQ = ~rQ;                // toggle
    end
  end

endmodule