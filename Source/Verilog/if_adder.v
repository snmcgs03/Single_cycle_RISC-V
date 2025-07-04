module if_adder // Parameter for data width
(
    input wire [31:0] address,       // Input: Address
    input wire [31:0] imm_out,       // Input: Immediate value
    output reg [31:0] pc_signed_offset // Output: PC signed offset
);
    // Combinational logic for addition
    always @(*) begin
        pc_signed_offset = address + imm_out;
    end

endmodule
