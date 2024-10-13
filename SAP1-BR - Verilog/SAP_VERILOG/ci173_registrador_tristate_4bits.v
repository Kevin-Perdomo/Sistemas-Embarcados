module ci173_registrador_tristate_4bits
(
    input enable_in,     // Sinal para habilitar a entrada de dados.
    input enable_output, // Sinal para habilitar a saída de dados.
    input clear,         // Sinal para limpar o registrador.
    input clock,         // Sinal de clock. O registrador é acionado na borda de subida do clock.
    input [3:0] D,       // Entrada de 4 bits para ser armazenada no registrador.
    output reg [3:0] FD, // Registrador de 4 bits que armazena o valor de entrada.
    output [3:0] Q_OUT,  // Saída direta do registrador.
    output [3:0] Q_ULA   // Saída adicional, que também reflete o valor armazenado.
);

// Bloco sempre acionado na borda de subida do clock ou quando o sinal clear é ativado.
always @ (posedge clock, posedge clear) begin

    // Se o sinal clear estiver ativo, o registrador FD é zerado.
	if(clear) 
		FD <= 4'b0;
	else begin
		// Se enable_in estiver ativo, o valor de D é armazenado no registrador FD.
		if(enable_in)
			FD <= D;
	end
		
end

// As saídas Q_OUT e Q_ULA refletem o valor armazenado no registrador FD.
assign Q_OUT = FD;
assign Q_ULA = FD;

endmodule

/* 
  Este é um registrador de 4 bits com habilitação de entrada, saída e função clear.
  - Se `clear` estiver ativo (1), o registrador (FD) é zerado.
  - Se `enable_in` estiver ativo (1), o valor de `D` (4 bits) é armazenado no registrador FD na borda de subida do clock.
  - As saídas `Q_OUT` e `Q_ULA` refletem diretamente o valor armazenado no registrador FD.
  Este registrador opera de forma síncrona com o clock.
*/
