module acumulador
(
    input clock,          // Sinal de clock para sincronizar o funcionamento do acumulador.
    input clear,          // Sinal para limpar (resetar) os registradores internos.
    input ACC_OUT,        // Sinal de controle para habilitar a saída do acumulador no barramento.
    input ACC_IN,         // Sinal de controle para habilitar a entrada de dados no acumulador.
    input [7:0] bus_in,   // Barramento de entrada de dados de 8 bits.
    output [7:0] bus_out, // Barramento de saída de dados de 8 bits.
    output [7:0] TO_ULA   // Saída de 8 bits para a ULA (Unidade Lógica e Aritmética).
);

wire [7:0] w_173_to_244;  // Conexão interna entre os registradores e o buffer.

// Instância do primeiro registrador ci173 (para os 4 bits mais significativos).
ci173_registrador_tristate_4bits ci173_1
(
    .clock(clock),                 // Sinal de clock.
    .enable_in(ACC_IN),            // Habilita a entrada de dados.
    .enable_output(1),             // Saída sempre habilitada.
    .clear(clear),                 // Sinal de reset.
    .D(bus_in[7:4]),               // Entrada de dados (4 bits mais significativos).
    .Q_OUT(w_173_to_244[7:4]),     // Saída conectada ao buffer.
    .Q_ULA(TO_ULA[7:4])            // Saída conectada à ULA.
);

// Instância do segundo registrador ci173 (para os 4 bits menos significativos).
ci173_registrador_tristate_4bits ci173_2
(
    .clock(clock),                 // Sinal de clock.
    .enable_in(ACC_IN),            // Habilita a entrada de dados.
    .enable_output(1),             // Saída sempre habilitada.
    .clear(clear),                 // Sinal de reset.
    .D(bus_in[3:0]),               // Entrada de dados (4 bits menos significativos).
    .Q_OUT(w_173_to_244[3:0]),     // Saída conectada ao buffer.
    .Q_ULA(TO_ULA[3:0])            // Saída conectada à ULA.
);

// Instância do buffer ci244 (buffer octal de 8 bits).
ci244_octaBuffer_tristate buffer
(
    .enable(ACC_OUT),              // Habilita a saída no barramento.
    .A(w_173_to_244),              // Entrada dos 8 bits vindos dos registradores.
    .S(bus_out)                    // Saída no barramento de dados.
);

endmodule

/* 
A principal função do acumulador (também conhecido como Accumulator) é armazenar temporariamente o 
resultado de operações lógicas e aritméticas.

Este é um módulo acumulador de 8 bits que armazena e fornece dados ao barramento e à ULA (Unidade Lógica e Aritmética).
- O módulo contém dois registradores `ci173` (cada um de 4 bits) que formam os 8 bits do acumulador. 
- O sinal `ACC_IN` habilita a entrada de dados do barramento `bus_in` para os registradores.
- Um buffer `ci244` octal de três estados controla a saída dos dados armazenados para o barramento `bus_out`, habilitado pelo sinal `ACC_OUT`.
- Os dados também são enviados para a ULA através das saídas `TO_ULA`.
- O acumulador opera de forma síncrona com o sinal de clock, com a capacidade de ser resetado através do sinal `clear`.
*/
