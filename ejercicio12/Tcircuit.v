// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 12: Descripción estructural de un circuito
//               secuencial con flip-flops T (figura 5)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - Tcircuit: describe la parte combinacional con assign y crea
//   dos instancias del flip-flop T (AF y BF) -> descripción
//   ESTRUCTURAL (componentes conectados entre sí).
//     TB = x       -> B cambia en cada flanco si x = 1
//     TA = x & B   -> A cambia solo si x = 1 y B = 1
//     y  = A & B   -> y = 1 cuando la cuenta está en 11
// - T_FF: flip-flop T de comportamiento, Q(t+1) = Q xor T, con
//   reset asincrónico activo en bajo.
// - Resultado: contador binario de 2 bits controlado por x:
//     x = 1 -> AB cuenta 00 -> 01 -> 10 -> 11 -> 00
//     x = 0 -> la cuenta no cambia
//
// TABLA DE ESTADOS
// ------------------------------------------------------------
//   AB actual | x = 0 | x = 1 | y
//   ----------+-------+-------+---
//      00     |  00   |  01   | 0
//      01     |  01   |  10   | 0
//      10     |  10   |  11   | 0
//      11     |  11   |  00   | 1
//
// OBSERVACIONES A LA GUÍA
// ------------------------------------------------------------
// - La figura 5 dice "modelo Mealy", pero y = A & B depende
//   solo del estado (no de x), así que el circuito es MOORE.
// - En el texto aparece "Q(t+1) = Q Â T"; es un error de
//   codificación del símbolo, debe ser Q(t+1) = Q xor T.
// ============================================================

`timescale 1ns/1ps

// Descripción estructural del circuito secuencial
module Tcircuit (x, y, A, B, CLK, RST);
  input  x, CLK, RST;
  output y, A, B;

  wire TA, TB;

  assign TB = x,               // Ecuaciones de entrada de flip-flop
         TA = x & B;
  assign y  = A & B;           // Ecuación de salida

  T_FF BF (B, TB, CLK, RST);   // Se crean ejemplares de flip-flops T
  T_FF AF (A, TA, CLK, RST);

endmodule

// Flip-flop T
module T_FF (Q, T, CLK, RST);
  output reg Q;
  input  T, CLK, RST;

  always @ (posedge CLK or negedge RST)
    if (~RST) Q = 1'b0;        // reset asincrónico
    else      Q = Q ^ T;       // Q(t+1) = Q xor T

endmodule