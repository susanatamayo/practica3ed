`timescale 1ns/1ps

module ejercicio1_tb;

  reg clock;

  // Alternativa 1: reloj con repeat
  initial
  begin
    clock = 1'b0;
    repeat (30)
      #10 clock = ~clock;
  end

  // Muestra en consola cada cambio del reloj
  initial
    $monitor("t = %0t ns  clock = %b", $time, clock);

endmodule
// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 1: Generador de reloj de operación libre
//              (Alternativa 1: initial + repeat)
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - initial: el bloque se ejecuta UNA sola vez, empezando en t = 0.
// - clock = 1'b0: el reloj arranca en 0.
// - repeat (30): repite 30 veces la instrucción siguiente.
// - #10 clock = ~clock: espera 10 ns y luego invierte el reloj
//   (0 -> 1 o 1 -> 0).
//
// RESULTADO
// ------------------------------------------------------------
// - Cada 10 ns el reloj cambia, así que el período es 20 ns
//   (10 ns en bajo + 10 ns en alto), es decir 50 MHz, la misma
//   frecuencia del oscilador de la tarjeta DE0-CV.
// - Son 30 cambios = 15 ciclos completos.
// - Como 30 es par, el reloj termina en 0 en t = 300 ns y deja
//   de oscilar, aunque la simulación continúe.
// - Desventaja de esta alternativa: el reloj tiene duración
//   limitada; si se necesita más tiempo hay que cambiar el
//   número del repeat.
//
// NOTA
// ------------------------------------------------------------
// - initial y los retardos (#10) NO son sintetizables: este
//   código solo sirve para simulación (testbench), no se puede
//   cargar en la DE0-CV.
// - Simulado en ModelSim con: vlib work, vlog ejercicio1_tb.v,
//   vsim -novopt work.ejercicio1_tb, add wave clock, run 400ns.
// ============================================================

`timescale 1ns/1ps   // unidad de tiempo = 1 ns, precisión = 1 ps

module ejercicio1_tb;

  reg clock;          // señal de reloj (reg porque se asigna en initial)

  // Alternativa 1: reloj con repeat
  initial
  begin
    clock = 1'b0;           // valor inicial del reloj
    repeat (30)             // 30 cambios = 15 ciclos
      #10 clock = ~clock;   // cada 10 ns se invierte
  end

  // Muestra en consola cada cambio del reloj
  initial
    $monitor("t = %0t ns  clock = %b", $time, clock);

endmodule