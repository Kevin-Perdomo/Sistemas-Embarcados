module controller (
    input clock,              // Sinal de clock
    input reset,              // Sinal de reset
    input [3:0] instrucao,    // Instrução de 4 bits
    output reg PC_OUT,        // Sinal para saída do contador de programa
    output reg PC_INC,        // Sinal para incremento do contador de programa
    output reg JMP,           // Sinal de salto
    output reg ACC_IN,        // Sinal para entrada do acumulador
    output reg ACC_OUT,       // Sinal para saída do acumulador
    output reg MAR_IN,        // Sinal para entrada do endereço da memória
    output reg RAM_OUT,       // Sinal para saída da RAM
    output reg RAM_IN,        // Sinal para entrada da RAM
    output reg ALU_OUT,       // Sinal para saída da ALU
    output reg ADD_SUB,       // Sinal para operação de adição/subtração na ALU
    output reg XOR_NOT,       // Sinal para operação XOR ou NOT na ALU
    output reg ALU0,          // Sinal de controle da ALU (bit 0)
    output reg ALU1,          // Sinal de controle da ALU (bit 1)
    output reg BR_IN,         // Sinal para entrada de um endereço de ramificação
    output reg OPR_IN,        // Sinal para entrada de operação
    output reg IR_IN,         // Sinal para entrada do registrador de instrução
    output reg IR_OUT,        // Sinal para saída do registrador de instrução
    output reg HLT            // Sinal para parar a execução
);

reg [2:0] contador;            // Contador de 3 bits para controlar o estado do controlador

always @ (negedge clock) begin 

    // Reseta todos os sinais de saída
    PC_OUT <= 0;
    PC_INC <= 0;
    JMP <= 0;
    ACC_IN <= 0;
    ACC_OUT <= 0;
    MAR_IN <= 0;
    RAM_OUT <= 0;
    RAM_IN <= 0;
    ALU_OUT <= 0;
    ADD_SUB <= 0;
    XOR_NOT <= 0;
    ALU0 <= 0;
    ALU1 <= 0;
    BR_IN <= 0;
    OPR_IN <= 0;
    IR_IN <= 0;
    IR_OUT <= 0;
    HLT <= 0;

    if (reset)
        contador <= 3'b000;  // Reseta o contador se o sinal de reset estiver ativo
    else begin
    
        // Controla a lógica do controlador com base no contador e na instrução
        if (contador == 3'b000) begin
            PC_OUT <= 1;      // Ativa a saída do contador de programa
            MAR_IN <= 1;      // Habilita a entrada do endereço da memória
        end
        
        if (contador == 3'b001) begin
            RAM_OUT <= 1;     // Ativa a saída da RAM
            IR_IN <= 1;       // Habilita a entrada do registrador de instrução
            PC_INC <= 1;      // Incrementa o contador de programa
        end
        
        if (contador == 3'b010) begin
            case (instrucao)
                4'b0001, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000: begin 
                    IR_OUT <= 1;   // Ativa a saída do registrador de instrução
                    MAR_IN <= 1;   // Habilita a entrada do endereço da memória
                end

                4'b0010: begin 
                    IR_OUT <= 1; 
                    ACC_IN <= 1;   // Carrega o valor no acumulador
                end 
             
                4'b1001: begin 
                    ALU_OUT <= 1; 
                    ACC_IN <= 1; 
                    ALU1 <= 1; 
                    ALU0 <= 1; 
                    XOR_NOT <= 1;  // Habilita a operação na ALU
                end 

                4'b1010: begin 
                    IR_OUT <= 1; 
                    JMP <= 1;       // Ativa o sinal de salto
                end
                
                4'b1110: begin 
                    ACC_OUT <= 1; 
                    OPR_IN <= 1;    // Habilita a entrada de operação
                end
                
                4'b1111: 
                    HLT <= 1;       // Ativa o sinal de parada
            endcase
        end
        
        if (contador == 3'b011) begin
            case (instrucao)
                4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000: begin 
                    RAM_OUT <= 1; 
                    BR_IN <= 1;     // Habilita a entrada de ramificação
                end

                4'b0001: begin 
                    RAM_OUT <= 1; 
                    ACC_IN <= 1;    // Carrega o valor na RAM
                end 
                
                4'b0011: begin 
                    ACC_OUT <= 1; 
                    RAM_IN <= 1;     // Saída do acumulador para a RAM
                end
            endcase
        end
        
        if (contador == 3'b100) begin
            case (instrucao)
                4'b0100: begin 
                    ALU_OUT <= 1; 
                    ACC_IN <= 1;    // Habilita a operação e carrega o acumulador
                end

                4'b0101: begin 
                    ALU_OUT <= 1; 
                    ACC_IN <= 1; 
                    ADD_SUB <= 1;   // Ativa operação de adição/subtração
                end 
                
                4'b0110: begin 
                    ALU_OUT <= 1; 
                    RAM_IN <= 1; 
                    ALU0 <= 1;      // Habilita a operação na ALU
                end
                
                4'b0111: begin 
                    ALU_OUT <= 1; 
                    RAM_IN <= 1; 
                    ALU1 <= 1;      // Habilita a operação na ALU
                end
                
                4'b1000: begin 
                    ALU_OUT <= 1; 
                    RAM_IN <= 1; 
                    ALU0 <= 1; 
                    ALU1 <= 1;      // Habilita a operação na ALU
                end
            endcase
        end
        
        if (contador < 3'b100)
            contador <= contador + 3'b001; // Incrementa o contador
        else
            contador <= 3'b000; // Reseta o contador quando atinge 4
    end
end

endmodule

/* 
  Este módulo implementa um controlador de um processador simples que gerencia o fluxo de execução das instruções.
  - Ele usa um contador de 3 bits para controlar a sequência de operações, ativando os sinais de controle apropriados 
  com base na instrução de 4 bits recebida.
  - O controlador é responsável por gerenciar operações como leitura e escrita na memória, operações ALU, 
  e manipulação do contador de programa. 
  - O sinal de reset reinicia o estado do controlador e do contador.
*/
