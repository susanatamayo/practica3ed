// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 10: Diagrama de estados - modelo Mealy (figura 3)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - parameter: asigna un código binario de 2 bits a cada estado
//   (S0 = 00, S1 = 01, S2 = 10, S3 = 11). Se usa 2'b10 y no 2
//   para que la constante ocupe 2 bits y no 32.
// - Prstate = estado actual, Nxtstate = siguiente estado.
// - Tres bloques always concurrentes:
//   1) Secuencial: en cada flanco de subida Prstate = Nxtstate;
//      con iRST = 0 vuelve a S0 de inmediato (reset asincrónico).
//   2) Combinacional: calcula el siguiente estado según el estado
//      actual y la entrada ix.
//   3) Combinacional: calcula la salida oy según el estado actual
//      Y la entrada ix -> modelo MEALY: oy puede cambiar apenas
//      cambia ix, sin esperar al reloj.
//
// TABLA DE ESTADOS
// ------------------------------------------------------------
//   Estado   | ix = 0          | ix = 1
//   actual   | sig. / oy       | sig. / oy
//   ---------+-----------------+----------------
//   S0 (00)  | S0  /  0        | S1  /  0
//   S1 (01)  | S0  /  1        | S3  /  0
//   S2 (10)  | S0  /  1        | S2  /  0
//   S3 (11)  | S0  /  1        | S2  /  0
//
//   Ecuaciones (figura 3): A(t+1) = A·x + B·x
//                          B(t+1) = A'·x
//                          y      = (A + B)·x'
//
// CORRECCIONES A LA GUÍA
// ------------------------------------------------------------
// 1) Línea original: module Mealy_mdl (ix, iy, iCLK, iRST);
//    Error: la lista de puertos dice iy, pero la salida se
//    declara como oy. iy no está declarada y oy no está en la
//    lista de puertos, por lo que ModelSim no compila.
//    Corrección: module Mealy_mdl (ix, oy, iCLK, iRST);
// 2) La figura 4 de la guía no corresponde a este código (por
//    ejemplo, en la figura 00 con entrada 0 va a 01, pero el
//    código deja S0 en S0) y no muestra las salidas en las
//    flechas. El diagrama correcto es la tabla de arriba.
// ============================================================

module Mealy_mdl (ix, oy, iCLK, iRST);   // CORREGIDO: iy -> oy
  input      ix, iCLK, iRST;
  output reg oy;
  reg [1:0]  Prstate, Nxtstate;
  parameter  S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

  // Restablece el circuito al estado inicial S0 = 00 y especifica
  // la operación sincrónica con el reloj
  always @ (posedge iCLK or negedge iRST)
    if (~iRST) Prstate = S0;          // Iniciar en estado S0 (reset)
    else       Prstate = Nxtstate;    // Operaciones de reloj (actualizar estado)

  // Determinar el siguiente estado
  always @ (Prstate or ix)
    case (Prstate)
      S0: if (ix)  Nxtstate = S1; else Nxtstate = S0;
      S1: if (ix)  Nxtstate = S3; else Nxtstate = S0;
      S2: if (~ix) Nxtstate = S0; else Nxtstate = S2;
      S3: if (ix)  Nxtstate = S2; else Nxtstate = S0;
    endcase

  // Evaluar la salida
  always @ (Prstate or ix)
    case (Prstate)
      S0: oy = 0;
      S1: if (ix) oy = 1'b0; else oy = 1'b1;
      S2: if (ix) oy = 1'b0; else oy = 1'b1;
      S3: if (ix) oy = 1'b0; else oy = 1'b1;
    endcase

endmodule