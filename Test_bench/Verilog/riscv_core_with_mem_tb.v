`timescale 1ns/1ps

module riscv_core_with_mem_tb;

    reg clk;
    reg reset;
    wire [31:0] r_out;

    riscv_core_with_mem dut (
        .clk(clk),
        .reset(reset),
        .r_out(r_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Load instruction memory
        $display("Loading instructions into instruction memory...");
        $readmemh("C:/Users/DELL/Desktop/design_of_risc_v/design_of_risc_v.srcs/sim_1/new/instructions.hex", dut.inst_mem.mem);

        // Load data memory
        $display("Loading data into data memory...");
        $readmemh("C:/Users/DELL/Desktop/design_of_risc_v/design_of_risc_v.srcs/sources_1/new/data_memory.hex", dut.data_memory.mem);

        // Apply reset
        #10;
        reset = 0;

        // Run the simulation for a reasonable number of cycles
        repeat (40) begin
            @(posedge clk);
            $display("PC = %h | r_out = %h | ALU = %h | MemRead = %b | MemWrite = %b", 
                      dut.address, r_out, dut.alu_out, dut.mem_read, dut.mem_write);
        end

        $display("Test completed.");
        $finish;
    end

endmodule
