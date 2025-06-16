`timescale 1ns/1ps

module inst_mem_tb;

    reg clk;
    reg [31:0] address;
    wire [31:0] instruction;

    // Instantiate the instruction memory
    instruction_mem dut (
        .clk(clk),
        .address(address),
        .instruction(instruction)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Simulation
    initial begin
        clk = 0;
        address = 0;

        $display("Loading instructions from hex file...");
        $readmemh("C:/Users/DELL/Desktop/VERILOG/design_of_risc_v/design_of_risc_v/design_of_risc_v.srcs/sim_1/new/instructions.hex", dut.mem); // Read memory contents into 'mem' array

        $display("Instruction Memory Test Begins");

        // Loop through memory addresses and fetch instructions
        repeat (40) begin
            @(posedge clk);
            $display("Address = %0h, Instruction = %h", address, instruction);
            address = address + 4;
        end

        $display("Instruction Memory Test Completed");
        $finish;
    end

endmodule
