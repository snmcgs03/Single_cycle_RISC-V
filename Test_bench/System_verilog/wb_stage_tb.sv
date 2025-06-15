`timescale 1ns / 1ps

module wb_stage_tb;

  // Inputs
  logic [31:0] mem_out;
  logic [31:0] alu_out;
  logic [31:0] return_addr;
  logic [31:0] imm_out;
  logic [31:0] pc_signed_offset;
  logic [1:0]  memtoreg;
  logic [6:0]  opcode_out_d;

  // Output
  logic [31:0] wb_data;

  // Instantiate the DUT
  wb_stage #(32) dut (
    .mem_out(mem_out),
    .alu_out(alu_out),
    .return_addr(return_addr),
    .imm_out(imm_out),
    .pc_signed_offset(pc_signed_offset),
    .memtoreg(memtoreg),
    .wb_data(wb_data),
    .opcode_out_d(opcode_out_d)
  );

  // Test stimulus
  initial begin
    $display("=== WB Stage Test Start ===");

    // Case 1: memtoreg = 2'b00 -> wb_data = mem_out
    mem_out           = 32'hAAAA_AAAA;
    alu_out           = 32'hBBBB_BBBB;
    return_addr       = 32'h1111_1111;
    imm_out           = 32'h2222_2222;
    pc_signed_offset  = 32'h3333_3333;
    memtoreg          = 2'b00;
    opcode_out_d      = 7'b0000000;
    #10;
    $display("Case 1: memtoreg = 00 => wb_data = mem_out = %h", wb_data);

    // Case 2: memtoreg = 2'b01 -> wb_data = alu_out
    memtoreg          = 2'b01;
    #10;
    $display("Case 2: memtoreg = 01 => wb_data = alu_out = %h", wb_data);

    // Case 3: memtoreg = 2'b10, opcode = AUIPC -> wb_data = return_addr
    memtoreg          = 2'b10;
    opcode_out_d      = 7'b0010111; // AUIPC
    #10;
    $display("Case 3: memtoreg = 10, AUIPC => wb_data = return_addr = %h", wb_data);

    // Case 4: memtoreg = 2'b10, opcode = LUI -> wb_data = imm_out
    opcode_out_d      = 7'b0110111; // LUI
    #10;
    $display("Case 4: memtoreg = 10, LUI => wb_data = imm_out = %h", wb_data);

    // Case 5: memtoreg = 2'b10, opcode = JAL -> wb_data = pc_signed_offset
    opcode_out_d      = 7'b1101111; // JAL
    #10;
    $display("Case 5: memtoreg = 10, JAL => wb_data = pc_signed_offset = %h", wb_data);

    // Case 6: All zeros
    mem_out           = 32'h0000_0000;
    alu_out           = 32'h0000_0000;
    return_addr       = 32'h0000_0000;
    imm_out           = 32'h0000_0000;
    pc_signed_offset  = 32'h0000_0000;
    memtoreg          = 2'b00;
    opcode_out_d      = 7'b0000000;
    #10;
    $display("Case 6: All zero input => wb_data = %h", wb_data);

    // Case 7: All ones, test all memtoreg values
    mem_out           = 32'hFFFF_FFFF;
    alu_out           = 32'hEEEE_EEEE;
    return_addr       = 32'hDDDD_DDDD;
    imm_out           = 32'hCCCC_CCCC;
    pc_signed_offset  = 32'hBBBB_BBBB;

    memtoreg          = 2'b00;
    opcode_out_d      = 7'b0000000;
    #10;
    $display("Case 7.1: memtoreg = 00 => wb_data = %h", wb_data);

    memtoreg          = 2'b01;
    #10;
    $display("Case 7.2: memtoreg = 01 => wb_data = %h", wb_data);

    memtoreg          = 2'b10;
    opcode_out_d      = 7'b0010111;
    #10;
    $display("Case 7.3: memtoreg = 10, AUIPC => wb_data = %h", wb_data);

    opcode_out_d      = 7'b0110111;
    #10;
    $display("Case 7.4: memtoreg = 10, LUI => wb_data = %h", wb_data);

    opcode_out_d      = 7'b1101111;
    #10;
    $display("Case 7.5: memtoreg = 10, JAL => wb_data = %h", wb_data);

    $display("=== WB Stage Test Completed ===");
    $finish;
  end

endmodule
