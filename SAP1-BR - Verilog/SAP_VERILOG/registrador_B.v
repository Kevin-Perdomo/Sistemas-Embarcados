module registrador_B (
    input clock,              // Sinal de clock
    input clear,              // Sinal de limpeza
    input BR_IN,              // Sinal de habilitação do registrador
    input [7:0] bus_in,       // Dados de entrada
    output [7:0] TO_ULA       // Saída para a ULA
);

    // Instância do registrador tristate para os 4 bits mais significativos
    ci173_registrador_tristate_4bits ci173_1 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(BR_IN),           // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[7:4]),             // Conecta os 4 bits mais significativos de bus_in
        .Q_ULA(TO_ULA[7:4])          // Saída para a ULA
    );
    
    // Instância do registrador tristate para os 4 bits menos significativos
    ci173_registrador_tristate_4bits ci173_2 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(BR_IN),           // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(bus_in[3:0]),             // Conecta os 4 bits menos significativos de bus_in
        .Q_ULA(TO_ULA[3:0])          // Saída para a ULA
    );

endmodule

/*
Este módulo implementa um registrador de 8 bits dividido em dois registradores de 4 bits.
- A entrada `bus_in` é dividida em duas partes: os 4 bits mais significativos e os 4 bits menos significativos.
- O sinal `BR_IN` habilita a escrita nos registradores.
- A saída `TO_ULA` fornece os dados armazenados nos registradores para a Unidade Lógica Aritmética (ULA).
*/
