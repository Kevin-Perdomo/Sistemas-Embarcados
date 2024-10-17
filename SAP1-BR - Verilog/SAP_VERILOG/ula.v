module ula
(
    input [7:0] A,           // Primeiro operando de 8 bits
    input [7:0] B,           // Segundo operando de 8 bits
    input ALU_OUT,           // Controle de saída da ULA
    input XOR_NOT,           // Controle para operação XOR ou NOT
    input ADD_SUB,           // Controle para operação de adição ou subtração
    input ALU0_AND,          // Controle para operação AND
    input ALU1_OR,           // Controle para operação OR
    output [7:0] S           // Saída da operação realizada
);

reg [7:0] result;            // Registrador para armazenar o resultado da operação

// Bloco combinacional que determina a operação a ser realizada com base nos sinais de controle
always @(*) begin
    // Seleção de operação com base nos sinais de controle
    case({XOR_NOT, ADD_SUB, ALU1_OR, ALU0_AND})
        4'b 0000: result <= A + B;        // Adição: A + B
        4'b 0100: result <= A - B;        // Subtração: A - B
        4'b 0011: result <= A ^ B;        // XOR: A XOR B
        4'b 1011: result <= ~A;           // NOT: Inverte A
        4'b 0001: result <= A & B;        // AND: A AND B
        4'b 0010: result <= A | B;        // OR: A OR B
        default: result <= 8'b00000000;   // Valor padrão (caso nenhum controle ative uma operação)
    endcase
end

// Atribui o resultado à saída S ou coloca em alta impedância se ALU_OUT não estiver ativo
assign S = ALU_OUT ? result : 8'bz;   // Operador Ternário

endmodule

/* 
A função da ULA (Unidade Lógica e Aritmética) é realizar operações lógicas e aritméticas sobre os dados processados pela CPU.

Este módulo representa uma Unidade Lógica Aritmética (ULA) que realiza operações aritméticas e lógicas 
em dois operandos de 8 bits (A e B). 

As operações disponíveis incluem: 
adição; 
subtração;
AND;
OR;
XOR;
NOT;

As operações são selecionadas através de sinais de controle. 
O resultado da operação é enviado para a saída S, que pode ser colocada em alta impedância dependendo do sinal de controle ALU_OUT.
*/
