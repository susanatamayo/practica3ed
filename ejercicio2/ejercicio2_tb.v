// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 2: Generador de reloj de operación libre
//              (Alternativa 2: initial + always + $finish)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - initial: se ejecuta UNA sola vez desde t = 0.
//     clock = 1'b0  -> el reloj arranca en 0.
//     #300 $finish  -> a los 300 ns se termina la simulación.
// - always #10 clock = ~clock: se ejecuta una y otra vez sin
//   fin; cada 10 ns invierte el reloj (0 -> 1 o 1 -> 0).
// - initial y always empiezan al mismo tiempo (t = 0) y se
//   ejecutan de forma concurrente.
//
// RESULTADO
// ------------------------------------------------------------
// - Período = 20 ns (10 ns en bajo + 10 ns en alto) -> 50 MHz.
// - Ciclo de trabajo (duty cycle) = 50 %.
// - En 300 ns hay 15 ciclos completos.
// - La simulación termina en t = 300 ns por la tarea $finish.
//
// DIFERENCIA CON LA ALTERNATIVA 1 (ejercicio 1)
// ------------------------------------------------------------
// - Alternativa 1: el reloj hace 30 cambios con repeat y se
//   queda quieto, pero la simulación puede continuar.
// - Alternativa 2: el reloj oscila indefinidamente con always;
//   lo que se detiene es la simulación completa con $finish.
//   Para simular más tiempo solo se cambia el #300.
//
// NOTA
// ------------------------------------------------------------
// - initial, los retardos (#) y $finish NO son sintetizables:
//   este código solo sirve para simulación (testbench).
// ============================================================

`timescale 1ns/1ps   // unidad de tiempo = 1 ns, precisión = 1 ps

module ejercicio2_tb;

  reg clock;          // señal de reloj

  // Valor inicial y fin de la simulación
  initial
  begin
    clock = 1'b0;     // el reloj arranca en 0
    #300 $finish;     // termina la simulación en t = 300 ns
  end

  // Alternativa 2: reloj con always
  always
    #10 clock = ~clock;   // cada 10 ns se invierte

  // Muestra en consola cada cambio del reloj
  initial
    $monitor("t = %0t ns  clock = %b", $time, clock);

endmodule