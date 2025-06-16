`timescale 1ns/1ps

module id_stage_tb;

    // Inputs (driven by the testbench)
    reg [31:0] instruction, wb_data;
    reg clk, reset, mux_inp;

    // Outputs (driven by the DUT)
    wire [31:0] rs1_data, rs2_data, imm_out;
    wire [6:0] opcode_out_d, imm11_5;
    wire [2:0] fn3_out_d, aluop;
    wire [1:0] memtoreg;
    wire fn7_5, branch, mem_read, mem_write, alu_src;

    // Instantiate the DUT
    id_stage uut (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_out(imm_out),
        .wb_data(wb_data),
        .opcode_out_d(opcode_out_d),
        .fn3_out_d(fn3_out_d),
        .fn7_5(fn7_5),
        .imm11_5(imm11_5),
        .branch(branch),
        .mem_read(mem_read),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .mux_inp(mux_inp)
    );
  always #5 clk = ~clk;

  initial begin
    $display("------ Starting ID_STAGE Testbench ------");
    clk = 0;
    reset = 1;
    instruction = 32'd0;
    wb_data = 32'd0;
    #10;
    reset = 0;

    // ------------ R-type Instructions (ADD/SUB for x0-x7) ------------
    instruction = 32'b0000000_00001_00010_000_00011_0110011; wb_data = 32'h11110000; #10; // ADD x3,x1,x2
    instruction = 32'b0100000_00001_00010_000_00100_0110011; wb_data = 32'h22220000; #10; // SUB x4,x1,x2
    instruction = 32'b0000000_00100_00101_000_00110_0110011; wb_data = 32'h33330000; #10; // ADD x6,x4,x5
    instruction = 32'b0100000_00110_00111_000_01000_0110011; wb_data = 32'h44440000; #10; // SUB x8,x6,x7

    // ------------ I-type Instructions (ADDI, ANDI, LW, JALR) ------------
    instruction = 32'b000000000101_00010_000_01001_0010011; wb_data = 32'hAAAA0001; #10; // ADDI x9,x2,5
    instruction = 32'b111111111111_00011_111_01010_0010011; wb_data = 32'hFFFF0002; #10; // ANDI x10,x3,-1
    instruction = 32'b000000000100_00100_010_01011_0000011; wb_data = 32'hABCD1234; #10; // LW x11,x4,4
    instruction = 32'b000000000010_00101_000_01100_1100111; wb_data = 32'hCAFEBABE; #10; // JALR x12,x5,2

    // ------------ S-type Instructions (SW) ------------
    instruction = 32'b0000000_01010_00110_010_00100_0100011; wb_data = 32'hC0FFEE00; #10; // SW x10,4(x6)

    // ------------ B-type Instructions (BEQ, BNE) ------------
    instruction = 32'b0000000_00110_00111_000_00100_1100011; wb_data = 32'hBEEFBEEF; #10; // BEQ x6,x7,8
    instruction = 32'b0000000_01000_01001_001_00010_1100011; wb_data = 32'hFACEB00C; #10; // BNE x8,x9,4

    // ------------ U-type Instructions (LUI, AUIPC) ------------
    instruction = {20'hABCDE, 5'd13, 7'b0110111}; wb_data = 32'hABCDE000; #10; // LUI x13, 0xABCDE
    instruction = {20'h12345, 5'd14, 7'b0010111}; wb_data = 32'h12345000; #10; // AUIPC x14, 0x12345

    // ------------ J-type Instruction (JAL) ------------
    instruction = 32'b00000000000100000000000011101111; wb_data = 32'h1234ABCD; #10; // JAL x0, offset

    // ------------ Corner Cases ------------
    instruction = 32'h00000000; wb_data = 32'h00000000; #10; // All 0s
    instruction = 32'hFFFFFFFF; wb_data = 32'hFFFFFFFF; #10; // All 1s
    instruction = 32'b0100000_00000_00000_000_00000_0110011; wb_data = 32'hBADDCAFE; #10; // Only fn7 set
    instruction = 32'b0000000000000000000000000110011; wb_data = 32'hCAFED00D; #10; // Only opcode set
    instruction = 32'hFFF00000; wb_data = 32'hDEADBEEF; #10; // Only upper bits immediate

    // ------------ Reset Check ------------
    reset = 1; #10;
    reset = 0; #10;

    $display("------ Completed ID_STAGE Testbench ------");
    $finish;
  end

endmodule
