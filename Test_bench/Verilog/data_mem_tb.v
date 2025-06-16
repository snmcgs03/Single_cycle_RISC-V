`timescale 1ns/1ps

module data_mem_tb;

    reg clk;
    reg mem_write;
    reg mem_read;
    reg [31:0] addr;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate data memory
    data_mem dut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test process
    initial begin
        clk = 0;
        mem_write = 0;
        mem_read = 0;
        addr = 0;
        write_data = 0;

        // Load data from hex file
        $readmemh("C:/Users/DELL/Desktop/VERILOG/design_of_risc_v/design_of_risc_v/design_of_risc_v.srcs/sim_1/new/data.hex", dut.mem);
        $display("Initial memory loaded from hex");

        @(posedge clk);

        // Example write to address 0x04
        addr = 32'h04;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        @(posedge clk);
        mem_write = 0;

        // Example read from address 0x04
        mem_read = 1;
        @(posedge clk);
        $display("Read from addr 0x04: %h", read_data);
        mem_read = 0;

        // Another write
        addr = 32'h10;
        write_data = 32'hCAFEBABE;
        mem_write = 1;
        @(posedge clk);
        mem_write = 0;

        // Another read
        mem_read = 1;
        @(posedge clk);
        $display("Read from addr 0x10: %h", read_data);
        mem_read = 0;

        $finish;
    end

endmodule
