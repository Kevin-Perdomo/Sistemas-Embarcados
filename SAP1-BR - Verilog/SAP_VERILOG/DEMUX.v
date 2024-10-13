module DEMUX (
    input select,          // Sinal de seleção
    output [3:0] A,        // Saída A
    output [3:0] B,        // Saída B
    input [3:0] Z          // Entrada de dados
);

    // A saída A recebe os dados Z quando o sinal select é alto
    assign A = select ? Z : 4'b0000;

    // A saída B recebe os dados Z quando o sinal select é baixo
    assign B = ~select ? Z : 4'b0000;

endmodule

/*
  Este módulo implementa um demultiplexador (DEMUX) de 1 para 2.
  - Ele direciona a entrada Z para uma das saídas A ou B, dependendo do sinal de seleção.
  - Se o sinal de seleção (`select`) estiver ativo (1), a entrada Z será direcionada para a saída A.
  - Se o sinal de seleção estiver inativo (0), a entrada Z será direcionada para a saída B.
*/
