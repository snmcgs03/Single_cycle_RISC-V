module if_adder(address,pc_signed_offset,imm_out);
input logic [31:0]address,imm_out;
output logic [31:0]pc_signed_offset;
always_comb
pc_signed_offset = address + imm_out;
endmodule
