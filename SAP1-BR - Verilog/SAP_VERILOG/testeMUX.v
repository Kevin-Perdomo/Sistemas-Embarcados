`timescale 1ns/1ps

module testeMUX;

    // Declaração de sinais
    reg select, A, B;         // Entradas do MUX
    wire S;                   // Saída do MUX

    // Instância do módulo ci157_MUX
    ci157_MUX DUT (
        .select(select), 
        .A(A), 
        .B(B), 
        .S(S)
    );

    // Bloco inicial para a simulação
    initial begin
        // Inicializa as entradas
        select = 0; 
        A = 0; 
        B = 0;
        
        // Sequência de testes
        #20 A = 1;           // Após 20 ns, A se torna 1
        #20 B = 1;           // Após 20 ns, B se torna 1
        #20 A = 0;           // Após 20 ns, A se torna 0
        #20 B = 0;           // Após 20 ns, B se torna 0
        #20 select = 1;      // Após 20 ns, select se torna 1
        #20 A = 1;           // Após 20 ns, A se torna 1
        #20 B = 1;           // Após 20 ns, B se torna 1
        #20 A = 0;           // Após 20 ns, A se torna 0
        #20 B = 0;           // Após 20 ns, B se torna 0
    end
endmodule

// Este módulo de teste simula um MUX de 2 entradas (A e B) controlado pelo sinal 'select'.
// A saída 'S' deve ser igual a 'A' quando 'select' for 0 e igual a 'B' quando 'select' for 1.
// A sequência de testes altera os valores de 'A', 'B' e 'select' ao longo do tempo para verificar o funcionamento correto do MUX.
