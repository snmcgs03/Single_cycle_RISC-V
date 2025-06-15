module if_adder#(parameter N=32)(address,pc_signed_offset,imm_out);
input logic [N-1:0]address,imm_out;
output logic [N-1:0]pc_signed_offset;
always_comb
pc_signed_offset = address + imm_out;
endmodule
