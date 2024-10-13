module ci161_Contador_sincrono
(
    input enable,        // Sinal para habilitar o incremento do contador.
    input clear,         // Sinal para zerar o contador.
    input load,          // Sinal para carregar o valor de entrada em DATA no contador.
    input clock,         // Sinal de clock. O contador é acionado na borda de subida do clock.
    input [3:0] DATA,    // Entrada de 4 bits para carregar um valor específico no contador.
    output reg [3:0] Q   // Saída de 4 bits que mantém o valor do contador.
);

// Bloco sempre acionado na borda de subida do clock ou quando o sinal clear é ativado.
always @ (posedge clock, posedge clear) begin
	
    // Se o clear estiver ativo, o contador é zerado.
	if(clear)
		Q <= 4'b0000;
	else begin
		// Se o enable estiver ativo, o contador é incrementado em 1.
		if(enable)
			Q <= Q + 4'b0001;
		
		// Se o load estiver ativo, o valor de DATA é carregado em Q.
		if(load)
			Q <= DATA;	
	end
		
end			

endmodule

/* 
  Este é um contador síncrono de 4 bits. Ele pode realizar as seguintes operações:
  - Quando o sinal `clear` está ativo (1), o contador é zerado (Q = 4'b0000).
  - Quando o sinal `enable` está ativo (1), o contador incrementa seu valor em 1 a cada ciclo de clock.
  - Quando o sinal `load` está ativo (1), o valor de `DATA` (4 bits) é carregado diretamente no contador.
  O contador opera na borda de subida do sinal de clock.
*/
