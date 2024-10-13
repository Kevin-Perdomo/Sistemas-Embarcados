module Contador_sincrono_32bits
(
    input enable,              // Sinal para habilitar o incremento do contador.
    input clear,               // Sinal para limpar (resetar) o contador.
    input load,                // Sinal para carregar um novo valor no contador.
    input clock,               // Sinal de clock para sincronizar as operações.
    input [3:0] DATA,          // Entrada de dados para carregar um novo valor no contador.
    output reg [3:0] Q,        // Saída do contador.
    input [9:0] LED            // Conexão para LEDs (não utilizada neste módulo).
);

always @ (posedge clock, negedge clear) begin
    
    // Verifica se o sinal de clear está ativo.
    if(clear)
        Q <= 32'b0;            // Reseta o contador para zero.
    else begin
        if(enable)
            Q <= Q + 32'b1;    // Incrementa o contador em 1 se habilitado.
        if(load)
            Q <= DATA;         // Carrega um novo valor no contador se load estiver ativo.
    end
        
end            

endmodule

/* 
  Este módulo representa um contador síncrono de 32 bits que pode ser incrementado ou carregado com um novo valor.
  - O contador é sincronizado com o sinal de clock e pode ser incrementado quando o sinal `enable` está ativo. 
  - O sinal `load` permite carregar um novo valor do barramento `DATA` no contador. 
  - O sinal `clear` reseta o contador para zero.
  - O contador é projetado para uso em sistemas digitais que requerem contagem síncrona.
*/
