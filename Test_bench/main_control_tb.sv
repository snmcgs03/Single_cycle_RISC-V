`timescale 1ns / 1ps
module main_control_tb;

  // Testbench signals
  logic [6:0] opcode;
  logic branch, memread, memwrite, alusrc, reg_write;
  logic [1:0] memtoreg;
  logic [2:0] aluop;

  // Instantiate the main_control module
  main_control uut (
    .opcode(opcode),
    .branch(branch),
    .memread(memread),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .alusrc(alusrc),
    .reg_write(reg_write),
    .aluop(aluop)
  );

  // Stimulus generation
  initial begin
    // Display headers
    $display("Time\tOpcode\tBranch\tMemRead\tMemWrite\tALUSrc\tRegWrite\tMemToReg\tALUOp");
    $monitor("%0t\t%b\t%b\t%b\t%b\t\t%b\t%b\t\t%b\t%3b", 
             $time, opcode, branch, memread, memwrite, alusrc, reg_write, memtoreg, aluop);
    
    // Initialize opcode
    opcode = 7'b0000000;

    // Test 1: R-type instruction
    #10 opcode = 7'b0110011;
    #10 opcode = 7'b0010011; // I-type
    #10 opcode = 7'b0000011; // Load
    #10 opcode = 7'b0100011; // Store
    #10 opcode = 7'b1100011; // Branch
    #10 opcode = 7'b1101111; // JAL
    #10 opcode = 7'b0110111; // U-type instruction (LUI)

    // Test for default case
    #10 opcode = 7'b1111111; // Unknown opcode (default case)

    // End simulation
    #10 $finish;
  end

endmodule

