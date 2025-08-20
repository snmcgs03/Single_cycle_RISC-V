`timescale 1ns/1ps

module riscv_core_with_mem(
    input  logic         clk,
    input  logic         reset, // This is now the main ASYNCHRONOUS reset
    input  logic [31:0]  write_inst,
    input  logic         inst_mem_write_en
);

    // --- Internal Signals ---
    wire [31:0] instruction;
    wire [31:0] pc_address;
    wire [31:0] alu_out;
    wire [31:0] rs2_data;
    wire [31:0] raw_mem_read_data;
    wire [31:0] data_to_cpu_wb;
    wire [31:0] data_to_mem_write;
    wire        mem_write;
    wire [3:0]  byte_enable;
    wire [2:0]  fn3;
    wire [6:0]  opcode;
    
    // NEW: Internal wire for the synchronized reset signal
    wire        sync_reset_w;

    // --- Instantiations ---

    // NEW: Instantiate the reset synchronizer
    rst_sync reset_synchronizer_unit (
        .clk(clk),
        .reset(reset),               // Input is the main async reset
        .sync_reset(sync_reset_w)    // Output is the new sync reset
    );  

    instruction_mem inst_mem (
        .clk(clk),
        .reset(sync_reset_w),        // UPDATED: Connected to sync reset
        .write_en(inst_mem_write_en),
        .address(pc_address),
        .write_inst(write_inst),
        .instruction(instruction)
    );

    single_cycle_riscV cpu (
        .clk(clk),
        .reset(sync_reset_w),        // UPDATED: Connected to sync reset
        .instruction(instruction),
        .mem_out(data_to_cpu_wb),
        .rs2_data(rs2_data),
        .address(pc_address),
        .alu_out(alu_out),
        .mem_write(mem_write),
        .fn3(fn3),
        .opcode(opcode)
    );

    data_mem data_memory (
        .clk(clk),
        .mem_write(mem_write),
        .addr({alu_out[31:2], 2'b00}),
        .write_data(data_to_mem_write),
        .byte_enable(byte_enable),
        .read_data(raw_mem_read_data)
    );
    
    memory_interface mem_if (
        .opcode(opcode),
        .fn3(fn3),
        .cpu_store_data(rs2_data),
        .cpu_writeback_data(data_to_cpu_wb),
        .addr_lsb(alu_out[1:0]),
        .mem_read_data(raw_mem_read_data),
        .byte_enable(byte_enable),
        .mem_write_data(data_to_mem_write)
    );

endmodule