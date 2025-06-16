`timescale 1ns/1ps

module adder_tb;

    parameter N = 32;
    reg [N-1:0] address;
    reg [N-1:0] b;
    wire [N-1:0] pc_new;

    // Instantiate the DUT (Design Under Test)
    adder #(N) uut (
        .address(address),
        .b(b),
        .pc_new(pc_new)
    );

    // Task to apply test vector
    task run_test(input [N-1:0] a_in, input [N-1:0] b_in);
        begin
            address = a_in;
            b = b_in;
            #1; // wait for one delta cycle
            $display("address = 0x%08x, b = 0x%08x => pc_new = 0x%08x", address, b, pc_new);
        end
    endtask

    initial begin
        $display("Starting Adder Testbench...");

        // Zero + Zero
        run_test(32'h00000000, 32'h00000000);

        // Max + Zero
        run_test(32'hFFFFFFFF, 32'h00000000);

        // Zero + Max
        run_test(32'h00000000, 32'hFFFFFFFF);

        // Positive + Positive (no overflow)
        run_test(32'h00000010, 32'h00000020);

        // Positive + Negative (result positive)
        run_test(32'h00000020, 32'hFFFFFFF0); // 32 + (-16) = 16

        // Positive + Negative (result negative)
        run_test(32'h00000010, 32'hFFFFFFF0); // 16 + (-16) = 0

        // Negative + Negative
        run_test(32'hFFFFFFF0, 32'hFFFFFFF0); // (-16) + (-16) = -32

        // Max positive + 1 (overflow)
        run_test(32'h7FFFFFFF, 32'h00000001); // 2^31-1 + 1 = 0x80000000

        // Min negative + (-1)
        run_test(32'h80000000, 32'hFFFFFFFF); // -2^31 + (-1) = 0x7FFFFFFF

        // Random case
        run_test(32'h12345678, 32'h87654321);

        $display("Testbench completed.");
        $finish;
    end

endmodule
