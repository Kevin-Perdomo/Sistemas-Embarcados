module memoria_ram (
    input WR_BUTTON,         // Botão de escrita
    input clock,             // Sinal de clock
    input RAM_IN,            // Sinal para entrada de dados na RAM
    input RAM_OUT,           // Sinal para saída de dados da RAM
    input programm_run,      // Sinal para indicar se o programa está em execução
    input [3:0] in_mar,      // Endereço de memória para escrita/leitura
    input [7:0] ram_dip,     // Dados de entrada para escrita na RAM
    input [7:0] bus_in,      // Dados de entrada do barramento
    output [7:0] bus_out     // Dados de saída do barramento
);
	 
	 // Memória RAM de 16 endereços de 8 bits
    reg [7:0] memoria [0:15]; 
	 
    wire WE; // Sinal de habilitação para escrita

    // Habilita a escrita se RAM_IN ou WR_BUTTON estiverem ativos
    assign WE = RAM_IN || WR_BUTTON;

    // Sempre que há uma borda de subida no sinal WE
    always @(posedge WE) begin
        // Se o programa não estiver em execução, escreve ram_dip na memória
        if(~programm_run)
            memoria[in_mar] <= ram_dip;
        // Se o programa estiver em execução, escreve bus_in na memória
        if(programm_run)
            memoria[in_mar] <= bus_in;
    end       

    // A saída bus_out é igual ao valor na memória, caso RAM_OUT esteja ativo
    assign bus_out = RAM_OUT ? memoria[in_mar] : 8'bz;  // Operador Ternário

endmodule

/*
A principal função da memória RAM (Random Access Memory) é armazenar temporariamente os dados e as instruções que a CPU 
precisa acessar rapidamente durante a execução de programas e processos em um computador.

Este módulo implementa uma memória RAM de 16 endereços de 8 bits.
- A memória é inicializada com valores padrão.
- O módulo permite a escrita na memória quando o botão WR_BUTTON ou o sinal RAM_IN estão ativos.
- A saída bus_out fornece o valor armazenado no endereço in_mar quando RAM_OUT está ativo.
*/
