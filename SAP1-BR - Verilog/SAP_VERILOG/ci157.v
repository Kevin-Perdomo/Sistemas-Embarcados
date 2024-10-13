module ci157
(
    input Enable,     	 	// Sinal de habilitação geral (ativo baixo).
    input Select,      		// Sinal de seleção entre bits da esquerda e direita.
    input [1:0] A,    	 	// Vetor de 2 bits, onde A[0] é o bit da esquerda e A[1] o da direita.
    input [1:0] B,     		// Vetor de 2 bits, onde B[0] é o bit da esquerda e B[1] o da direita.
    input [1:0] C,     		// Vetor de 2 bits, onde C[0] é o bit da esquerda e C[1] o da direita.
    input [1:0] D,    		// Vetor de 2 bits, onde D[0] é o bit da esquerda e D[1] o da direita.
    output Za, Zb, Zc, Zd  // Saídas resultantes para os respectivos vetores de entrada (A, B, C, D).
);


// Fios internos para definir as condições de seleção à esquerda e direita.
wire S_left, S_right; 
	
// Se 'Select' for 0 e 'Enable' for 0, 'S_left' é ativado (seleciona o bit da esquerda).
assign S_left = ~Select & ~Enable;
	
// Se 'Select' for 1 e 'Enable' for 0, 'S_right' é ativado (seleciona o bit da direita).
assign S_right = Select & ~Enable;
	
// Saída Za é selecionada entre o bit esquerdo (A[0]) e o direito (A[1]), dependendo do valor de Select.
assign Za = ((S_left & A[0]) | (S_right & A[1]));

// Saída Zb é selecionada entre o bit esquerdo (B[0]) e o direito (B[1]), dependendo do valor de Select.
assign Zb = ((S_left & B[0]) | (S_right & B[1]));

// Saída Zc é selecionada entre o bit esquerdo (C[0]) e o direito (C[1]), dependendo do valor de Select.
assign Zc = ((S_left & C[0]) | (S_right & C[1]));

// Saída Zd é selecionada entre o bit esquerdo (D[0]) e o direito (D[1]), dependendo do valor de Select.
assign Zd = ((S_left & D[0]) | (S_right & D[1]));

endmodule


/*
Este módulo é um multiplexador que, com base no valor do sinal de controle Select, escolhe um bit entre dois (esquerda ou direita) 
de cada um dos vetores de entrada e o passa para as saídas correspondentes, desde que Enable esteja ativo (Enable = 0).
*/