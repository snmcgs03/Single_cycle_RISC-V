`timescale 1ns / 1ps

module prog_counter_tb;

    // Testbench signals
    logic clk;
    logic reset;
    logic [31:0] pc_next;
    logic [31:0] address;

    // Instantiate the Program_Counter module
    Program_Counter uut (
        .pc_next(pc_next),
        .clk(clk),
        .reset(reset),
        .address(address)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        pc_next = 32'h0000_0000;

        // Apply reset
        $display("Time: %0t - Applying reset", $time);
        reset = 1;
        #10;
        reset = 0;
        $display("Time: %0t - Deasserting reset", $time);

        // Cycle 1: PC = 0x00000004
        pc_next = 32'h0000_0004;
        #10;

        // Cycle 2: PC = 0x00000008
        pc_next = 32'h0000_0008;
        #10;

        // Cycle 3: PC = 0x0000000C
        pc_next = 32'h0000_000C;
        #10;

        // Cycle 4: Apply reset again
        $display("Time: %0t - Applying reset again", $time);
        reset = 1;
        #10;
        reset = 0;

        // Cycle 5: PC = 0x00000010
        pc_next = 32'h0000_0010;
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | reset = %b | pc_next = %h | address = %h", 
                 $time, reset, pc_next, address);
    end

endmodule
