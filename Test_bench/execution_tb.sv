`timescale 1ns/1ps
module execution_tb;

  logic [31:0] rs1_data;
  logic [31:0] rs2_data;
  logic [31:0] imm_out;
  logic [31:0] address;
  logic branch;
  logic alu_src;
  logic fn7_5;
  logic mux_inp;
  logic [2:0] fn3;
  logic [6:0]imm11_5;
  logic [2:0]aluop;
  logic and_out_ex;
  logic [31:0] alu_out;
  logic [31:0] pc_ex_out;
 
  
 
execution uut ( 
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .imm_out(imm_out),
    .address(address),
    .branch(branch),
    .alu_src(alu_src),
    .fn7_5(fn7_5),
    .mux_inp(mux_inp),
    .fn3(fn3),
    .imm11_5(imm11_5),
    .aluop(aluop),
    .and_out_ex(and_out_ex),
    .alu_out(alu_out),
    .pc_ex_out(pc_ex_out)
  );

  initial begin
    // R-type instructions
    // ADD
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    // SUB
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b1;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; //should be 01000000
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    // XOR
    rs1_data = 32'h00000001;
    rs2_data = 32'h00000003;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b100;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    // OR
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b110;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;
    
    //AND
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b111;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;
    
    // SLL
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b001;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    // SRL
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b101;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    //SRA
    rs1_data = 32'hF0000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b1;
    fn3 = 3'b101;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;
    
    //SLT
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b010;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;
    
    //SLTU
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000000; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b011;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;
    mux_inp=1'b0;
    #10;

    // I-type instructions
    // ADDI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    //XORI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000011; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b100;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    //ORI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000011; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b110;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    // ANDI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b111;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    // SLLI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000002; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b001;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    // SRLI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000002; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b101;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    // SRAI
    rs1_data = 32'h00000110;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000003; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b1;
    fn3 = 3'b101;
    imm11_5 = 7'b0100000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;
    
    //SLTI
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000010; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b010;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;
    
    //SLTIU
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000002;
    imm_out = 32'h00000010; // Not used
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b011;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b0;
    #10;

    //Load Instructions
    //LB
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b010;
    mux_inp=1'b0;
    #10;

    //LH
    rs1_data = 32'h01010101;
    rs2_data = 32'h01100110;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b001;
    imm11_5 = 7'b0000000; 
    aluop = 3'b010;
    mux_inp=1'b0;
    #10;
    
    //LW
    rs1_data = 32'h01010101;
    rs2_data = 32'h01100110;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b010;
    imm11_5 = 7'b0000000; 
    aluop = 3'b010;
    mux_inp=1'b0;
    #10;
    
    //LBU
    rs1_data = 32'h01010101;
    rs2_data = 32'h01100110;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b100;
    imm11_5 = 7'b0000000; 
    aluop = 3'b010;
    mux_inp=1'b0;
    #10;
    
    //LHU
    rs1_data = 32'h01010101;
    rs2_data = 32'h01100110;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b101;
    imm11_5 = 7'b0000000; 
    aluop = 3'b010;
    mux_inp=1'b0;
    #10;
    
    //Store Instructions
    //SB
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b011;
    mux_inp=1'b0;
    #10;
    
    //SH
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b001;
    imm11_5 = 7'b0000000; 
    aluop = 3'b011;
    mux_inp=1'b0;
    #10;
    
    //SW
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b010;
    imm11_5 = 7'b0000000; 
    aluop = 3'b011;
    mux_inp=1'b0;
    #10;
    
    //Branch Instructions
    // BEQ
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
    // BNE
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b001;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
    //BLT
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b100;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
    //BGE
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b101;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
    // BLTU
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b110;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
    // BGEU
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b1;
    alu_src = 1'b0;
    fn7_5 = 1'b0;
    fn3 = 3'b111;
    imm11_5 = 7'b0000000; 
    aluop = 3'b100;
    mux_inp=1'b0;
    #10;
    
//J Type instructions
    //Jal
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b101;
    mux_inp=1'b0;
    #10;
    
    //Jalr
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b001;
    mux_inp=1'b1;
    #10;
    
    //Utype Instructions
    //lui
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b110;
    mux_inp=1'b0;
    #10;
    
    //auipc
    rs1_data = 32'h00000010;
    rs2_data = 32'h00000020;
    imm_out = 32'h00000010; 
    address = 32'h00001000;
    branch = 1'b0;
    alu_src = 1'b1;
    fn7_5 = 1'b0;
    fn3 = 3'b000;
    imm11_5 = 7'b0000000; 
    aluop = 3'b000;  //should be 3'b001
    mux_inp=1'b0;
    #10;
    $stop;
  end

endmodule