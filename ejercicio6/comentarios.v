  // ----------------------------------------------------------
  // CORRECCIÓN A LA GUÍA
  // Línea original:   assign DT = Q ^ T;
  // Error: Q y T no están declaradas en el módulo T_FF. Esos
  // nombres pertenecen al módulo D_FF, y en Verilog cada módulo
  // solo ve sus propias señales. ModelSim marca error de
  // identificador no declarado (undeclared identifier).
  // Corrección: se usan las señales propias de T_FF:
  //   Q -> oQ (salida del flip-flop)
  //   T -> iT (entrada T)
  // Así la XOR implementa Q(t+1) = Q xor T.
  // ----------------------------------------------------------
  assign DT = oQ ^ iT;              // Q(t+1) = Q xor T