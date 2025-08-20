`timescale 1ns/1ps

module mux_21_tb;

    logic [31:0] a, b;
    logic control;
    logic [31:0] y;

    // Instantiate the DUT
    mux21 uut (
        .a(a),
        .b(b),
        .control(control),
        .y(y)
    );

    // Task to run a test and display result
    task run_test(input [31:0] a_in, input [31:0] b_in, input bit ctrl);
        begin
            a = a_in;
            b = b_in;
            control = ctrl;
            #1; // Wait for a delta cycle
            $display("a = 0x%08x, b = 0x%08x, control = %b => y = 0x%08x", a, b, control, y);
        end
    endtask

    initial begin
        $display("Starting MUX Testbench...");

        // Corner cases
        run_test(32'h00000000, 32'h00000000, 0); // both zero, select a
        run_test(32'h00000000, 32'h00000000, 1); // both zero, select b

        run_test(32'hFFFFFFFF, 32'hFFFFFFFF, 0); // both ones, select a
        run_test(32'hFFFFFFFF, 32'hFFFFFFFF, 1); // both ones, select b

        run_test(32'h00000000, 32'hFFFFFFFF, 0); // a=0, b=1s, select a
        run_test(32'h00000000, 32'hFFFFFFFF, 1); // a=0, b=1s, select b

        run_test(32'hFFFFFFFF, 32'h00000000, 0); // a=1s, b=0, select a
        run_test(32'hFFFFFFFF, 32'h00000000, 1); // a=1s, b=0, select b

        run_test(32'h7FFFFFFF, 32'h80000000, 0); // max signed, min signed, select a
        run_test(32'h7FFFFFFF, 32'h80000000, 1); // max signed, min signed, select b

        run_test(32'h12345678, 32'h87654321, 0); // random pattern, select a
        run_test(32'h12345678, 32'h87654321, 1); // random pattern, select b

        $display("Testbench completed.");
        $finish;
    end

endmodule
