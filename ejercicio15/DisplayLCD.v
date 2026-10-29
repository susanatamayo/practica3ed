// ============================================================
// Práctica 3 - Circuitos secuenciales en Verilog HDL
// Ejercicio 15: Controlador de pantalla LCD 16x2 (HD44780)
//               con máquina de estados -> escribe "HOLA"
// ============================================================
//
// EXPLICACIÓN
// ------------------------------------------------------------
// - contador: divide el reloj de 50 MHz. Cuenta de 0 a 5000,
//   así que cada ciclo dura 5001 x 20 ns = 100 us.
// - clk_e: está en 1 los primeros 2500 conteos (50 us) y en 0
//   el resto -> es el reloj de la máquina de estados.
// - E (Enable): pulso con el que la LCD toma DATOS (en su
//   flanco de bajada). en_fsm permite apagarlo al terminar.
// - RS = 0 -> instrucción de control; RS = 1 -> carácter.
// - RW = 0 -> la LCD siempre está en modo escritura.
// - RST es activo en bajo (nrst = ~RST), sirve un pulsador.
// - INIlisto: se enciende (LED) cuando termina la configuración.
//
// SECUENCIA DE ESTADOS
// ------------------------------------------------------------
//   Estado                 RS  DATOS  Función
//   Espera_20ms            0   00H    espera encendido (~20 ms)
//   Enviar_SetFunction     0   38H    8 bits, 2 líneas, 5x8
//   Envia_EntryModeSet     0   06H    cursor avanza a la derecha
//   Enviar_DisplayControl  0   0EH    display y cursor encendidos
//   Envia_DisplayClear     0   01H    borra la pantalla
//   Espera_Clear (nuevo)   0   00H    espera ~2 ms al Clear
//   Envia_Direccion        0   80H    línea 1, posición 0
//   Envia_Caracter         1   20H    espacio
//   Caracter1..4           1   48H 4FH 4CH 41H -> H O L A
//   Termina_Aqui           0   00H    apaga E y se queda aquí
//
// CORRECCIONES A LA GUÍA
// ------------------------------------------------------------
// 1) cuentas no se reiniciaba en el reset: en simulación quedaba
//    en x y la espera inicial se saltaba. Se agregó cuentas <= 0.
// 2) La espera inicial era de 32 x 100 us = 3,2 ms (no 20 ms) y
//    con 5 bits no se puede contar más. La LCD necesita >= 15 ms.
//    Se cambió cuentas a 8 bits y el límite a 200 (~20 ms).
// 3) El Clear (01H) tarda 1,52 ms, pero la guía mandaba la
//    siguiente instrucción a los 100 us; la LCD ignora todo
//    mientras está ocupada y se perdían la dirección y "HOLA".
//    Se agregó el estado Espera_Clear (~2 ms).
// 4) DATOS = 8'b0010000 tenía 7 bits (= 10H, no imprimible).
//    Se corrigió a 8'b0010_0000 (20H = espacio).
// 5) Comentarios: la dirección es 80H (no 10H) y en el reset
//    'listo' se apaga (no se activa).
// 6) Se usan solo asignaciones no bloqueantes (<=) en el bloque
//    secuencial, en vez de mezclar = y <=.
// 7) Simplificaciones equivalentes:
//    clk_e = (contador >= 0 && contador < 2500) -> contador < 2500
//    E = en_fsm ? (clk_e & en_fsm) : en_fsm    -> clk_e & en_fsm
// ============================================================

module DisplayLCD (
  // Entradas
  input            CLK,
  input            RST,
  // Salidas
  output           E,
  output reg       RS,
  output           RW,
  output reg       INIlisto,
  output reg [7:0] DATOS
  );

  // Nombres de los estados y su codificación
  parameter Espera_20ms           = 4'b0000;
  parameter Enviar_SetFunction    = 4'b0001;
  parameter Envia_EntryModeSet    = 4'b0010;
  parameter Enviar_DisplayControl = 4'b0011;
  parameter Envia_DisplayClear    = 4'b0100;
  parameter Envia_Direccion       = 4'b0101;
  parameter Envia_Caracter        = 4'b0110;
  parameter Caracter1             = 4'b0111;
  parameter Caracter2             = 4'b1000;
  parameter Caracter3             = 4'b1001;
  parameter Caracter4             = 4'b1010;
  parameter Termina_Aqui          = 4'b1011;
  parameter Espera_Clear          = 4'b1100;   // NUEVO (corrección 3)

  reg  [3:0]  estado;
  reg  [13:0] contador;
  reg  [7:0]  cuentas;      // CORREGIDO: 5 -> 8 bits (corrección 2)
  reg         en_fsm;
  wire        clk_e;
  wire        nrst = ~RST;

  assign RW = 1'b0;                     // Modo del display: ESCRITURA

  // Señal de reloj para E (período de 100 us)
  always @ (posedge CLK or posedge nrst)
    if (nrst)
      contador <= 0;
    else if (contador == 5000)
      contador <= 0;
    else
      contador <= contador + 1;

  assign clk_e = (contador < 2500);     // 50 us en alto, 50 us en bajo
  assign E     = clk_e & en_fsm;        // E solo pulsa si en_fsm = 1

  // Máquina de estados (FSM)
  always @ (posedge clk_e or posedge nrst)
  begin
    if (nrst)                           // Si se da un RST
    begin
      INIlisto <= 1'b0;                 // se apaga 'listo' (LED)
      RS       <= 1'b0;                 // INSTRUCCIÓN DE CONTROL
      en_fsm   <= 1'b1;                 // se habilitan los pulsos de E
      DATOS    <= 8'h00;                // se limpia DATOS
      cuentas  <= 0;                    // CORREGIDO (corrección 1)
      estado   <= Espera_20ms;          // estado inicial
    end
    else                                // Si no, ejecutar la FSM
    begin
      case (estado)
        Espera_20ms:                    // ~20 ms de espera inicial
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'h00;
          if (cuentas < 200)            // CORREGIDO: 31 -> 200 (~20 ms)
          begin
            cuentas <= cuentas + 1;
            estado  <= Espera_20ms;
          end
          else
          begin
            cuentas <= 0;
            estado  <= Enviar_SetFunction;
          end
        end

        Enviar_SetFunction:
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;             // INSTRUCCIÓN DE CONTROL
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0011_1000;     // 38H: 8 bits, 2 líneas, 5x8
          estado   <= Envia_EntryModeSet;
        end

        Envia_EntryModeSet:
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0000_0110;     // 06H: cursor avanza a la derecha
          estado   <= Enviar_DisplayControl;
        end

        Enviar_DisplayControl:
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0000_1110;     // 0EH: display y cursor encendidos
          estado   <= Envia_DisplayClear;
        end

        Envia_DisplayClear:
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0000_0001;     // 01H: borrar pantalla
          estado   <= Espera_Clear;     // CORREGIDO (corrección 3)
        end

        Espera_Clear:                   // NUEVO: ~2 ms para el Clear
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'h00;
          if (cuentas < 20)
          begin
            cuentas <= cuentas + 1;
            estado  <= Espera_Clear;
          end
          else
          begin
            cuentas <= 0;
            estado  <= Envia_Direccion;
          end
        end

        Envia_Direccion:
        begin
          INIlisto <= 1'b0;
          RS       <= 1'b0;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b1000_0000;     // 80H (CORREGIDO el comentario)
          estado   <= Envia_Caracter;
        end

        Envia_Caracter:
        begin
          INIlisto <= 1'b1;             // se activa 'listo' (LED)
          RS       <= 1'b1;             // MOSTRAR DATOS
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0010_0000;     // 20H: espacio (CORREGIDO)
          estado   <= Caracter1;
        end

        Caracter1:
        begin
          INIlisto <= 1'b1;
          RS       <= 1'b1;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0100_1000;     // 48H: carácter H
          estado   <= Caracter2;
        end

        Caracter2:
        begin
          INIlisto <= 1'b1;
          RS       <= 1'b1;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0100_1111;     // 4FH: carácter O
          estado   <= Caracter3;
        end

        Caracter3:
        begin
          INIlisto <= 1'b1;
          RS       <= 1'b1;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0100_1100;     // 4CH: carácter L
          estado   <= Caracter4;
        end

        Caracter4:
        begin
          INIlisto <= 1'b1;
          RS       <= 1'b1;
          en_fsm   <= 1'b1;
          DATOS    <= 8'b0100_0001;     // 41H: carácter A
          estado   <= Termina_Aqui;
        end

        Termina_Aqui:
        begin
          INIlisto <= 1'b1;
          RS       <= 1'b0;
          en_fsm   <= 1'b0;             // se apaga E: fin de tarea
          DATOS    <= 8'h00;
          estado   <= Termina_Aqui;
        end

        default:
          estado <= Espera_20ms;
      endcase
    end
  end

endmodule