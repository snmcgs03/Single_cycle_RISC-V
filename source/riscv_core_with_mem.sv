module riscv_core_with_mem #(parameter N=32)(
    input logic clk, reset,
    output logic [31:0] r_out
);

(* KEEP = "TRUE" *) wire [31:0] instruction;
(* KEEP = "TRUE" *) wire [31:0] rs2_data;
(* KEEP = "TRUE" *) wire [31:0] write_data;
(* KEEP = "TRUE" *) wire [31:0] alu_out;
(* KEEP = "TRUE" *) wire [N-1:0] wb_data;
(* KEEP = "TRUE" *) wire [31:0] address, mem_out;
(* KEEP = "TRUE" *) wire mem_read, mem_write;

(* DONT_TOUCH = "TRUE" *) instruction_mem inst_mem (
    .clk(clk),
    .address(address),
    .instruction(instruction)
);

(* DONT_TOUCH = "TRUE" *) single_cycle_riscV cpu (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .rs2_data(rs2_data),
    .r_out(wb_data),
    .address(address),
    .mem_out(mem_out),
    .mem_read(mem_read),
    .alu_out(alu_out),
    .mem_write(mem_write)
);

(* DONT_TOUCH = "TRUE" *) data_mem data_memory (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .addr(alu_out),
    .write_data(rs2_data),
    .read_data(mem_out)
);

assign r_out = wb_data;

endmodule
