module contador_de_programa
(
    input PC_INC,          // Sinal para incrementar o contador de programa.
    input clock,           // Sinal de clock para sincronizar as operações.
    input jump,            // Sinal para carregar um novo valor no contador (jump).
    input clear,           // Sinal para limpar (resetar) o contador.
    input PC_OUT,          // Sinal de controle para habilitar a saída do contador no barramento.
    input [3:0] bus_in,    // Barramento de entrada de 4 bits para carregar um novo valor no contador.
    output [3:0] bus_out    // Barramento de saída de 4 bits do contador.
);

wire [3:0] w_161_to_244;  // Conexão interna entre o contador e o buffer.

// Instância do contador síncrono ci161.
ci161_Contador_sincrono contador
(
    .clock(clock),                 // Sinal de clock.
    .enable(PC_INC),              // Habilita o incremento do contador.
    .load(jump),                  // Habilita a carga de um novo valor quando jump é ativado.
    .clear(clear),                // Sinal de reset.
    .DATA(bus_in),                // Entrada de dados para o contador.
    .Q(w_161_to_244)              // Saída do contador.
);

// Instância do buffer ci244 para controlar a saída do contador.
ci244_octaBuffer_tristate buffer
(
    .enable(PC_OUT),              // Habilita a saída no barramento.
    .A(w_161_to_244),             // Dados de saída do contador.
    .S(bus_out)                   // Saída no barramento de dados.
);

endmodule

/* 
  Este módulo representa um contador de programa de 4 bits que pode ser incrementado ou carregado com um novo valor.
  - O contador é sincronizado com o sinal de clock e pode ser incrementado quando o sinal `PC_INC` está ativo. 
  - O sinal `jump` permite carregar um novo valor do barramento `bus_in` no contador. 
  - O sinal `clear` reseta o contador para zero.
  - A saída do contador é controlada pelo sinal `PC_OUT` e é disponibilizada no barramento `bus_out` através de um buffer de três estados.
  O contador é projetado para uso em um sistema de controle, como um processador ou microcontrolador.
*/
