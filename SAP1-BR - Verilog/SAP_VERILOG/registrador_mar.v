module registrador_mar (
    input clock,               // Sinal de clock
    input MAR_IN,              // Sinal para habilitar a entrada do registrador MAR
    input clear,               // Sinal de limpeza
    input programm_run,        // Sinal que indica se o programa está em execução
    input [3:0] mar_dip,       // Dados de entrada para o registrador MAR
    input [3:0] mar_b,         // Dados adicionais para o registrador MAR
    output [3:0] addr          // Endereço de saída
);

    wire [3:0] w_173_to_157;   // Sinal intermediário do registrador

    // Instância do registrador tristate para armazenar o valor do endereço
    ci173_registrador_tristate_4bits ci173_1 (
        .clock(clock),               // Conecta o sinal de clock
        .clear(clear),               // Conecta o sinal de limpeza
        .enable_in(MAR_IN),          // Habilita a entrada do registrador
        .enable_output(1),           // Habilita a saída do registrador
        .D(mar_b),                   // Dados de entrada do registrador
        .Q_OUT(w_173_to_157)         // Saída do registrador
    );

    // Instância do MUX que seleciona entre os dados de entrada e o valor armazenado no registrador
    ci157_MUX ci157_1 (
        .select(programm_run),      // Sinal de seleção para o MUX
        .A(w_173_to_157),           // Primeira entrada do MUX
        .B(mar_dip),                // Segunda entrada do MUX
        .S(addr)                    // Saída do MUX
    );

endmodule

/*
O registrador MAR (do inglês Memory Address Register) tem a função de armazenar o endereço de memória que a CPU precisa acessar, 
seja para ler ou escrever dados.

O módulo registrador_mar implementa um registrador de endereço de 4 bits (MAR).
- Ele recebe um sinal de clock e um sinal de limpeza para controlar seu funcionamento.
- O sinal `MAR_IN` habilita a escrita no registrador.
- A seleção entre os dados de entrada (mar_dip) e os dados armazenados no registrador (w_173_to_157) é feita pelo sinal `programm_run` através de um MUX.
- O resultado final é disponibilizado na saída `addr`.
*/
