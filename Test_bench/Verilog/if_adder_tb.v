module if_adder_tb;

    // Parameter
    parameter N = 32;

    // DUT signals
    reg [N-1:0] addr, imm;    // Inputs
    wire [N-1:0] result;      // Output

    // Instantiate the DUT
    if_adder #(N) dut (
        .address(addr),
        .imm_out(imm),
        .pc_signed_offset(result)
    );

  // Task to apply a test case and display result
  task run_test(input logic [N-1:0] a, input logic [N-1:0] b);
    begin
      addr = a;
      imm = b;
      #1; // Wait for combinational logic to settle
      $display("address = 0x%08h, imm_out = 0x%08h => result = 0x%08h", addr, imm, result);
    end
  endtask

  initial begin
    $display("---- Starting if_adder Testbench ----");

    // Test 1: Both inputs zero
    run_test(32'd0, 32'd0);

    // Test 2: address = 0, imm = +ve number
    run_test(32'd0, 32'd123);

    // Test 3: address = max positive, imm = 1 (check overflow)
    run_test(32'h7FFFFFFF, 32'd1);

    // Test 4: address = max negative (signed), imm = -1
    run_test(32'h80000000, 32'hFFFFFFFF); // -1 in 2's complement

    // Test 5: address = any number, imm = -offset
    run_test(32'd100, -32'd40); // should yield 60

    // Test 6: address = large number, imm = large negative
    run_test(32'hFFFF0000, 32'hFFFFF000); // check wraparound

    // Test 7: address = 32'hFFFFFFFF, imm = 1
    run_test(32'hFFFFFFFF, 32'd1); // overflow to 0

    // Test 8: Random middle values
    run_test(32'd12345678, 32'd1000);

    $display("---- Testbench Completed ----");
    $finish;
  end

endmodule
