module if_adder #(parameter N = 32) // Parameter for data width
(
    input wire [N-1:0] address,       // Input: Address
    input wire [N-1:0] imm_out,       // Input: Immediate value
    output reg [N-1:0] pc_signed_offset // Output: PC signed offset
);
    // Combinational logic for addition
    always @(*) begin
        pc_signed_offset = address + imm_out;
    end

endmodule
