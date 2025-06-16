`timescale 1ns/1ps

module mux_31_tb;

  parameter N = 32;

  // Testbench signals
  reg [N-1:0] a, b, c;
  reg [1:0] cntrl;
  wire [N-1:0] out;

  // Instantiate the DUT (Design Under Test)
  mux31 #(N) dut (
    .a(a),
    .b(b),
    .c(c),
    .out(out),
    .cntrl(cntrl)
  );

  initial begin
    // Initialize inputs with unique values
    a = 32'hAAAAAAAA; // 101010...
    b = 32'h55555555; // 010101...
    c = 32'hFFFFFFFF; // All 1s

    $display("Starting mux31 testbench...");
    $display("----------------------------------------------------");
    $display("| cntrl |   Expected Out     |       Actual Out     |");
    $display("----------------------------------------------------");

    // Test all 4 cases of control
    cntrl = 2'b00; #1;
    $display("|  %b   |  0x%8h       |    0x%8h     |", cntrl, a, out);
    assert(out == a);

    cntrl = 2'b01; #1;
    $display("|  %b   |  0x%8h       |    0x%8h     |", cntrl, b, out);
    assert(out == b);

    cntrl = 2'b10; #1;
    $display("|  %b   |  0x%8h       |    0x%8h     |", cntrl, c, out);
    assert(out == c);

    cntrl = 2'b11; #1;
    $display("|  %b   |  0x%8h       |    0x%8h     |", cntrl, 32'h0, out);
    assert(out == 32'h0);  // Default case

    $display("----------------------------------------------------");
    $display("All test cases passed.");
    $finish;
  end

endmodule

