module flip_flop_D (
    input D,                // Entrada de dados
    input clock,            // Sinal de clock
    input clear,            // Sinal de reset (clear)
    output reg Q            // Saída do flip-flop
);

    // Sempre que houver uma transição de borda de subida no clock ou uma transição de borda de descida no clear
    always @ (posedge clock, negedge clear) begin
        
        // Se o sinal clear estiver ativo (0), zera a saída Q
        if(clear == 1'b0) 
            Q <= 1'b0;
        // Caso contrário, se houver uma borda de subida no clock, atualiza a saída Q com o valor de D
        else if(clock) 
            Q <= D;
    end

endmodule

/*
  Este módulo implementa um flip-flop tipo D.
  - A saída Q é atualizada com o valor da entrada D na borda de subida do clock.
  - Se o sinal de clear estiver ativo (0), a saída Q será zerada (0).
*/
