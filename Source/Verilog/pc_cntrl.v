module pc_cntrl (
    input wire [6:0] opcode,    // Opcode input
    input wire and_out,         // AND gate output
    output reg pc_gen_out       // PC generation control signal
);

    always @(*) begin
        pc_gen_out = 0; // Default value
        if ((opcode == 7'b1100011 && and_out == 1) || 
            (opcode == 7'b1101111) || 
            (opcode == 7'b1100111)) begin
            pc_gen_out = 1;
        end
    end

endmodule

