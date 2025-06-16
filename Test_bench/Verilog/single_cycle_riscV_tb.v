`timescale 1ns/1ps

module single_cycle_riscV_tb;

  reg clk, reset;
  reg [31:0] instruction;
  reg [31:0] mem_out;
  wire [31:0] rs2_data, alu_out, r_out, address;
  wire mem_read, mem_write;

  single_cycle_riscV dut (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .rs2_data(rs2_data),
    .alu_out(alu_out),
    .r_out(r_out),
    .address(address),
    .mem_out(mem_out),
    .mem_read(mem_read),
    .mem_write(mem_write)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    instruction = 32'h00000013; // NOP (addi x0, x0, 0)
    mem_out = 32'h0;
    
    repeat (2) @(posedge clk);
    reset = 0;

       // ---------------- R-TYPE ----------------
    @(posedge clk); instruction = 32'b0000000_00010_00001_000_00011_0110011; // add
    @(posedge clk); instruction = 32'b0100000_00010_00011_000_00100_0110011; // sub
    @(posedge clk); instruction = 32'b0000000_00010_00001_100_00101_0110011; // xor
    @(posedge clk); instruction = 32'b0000000_00010_00001_110_00110_0110011; // or
    @(posedge clk); instruction = 32'b0000000_00010_00001_111_00111_0110011; // and
    @(posedge clk); instruction = 32'b0000000_00010_00001_001_01000_0110011; // sll
    @(posedge clk); instruction = 32'b0000000_00010_01100_101_01001_0110011; // srl
    @(posedge clk); instruction = 32'b0100000_00010_10000_101_01010_0110011; // sra
    @(posedge clk); instruction = 32'b0000000_00010_00001_010_01011_0110011; // slt
    @(posedge clk); instruction = 32'b0000000_00010_00001_011_01100_0110011; // sltu 10

    // ---------------- I-TYPE ARITH ----------------
    @(posedge clk); instruction = 32'b000000000001_00001_000_01101_0010011; // addi
    @(posedge clk); instruction = 32'b111111111111_00001_000_01110_0010011; // addi -1
    @(posedge clk); instruction = 32'b000000000100_00001_100_01111_0010011; // xori
    @(posedge clk); instruction = 32'b000000000100_00001_111_10000_0010011; // andi
    @(posedge clk); instruction = 32'b000000000100_00001_110_10001_0010011; // ori
    @(posedge clk); instruction = 32'b000000000101_00001_010_10010_0010011; // slti
    @(posedge clk); instruction = 32'b000000000110_00001_011_10011_0010011; // sltiu
    
    @(posedge clk); instruction = 32'b0000000_00001_00001_001_10100_0010011; // slli
    @(posedge clk); instruction = 32'b0000000_00001_10110_101_10101_0010011; // srli
    @(posedge clk); instruction = 32'b0100000_00001_11111_101_10110_0010011; // srai 20

    // ---------------- I-TYPE LOADS ----------------
    mem_out = 32'hDEADBEEF;
    @(posedge clk); instruction = 32'b000000000100_00001_000_10111_0000011; // lb
    @(posedge clk); instruction = 32'b000000000100_00001_001_11000_0000011; // lh
    @(posedge clk); instruction = 32'b000000000100_00001_010_11001_0000011; // lw
    @(posedge clk); instruction = 32'b000000000100_00001_100_11010_0000011; // lbu
    @(posedge clk); instruction = 32'b000000000100_00001_101_11011_0000011; // lhu 25

    // ---------------- I-TYPE JALR ----------------
    @(posedge clk); instruction = 32'b000000001000_00001_000_11100_1100111; // jalr

    // ---------------- S-TYPE ----------------
    @(posedge clk); instruction = 32'b0000000_11100_00001_000_00010_0100011; // sb
    @(posedge clk); instruction = 32'b0000000_11101_00001_001_00010_0100011; // sh
    @(posedge clk); instruction = 32'b0000000_11110_00001_010_00010_0100011; // sw 29

    // ---------------- B-TYPE ----------------
    @(posedge clk); instruction = 32'b0000000_00000_00001_000_00010_1100011; // beq 30
    @(posedge clk); instruction = 32'b0000000_00010_00001_001_00010_1100011; // bne
    @(posedge clk); instruction = 32'b0000000_00010_00001_100_00010_1100011; // blt
    @(posedge clk); instruction = 32'b0000000_00001_00010_101_00010_1100011; // bge
    @(posedge clk); instruction = 32'b0000000_00001_00010_110_00010_1100011; // bltu
    @(posedge clk); instruction = 32'b0000000_00010_00001_111_00010_1100011; // bgeu 34
    
    // ---------------- J-TYPE ----------------
    @(posedge clk); instruction = 32'b00000000000000000001_00001_1101111; // jal x1,8 

    // ---------------- U-TYPE ----------------
    @(posedge clk); instruction = 32'b00000000000000000001_11110_0110111; // lui x30, 0x1
    @(posedge clk); instruction = 32'b00000000000000000001_11101_0010111; // auipc x29, 0x1
    @(posedge clk);
    
    $display("RISC-V Single Cycle Core All Format Instruction Test Completed");
    $finish;
  end

endmodule
