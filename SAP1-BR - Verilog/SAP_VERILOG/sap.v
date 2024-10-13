module sap(
    input clock,                // Sinal de clock para sincronização
    input clear,                // Sinal de reset para limpar os registradores
    input WR,                   // Sinal para escrever na memória RAM
    input prog_run,             // Sinal para indicar que o programa está em execução
    input [7:0] ram_dip,       // Dados de entrada para a RAM
    input [3:0] mar_dip,        // Entrada do endereço de memória (MAR)
    output [7:0] SAP_OUT        // Saída do sistema
);

wire w_PC_OUT, w_PC_INC, w_JMP, w_ACC_IN, w_ACC_OUT, w_MAR_IN, w_RAM_OUT, w_RAM_IN;
wire w_ALU_OUT, w_ADD_SUB, w_XOR_NOT, w_ALU0, w_ALU1, w_BR_IN, w_OPR_IN, w_IR_IN, w_IR_OUT, w_HLT;

wire [3:0] W_mar_to_ram;             // Saída do MAR para a RAM

wire [7:0] W_acumulador_to_ula;      // Saída do acumulador para a ULA

wire [3:0] W_reginst_to_controller;  // Saída do registrador de instruções para o controlador

wire [7:0] W_regB_to_ula;            // Saída do registrador B para a ULA

wire [7:0] bus;                      // Barramento que conecta os componentes

wire f_clock = w_HLT ? 0 : clock;   // Clock controlado pelo sinal HLT

// Instância do controlador que gerencia as operações do SAP
controller controller (
    .clock(f_clock),
    .reset(clear),
    .instrucao(W_reginst_to_controller), 
    .PC_OUT(w_PC_OUT),
    .PC_INC(w_PC_INC),
    .JMP(w_JMP),
    .ACC_IN(w_ACC_IN),
    .ACC_OUT(w_ACC_OUT),
    .MAR_IN(w_MAR_IN),
    .RAM_OUT(w_RAM_OUT),
    .RAM_IN(w_RAM_IN),
    .ALU_OUT(w_ALU_OUT),
    .ADD_SUB(w_ADD_SUB),
    .XOR_NOT(w_XOR_NOT),
    .ALU0(w_ALU0),
    .ALU1(w_ALU1),
    .BR_IN(w_BR_IN),
    .OPR_IN(w_OPR_IN),
    .IR_IN(w_IR_IN),
    .IR_OUT(w_IR_OUT),
    .HLT(w_HLT)
);

// Instância do contador de programa (PC)
contador_de_programa contador_de_programa (
    .clock(f_clock),
    .clear(clear),
    .PC_INC(w_PC_INC),
    .jump(w_JMP),
    .PC_OUT(w_PC_OUT),
    .bus_in(bus),
    .bus_out(bus)
);

// Instância do registrador de endereço de memória (MAR)
registrador_mar registrador_mar (
    .clock(f_clock),
    .clear(clear),
    .MAR_IN(w_MAR_IN),
    .programm_run(prog_run),
    .mar_dip(mar_dip),
    .mar_b(bus),
    .addr(W_mar_to_ram)
);

// Instância do registrador de instruções (IR)
registrador_de_instrucoes registrador_de_instrucoes (
    .clock(f_clock),
    .clear(clear),
    .IR_IN(w_IR_IN),
    .IR_OUT(w_IR_OUT),
    .bus_in(bus),
    .bus_out(bus),
    .reg_i_out(W_reginst_to_controller)
);

// Instância do registrador de saída
registrador_de_saida registrador_de_saida (
    .clock(f_clock),
    .clear(clear),
    .OPR_IN(w_OPR_IN),
    .bus_in(bus),
    .OUT_BUS(SAP_OUT)
);	

// Instância do registrador B
registrador_B registrador_B (
    .clock(f_clock),
    .clear(clear),
    .BR_IN(w_BR_IN),
    .bus_in(bus),
    .TO_ULA(W_regB_to_ula)
);

// Instância do acumulador
acumulador acumulador (
    .clock(f_clock),
    .clear(clear),
    .ACC_OUT(w_ACC_OUT),
    .ACC_IN(w_ACC_IN),
    .bus_in(bus),
    .bus_out(bus),
    .TO_ULA(W_acumulador_to_ula)
);
	
// Instância da Unidade Lógica Aritmética (ULA)
ula ula (
    .A(W_acumulador_to_ula),
    .B(W_regB_to_ula),
    .ALU_OUT(w_ALU_OUT),
    .XOR_NOT(w_XOR_NOT),
    .ADD_SUB(w_ADD_SUB),
    .ALU0_AND(w_ALU0),
    .ALU1_OR(w_ALU1),
    .S(bus)	
);	

// Instância da memória RAM
memoria_ram memoria_ram (
    .clock(f_clock),
    .RAM_IN(w_RAM_IN),
    .RAM_OUT(w_RAM_OUT),
    .programm_run(prog_run),
    .WR_BUTTON(WR),
    .in_mar(W_mar_to_ram),
    .ram_dip(ram_dip),
    .bus_in(bus),
    .bus_out(bus)
);

endmodule 

/* 
Este módulo implementa um Sistema Aritmético e Lógico (SAP) que combina diversos componentes 
para realizar operações aritméticas e lógicas. O sistema inclui um contador de programa, 
registradores de memória e instruções, um acumulador, uma ULA e uma memória RAM. Os sinais de controle 
gerenciam as operações, permitindo que o sistema leia, escreva e execute instruções com base em um clock 
e um sinal de reset. A saída final do sistema é fornecida na porta SAP_OUT.
*/
