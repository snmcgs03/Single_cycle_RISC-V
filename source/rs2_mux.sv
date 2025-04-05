module rs2_mux(input logic [31:0][31:0]reg_out,
               input logic [4:0]rs2_sel,
               output logic [31:0]rs2_data);
always@(*)
rs2_data = reg_out[rs2_sel];
endmodule
