module ci244_octaBuffer_tristate
(
    input [7:0] A,    // Entrada de 8 bits para o buffer.
    input enable,     // Sinal de habilitação para ativar ou colocar em estado de alta impedância.
    output [7:0] S    // Saída de 8 bits do buffer.
);

// Atribuição condicional: se 'enable' estiver ativo, a saída S recebe o valor de A.
// Caso contrário, S entra em estado de alta impedância ('Z').
assign S = enable ? A : 8'bzzzzzzzz;

endmodule

/* 
  Este é um buffer octal (8 bits) com controle de três estados (tristate). 
  - Quando o sinal `enable` está ativo (1), o valor de entrada `A` (8 bits) é passado para a saída `S`.
  - Quando `enable` está inativo (0), a saída `S` é colocada em estado de alta impedância ('Z').
  Esse comportamento é útil em barramentos compartilhados, permitindo que múltiplos dispositivos se conectem sem causar conflitos.
*/
