`timescale 1ns/1ps

module reg_file_tb;

  logic [4:0] rs1_sel, rs2_sel, rd_sel;
  logic reg_write, clk, reset;
  logic [31:0] wb_data;
  logic [31:0] rs1_data, rs2_data;

  reg_file dut (
    .rs1_sel(rs1_sel),
    .rs2_sel(rs2_sel),
    .reg_write(reg_write),
    .clk(clk),
    .reset(reset),
    .wb_data(wb_data),
    .rd_sel(rd_sel),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $display("\n==== STARTING REG FILE TB ====");

    // Initial values
    clk = 0;
    reset = 0;
    reg_write = 0;
    rs1_sel = 0;
    rs2_sel = 0;
    rd_sel = 0;
    wb_data = 0;

    // ✅ Apply reset
    reset = 1;
    #10;
    reset = 0;

    // ✅ Check reset-initialized values
    rs1_sel = 1; rs2_sel = 2; #1;
    $display("Reset Check 1: rs1_data = %h, rs2_data = %h (should be 1, 2)", rs1_data, rs2_data);

    rs1_sel = 3; rs2_sel = 6; #1;
    $display("Reset Check 2: rs1_data = %h, rs2_data = %h (should be 3, 6)", rs1_data, rs2_data);

    // ✅ Normal write to register 7
    rd_sel = 7;
    wb_data = 32'h12345678;
    reg_write = 1;
    #10;
    reg_write = 0;

    rs1_sel = 7; rs2_sel = 8; #1;
    $display("Write Check: rs1_data = %h, rs2_data = %h (should be 12345678, 8)", rs1_data, rs2_data);

    // ✅ Illegal write to x0 (should remain zero)
    rd_sel = 0;
    wb_data = 32'hFFFFFFFF;
    reg_write = 1;
    #10;
    reg_write = 0;

    rs1_sel = 0; rs2_sel = 1; #1;
    $display("x0 Write Attempt: rs1_data = %h, rs2_data = %h (should be 0, 1)", rs1_data, rs2_data);

    // ✅ Write disabled - write attempt to x10 should not happen
    rd_sel = 10;
    wb_data = 32'hDEADBEEF;
    reg_write = 0;
    #10;

    rs1_sel = 10; rs2_sel = 9; #1;
    $display("Write Disabled: rs1_data = %h, rs2_data = %h (should be A, 9)", rs1_data, rs2_data);

    // ✅ Final valid write to x15
    rd_sel = 15;
    wb_data = 32'hCAFEBABE;
    reg_write = 1;
    #10;
    reg_write = 0;

    rs1_sel = 15; rs2_sel = 14; #1;
    $display("Final Write: rs1_data = %h, rs2_data = %h (should be CAFEBABE, E)", rs1_data, rs2_data);

    $display("==== REG FILE TB COMPLETE ====\n");
    $finish;
  end
endmodule
