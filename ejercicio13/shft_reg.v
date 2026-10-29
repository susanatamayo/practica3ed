// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 13: Registro de desplazamiento universal de 4 bits
//               (descripción de comportamiento, figuras 7 y 8)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - iClr = 0 -> oA = 0000 de inmediato (borrado asincrónico,
//   activo en bajo). iClr debe estar en 1 para que el registro
//   responda al flanco de subida del reloj.
// - Con iClr = 1, en cada flanco de subida case ({is1, is0})
//   elige la operación:
//     00 -> sin cambio
//     01 -> desplazamiento a la derecha: {irtin, oA[3:1]}
//           irtin entra por A3; A3, A2, A1 bajan una posición
//           y A0 se pierde.
//     10 -> desplazamiento a la izquierda: {oA[2:0], ilfin}
//           A2, A1, A0 suben una posición, ilfin entra por A0
//           y A3 se pierde.
//     11 -> carga paralela: oA = iPin
// - En total son 5 operaciones: las 4 del case + el Clear.
// - Solo describe la FUNCIÓN del registro, no los multiplexores
//   y flip-flops de la figura 7 (eso es el ejercicio 14).
//
// TABLA DE FUNCIÓN (figura 8)
// ------------------------------------------------------------
//   iClr | is1 is0 | Operación
//   -----+---------+-------------------------------
//    0   |  X   X  | Borrado (0000)
//    1   |  0   0  | Sin cambio
//    1   |  0   1  | Desplazamiento a la derecha
//    1   |  1   0  | Desplazamiento a la izquierda
//    1   |  1   1  | Carga en paralelo
//
// NOTA A LA GUÍA
// ------------------------------------------------------------
// - El texto dice "entradas en serie (lfin, tfin)"; tfin es un
//   error de escritura, se refiere a rtin.
// ============================================================

module shft_reg (is1, is0, iPin, ilfin, irtin, oA, iCLK, iClr);
  input            is1, is0;      // Seleccionar entradas
  input            ilfin, irtin;  // Entradas en serie
  input            iCLK, iClr;    // Reloj y Clear
  input      [3:0] iPin;          // Entrada paralela
  output reg [3:0] oA;            // Salida del registro

  always @ (posedge iCLK or negedge iClr)
    if (~iClr) oA = 4'b0000;
    else
      case ({is1, is0})
        2'b00: oA = oA;                  // Sin cambio
        2'b01: oA = {irtin, oA[3:1]};    // Desplazamiento a la derecha
        2'b10: oA = {oA[2:0], ilfin};    // Desplazamiento a la izquierda
        2'b11: oA = iPin;                // Carga paralela
      endcase

endmodule