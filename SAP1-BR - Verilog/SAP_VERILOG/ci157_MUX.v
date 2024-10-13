module ci157_MUX
(
    input select,     // Sinal de controle para selecionar entre A e B.
    input [3:0] A,    // Vetor de 4 bits, uma das entradas.
    input [3:0] B,    // Vetor de 4 bits, a outra entrada.
    output [3:0] S    // Vetor de 4 bits da saída, correspondente à entrada selecionada.
);

// Atribuição condicional: se 'select' for 1, S recebe A; se 'select' for 0, S recebe B.
assign S = select ? A : B;

endmodule

/* 
  Este é um multiplexador de 4 bits. 
  Ele recebe dois vetores de entrada de 4 bits (A e B) e, dependendo do valor do sinal de controle `select`, 
  seleciona qual dos dois vetores será enviado para a saída `S`. 
  Se `select` for 0, o valor de `B` é passado para `S`. 
  Se `select` for 1, o valor de `A` é passado para `S`.
*/
