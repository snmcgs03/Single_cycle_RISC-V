module rs1_mux(input logic [31:0][31:0]reg_out,
               input logic [4:0]rs1_sel,
               output logic [31:0]rs1_data);
always@(*)
rs1_data = reg_out[rs1_sel];
endmodule
 