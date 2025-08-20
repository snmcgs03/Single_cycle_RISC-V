`timescale 1ns/1ps

module and_tb;

    logic zero;
    logic branch;
    logic and_out;

    // Instantiate DUT
    and_gate uut (
        .zero(zero),
        .branch(branch),
        .and_out(and_out)
    );

    // Task to run a test and display the result
    task run_test(input logic z, input logic b);
        begin
            zero = z;
            branch = b;
            #1; // Wait for combinational logic to settle
            $display("zero = %b, branch = %b => and_out = %b", zero, branch, and_out);
        end
    endtask

    initial begin
        $display("Starting AND Gate Testbench...");

        // All 2-bit combinations
        run_test(0, 0); // 0 & 0
        run_test(0, 1); // 0 & 1
        run_test(1, 0); // 1 & 0
        run_test(1, 1); // 1 & 1

        $display("Testbench completed.");
        $finish;
    end

endmodule
