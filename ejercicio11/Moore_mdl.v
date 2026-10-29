// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 11: Diagrama de estados - modelo Moore (figura 4)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - parameter: asigna un código de 2 bits a cada estado
//   (S0 = 00, S1 = 01, S2 = 10, S3 = 11).
// - Un solo bloque always hace todo:
//     iRST = 0          -> state = S0 (reset asincrónico)
//     flanco de subida  -> el case calcula el siguiente estado
//                          según el estado actual y ix.
// - assign oAB = state: la salida es el estado mismo (salidas de
//   los flip-flops A y B) -> modelo MOORE: la salida depende
//   SOLO del estado y cambia solo en el flanco del reloj.
//
// DIFERENCIA CON EL EJERCICIO 10 (MEALY)
// ------------------------------------------------------------
// - Mealy: 3 bloques always; la salida depende del estado Y de
//   la entrada, y cambia apenas cambia ix.
// - Moore: 1 bloque always; la salida depende solo del estado y
//   cambia únicamente con el flanco del reloj.
//
// TABLA DE ESTADOS (coincide con la figura 4 de la guía)
// ------------------------------------------------------------
//   Estado   | ix = 0 | ix = 1 | oAB
//   ---------+--------+--------+-----
//   S0 (00)  |  S1    |  S0    | 00
//   S1 (01)  |  S3    |  S2    | 01
//   S2 (10)  |  S3    |  S2    | 10
//   S3 (11)  |  S0    |  S3    | 11
//
// NOTA
// ------------------------------------------------------------
// - En la guía el assign aparece con sangría como si estuviera
//   dentro del always, pero va después del endcase, a nivel de
//   módulo. Compila igual; aquí se acomodó para leerlo mejor.
// ============================================================

module Moore_mdl (ix, oAB, iCLK, iRST);
  input        ix, iCLK, iRST;
  output [1:0] oAB;
  reg    [1:0] state;
  parameter    S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

  always @ (posedge iCLK or negedge iRST)
    if (~iRST)
      state = S0;              // Iniciar en estado S0 (reset)
    else
      case (state)
        S0: if (~ix) state = S1; else state = S0;
        S1: if (ix)  state = S2; else state = S3;
        S2: if (~ix) state = S3; else state = S2;
        S3: if (~ix) state = S0; else state = S3;
      endcase

  assign oAB = state;          // Salida de flip-flops

endmodule