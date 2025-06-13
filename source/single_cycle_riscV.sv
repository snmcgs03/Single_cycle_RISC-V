module single_cycle_riscV #(parameter N=32)(input logic clk,reset, input logic [31:0]instruction,output logic [31:0]rs2_data,alu_out,
output logic [N-1:0]r_out,output logic [31:0]address,input logic [31:0] mem_out,output logic [2:0] fn3, output logic mem_read, mem_write);
(* KEEP = "TRUE" *)wire [N-1:0]rs1_data,imm_out,pc_signed_offset,return_addr;
(* KEEP = "TRUE" *)wire [6:0]opcode,imm11_5;
(* KEEP = "TRUE" *)wire [2:0]aluop;
//(* KEEP = "TRUE" *)wire [2:0]fn3;
(* KEEP = "TRUE" *)wire and_out_ex,branch,alu_src,fn7_5;
(* KEEP = "TRUE" *)wire [1:0]memtoreg;
(* KEEP = "TRUE" *)wire mux_inp;
(* DONT_TOUCH = "TRUE" *) if_stage if_st (.pc_new(return_addr),.clk(clk),.reset(reset),.and_out(and_out_ex),.pc_signed_offset(pc_signed_offset),.address(address),.opcode(opcode));
(* DONT_TOUCH = "TRUE" *) id_stage id_st (.mux_inp(mux_inp),.imm11_5(imm11_5),.opcode_out_d(opcode),.rs1_data(rs1_data),.rs2_data(rs2_data),.imm_out(imm_out),.instruction(instruction),.wb_data(r_out),
                                          .fn3_out_d(fn3),.fn7_5(fn7_5),.branch(branch),.mem_read(mem_read),.memtoreg(memtoreg),
                                          .aluop(aluop),.mem_write(mem_write),.alu_src(alu_src),.clk(clk),.reset(reset));
(* DONT_TOUCH = "TRUE" *) execution ex_st (.mux_inp(mux_inp),.aluop(aluop),.pc_ex_out(pc_signed_offset),.address(address),.alu_src(alu_src),.branch(branch),.alu_out(alu_out),.rs1_data(rs1_data),.imm_out(imm_out),.and_out_ex(and_out_ex),.rs2_data(rs2_data),.fn3(fn3),.fn7_5(fn7_5),.imm11_5(imm11_5));
(* DONT_TOUCH = "TRUE" *) wb_stage wb_st (.mem_out(mem_out),.alu_out(alu_out),.memtoreg(memtoreg),.wb_data(r_out),.return_addr(return_addr),.opcode_out_d(opcode),.imm_out(imm_out),.pc_signed_offset(pc_signed_offset));
endmodule

