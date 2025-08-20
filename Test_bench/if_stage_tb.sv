`timescale 1ns/1ps

module if_stage_tb;
  parameter N = 32;

  logic clk, reset, and_out;
  logic [6:0] opcode;
  logic [N-1:0] pc_signed_offset;
  logic [N-1:0] address, pc_new;

  // Instantiate the DUT
  if_stage #(N) dut (
    .clk(clk),
    .reset(reset),
    .and_out(and_out),
    .opcode(opcode),
    .pc_signed_offset(pc_signed_offset),
    .address(address),
    .pc_new(pc_new)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $display("Time\tReset\tOpcode\t\tAND\tPC Offset\tAddress\t\tPC New");

    // Test 1: Reset behavior
    reset = 1;
    and_out = 0;
    opcode = 7'b0000000;
    pc_signed_offset = 0;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    reset = 0;

    // Test 2: Load instruction (non-branch)
    opcode = 7'b0000011;
    and_out = 0;
    pc_signed_offset = 8;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    // Test 3: JAL instruction (jump, always taken)
    opcode = 7'b1101111;
    and_out = 0;
    pc_signed_offset = 100;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);
    
    opcode = 7'b1100111;
    and_out = 0;
    pc_signed_offset = 120;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);
    
    

    // Test 4: Branch taken (opcode = 1100011, and_out = 1)
    opcode = 7'b1100011;
    and_out = 1;
    pc_signed_offset = 16;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    // Test 5: Branch not taken (opcode = 1100011, and_out = 0)
    opcode = 7'b1100011;
    and_out = 0;
    pc_signed_offset = 16;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    // Test 6: Negative offset (simulate backward branch)
    opcode = 7'b1100011;
    and_out = 1;
    pc_signed_offset = -8;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    // Test 7: Invalid opcode (should default to PC+4)
    opcode = 7'b1111111;
    and_out = 0;
    pc_signed_offset = 200;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    // Test 8: Glitchy reset
    reset = 1; #5;
    reset = 0; #5;
    reset = 1; #5;
    reset = 0; #5;
    opcode = 7'b0000011;
    and_out = 0;
    pc_signed_offset = 4;
    #10;
    $display("%0t\t%b\t%07b\t%b\t%0d\t\t%0d\t%0d", $time, reset, opcode, and_out, pc_signed_offset, address, pc_new);

    $finish;
  end

endmodule
