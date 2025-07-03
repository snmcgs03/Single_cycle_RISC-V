module load_addressing(
    input  logic [2:0] fn3,
    input  logic [31:0] memory_val,
    input  logic [6:0] opcode,
    output logic [31:0] mem_addr_out
);

always @(*) begin
    mem_addr_out = 32'b0; // default value
    if (opcode == 7'b0000011) begin // load instruction
        case (fn3)
            3'b000: mem_addr_out = {{24{memory_val[7]}},  memory_val[7:0]};   // LB
            3'b001: mem_addr_out = {{16{memory_val[15]}}, memory_val[15:0]};  // LH
            3'b010: mem_addr_out = memory_val;                                // LW
            3'b011: mem_addr_out = {{24{1'b0}}, memory_val[7:0]};             // LBU
            3'b100: mem_addr_out = {{16{1'b0}}, memory_val[15:0]};            // LHU
            default: mem_addr_out = 32'b0;
        endcase
    end
end

endmodule
