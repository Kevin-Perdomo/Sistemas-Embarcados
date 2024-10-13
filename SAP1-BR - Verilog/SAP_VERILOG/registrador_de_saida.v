module registrador_de_saida (
    input clock,               // Sinal de clock
    input clear,               // Sinal de limpeza
    input OPR_IN,              // Sinal de entrada de operação
    input [7:0] bus_in,        // Dados de entrada
    output [7:0] OUT_BUS       // Saída de 8 bits
);

    // Instância do registrador tristate para os 4 bits mais significativos
    ci173_registrador_tristate_4bits ci173_1 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(OPR_IN),          // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[7:4]),             // Conecta os 4 bits mais significativos de bus_in
        .Q_OUT(OUT_BUS[7:4])         // Saída para OUT_BUS
    );

    // Instância do registrador tristate para os 4 bits menos significativos
    ci173_registrador_tristate_4bits ci173_2 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(OPR_IN),          // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[3:0]),             // Conecta os 4 bits menos significativos de bus_in
        .Q_OUT(OUT_BUS[3:0])         // Saída para OUT_BUS
    );

endmodule

/*
  Este módulo implementa um registrador de saída de 8 bits, dividido em duas partes de 4 bits.
  - A entrada `bus_in` é dividida em duas partes: os 4 bits mais significativos e os 4 bits menos significativos.
  - O sinal `OPR_IN` habilita a escrita no registrador.
  - A saída `OUT_BUS` fornece os dados armazenados no registrador para um módulo externo.
*/
