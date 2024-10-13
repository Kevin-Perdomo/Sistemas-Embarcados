module registrador_de_instrucoes (
    input clock,               // Sinal de clock
    input clear,               // Sinal de limpeza
    input IR_IN,               // Sinal de entrada de instrução
    input IR_OUT,              // Sinal de saída de instrução
    input [7:0] bus_in,        // Dados de entrada
    output [3:0] bus_out,      // Saída de 4 bits
    output [3:0] reg_i_out     // Saída do registrador de instruções
);

    wire [3:0] w_173_to_244;   // Sinal intermediário para a saída do registrador

    // Instância do registrador tristate para os 4 bits mais significativos
    ci173_registrador_tristate_4bits ci173_1 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(IR_IN),           // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[7:4]),             // Conecta os 4 bits mais significativos de bus_in
        .Q_OUT(reg_i_out[3:0])       // Saída para reg_i_out
    );

    // Instância do registrador tristate para os 4 bits menos significativos
    ci173_registrador_tristate_4bits ci173_2 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(IR_IN),           // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[3:0]),             // Conecta os 4 bits menos significativos de bus_in
        .Q_OUT(w_173_to_244[3:0])    // Saída intermediária
    );

    // Instância do Buffer triestado para controlar a saída de dados
    ci244_octaBuffer_tristate buffer (
        .enable(IR_OUT),             // Habilita a saída do buffer
        .A(w_173_to_244),            // Conecta a saída do registrador
        .S(bus_out)                  // Saída para bus_out
    );

endmodule

/*
  Este módulo implementa um registrador de instruções de 8 bits, dividido em duas partes de 4 bits.
  - A entrada `bus_in` é dividida em duas partes: os 4 bits mais significativos e os 4 bits menos significativos.
  - O sinal `IR_IN` habilita a escrita no registrador, enquanto o sinal `IR_OUT` controla a saída.
  - As saídas são `bus_out`, que fornece a instrução para um módulo externo, e `reg_i_out`, que fornece os 4 bits mais significativos do registrador de instruções.
*/
