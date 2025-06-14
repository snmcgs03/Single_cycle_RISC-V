`timescale 1ns/1ps

module single_cycle_riscV_tb;

  logic clk, reset;
  logic [31:0] instruction;
  logic [31:0] rs2_data, alu_out, r_out, address, mem_out;
  logic [2:0] fn3;
  logic mem_read, mem_write;

  single_cycle_riscV dut (
    .clk(clk), .reset(reset), .instruction(instruction),
    .rs2_data(rs2_data), .alu_out(alu_out), .r_out(r_out),
    .address(address), .mem_out(mem_out), .fn3(fn3),
    .mem_read(mem_read), .mem_write(mem_write)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    instruction = 32'h00000013; // NOP (addi x0, x0, 0)
    mem_out = 32'h0;
    #10;
    reset = 0;

    // ---------------- R-TYPE ----------------
    instruction = 32'b0000000_00010_00001_000_00011_0110011; #10; // add reset is given as 10 seconds so repeated
    instruction = 32'b0000000_00010_00001_000_00011_0110011; #10; // add
    instruction = 32'b0100000_00010_00001_000_00100_0110011; #10; // sub
    instruction = 32'b0000000_00010_00001_100_00101_0110011; #10; // xor
    instruction = 32'b0000000_00010_00001_110_00110_0110011; #10; // or
    instruction = 32'b0000000_00010_00001_111_00111_0110011; #10; // and
    instruction = 32'b0000000_00010_00001_001_01000_0110011; #10; // sll
    instruction = 32'b0000000_00010_00001_101_01001_0110011; #10; // srl
    instruction = 32'b0100000_00010_00001_101_01010_0110011; #10; // sra
    instruction = 32'b0000000_00010_00001_010_01011_0110011; #10; // slt
    instruction = 32'b0000000_00010_00001_011_01100_0110011; #10; // sltu

    // ---------------- I-TYPE ARITH ----------------
    instruction = 32'b000000000001_00001_000_01101_0010011; #10; // addi
    instruction = 32'b111111111111_00001_000_01110_0010011; #10; // addi -1
    instruction = 32'b000000000100_00001_100_01111_0010011; #10; // xori
    instruction = 32'b000000000100_00001_111_10000_0010011; #10; // andi
    instruction = 32'b000000000100_00001_110_10001_0010011; #10; // ori
    instruction = 32'b000000000101_00001_010_10010_0010011; #10; // slti
    instruction = 32'b000000000110_00001_011_10011_0010011; #10; // sltiu
    instruction = 32'b0000000_00001_00001_001_10100_0010011; #10; // slli
    instruction = 32'b0000000_00001_00001_101_10101_0010011; #10; // srli
    instruction = 32'b0100000_00001_00001_101_10110_0010011; #10; // srai

    // ---------------- I-TYPE LOADS ----------------
    mem_out = 32'hDEADBEEF;
    instruction = 32'b000000000100_00001_000_10111_0000011; #10; // lb
    instruction = 32'b000000000100_00001_001_11000_0000011; #10; // lh
    instruction = 32'b000000000100_00001_010_11001_0000011; #10; // lw
    instruction = 32'b000000000100_00001_100_11010_0000011; #10; // lbu
    instruction = 32'b000000000100_00001_101_11011_0000011; #10; // lhu

    // ---------------- I-TYPE JALR ----------------
    instruction = 32'b000000001000_00001_000_11100_1100111; #10; // jalr x28, x1, 8

    // ---------------- S-TYPE ----------------
    instruction = 32'b0000000_11100_00001_000_0001000_0100011; #10; // sb
    instruction = 32'b0000000_11101_00001_001_0001000_0100011; #10; // sh
    instruction = 32'b0000000_11110_00001_010_0001000_0100011; #10; // sw

    // ---------------- B-TYPE ----------------
    instruction = 32'b0000000_00001_00001_000_0000010_1100011; #10; // beq
    instruction = 32'b0000000_00010_00001_001_0000010_1100011; #10; // bne
    instruction = 32'b0000000_00001_00010_100_0000010_1100011; #10; // blt
    instruction = 32'b0000000_00010_00001_101_0000010_1100011; #10; // bge
    instruction = 32'b0000000_00001_00010_110_0000010_1100011; #10; // bltu
    instruction = 32'b0000000_00010_00001_111_0000010_1100011; #10; // bgeu

    // ---------------- U-TYPE ----------------
    instruction = 32'b00000000000000000001_11100_0110111; #10; // lui
    instruction = 32'b00000000000000000001_11101_0010111; #10; // auipc

    // ---------------- J-TYPE ----------------
    instruction = 32'b00000000000100000000000011101111; #10; // jal

    $display("RISC-V Single Cycle Core All Format Instruction Test Completed");
    $finish;
  end

endmodule