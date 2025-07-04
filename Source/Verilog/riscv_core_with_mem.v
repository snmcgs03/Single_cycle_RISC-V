module riscv_core_with_mem (
    input clk,
    input reset
    );

// Internal wires with KEEP attributes to aid debugging
(* KEEP = "TRUE" *) wire [31:0] instruction;
(* KEEP = "TRUE" *) wire [31:0] rs2_data;
(* KEEP = "TRUE" *) wire [31:0] alu_out;
(* KEEP = "TRUE" *) wire [31:0] read_data;
(* KEEP = "TRUE" *) wire [31:0] mem_addr_out;
(* KEEP = "TRUE" *) wire [31:0] store_data;
(* KEEP = "TRUE" *) wire [31:0] address;
(* KEEP = "TRUE" *) wire mem_read;
(* KEEP = "TRUE" *) wire mem_write;
(* KEEP = "TRUE" *) wire [2:0] fn3;
(* KEEP = "TRUE" *) wire [6:0] opcode;

// Instruction memory instance
(* DONT_TOUCH = "TRUE" *) instruction_mem inst_mem (
    .clk(clk),
    .address(address),
    .instruction(instruction)
);

// CPU core instance
(* DONT_TOUCH = "TRUE" *) single_cycle_riscV cpu (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .rs2_data(rs2_data),
    .address(address),
    .mem_out(mem_addr_out),
    .mem_read(mem_read),
    .alu_out(alu_out),
    .mem_write(mem_write),
    .fn3(fn3),
    .opcode(opcode)
);

// Data memory instance
(* DONT_TOUCH = "TRUE" *) data_mem data_memory (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .addr(alu_out),
    .write_data(store_data),
    .read_data(read_data)
);

// Load addressing logic
(* DONT_TOUCH = "TRUE" *) load_addressing la (
    .memory_val(read_data),
    .opcode(opcode),
    .fn3(fn3),
    .mem_addr_out(mem_addr_out)
);

// Store addressing logic
(* DONT_TOUCH = "TRUE" *) store_addressing sa (
    .opcode(opcode),
    .read_data(read_data),
    .rs2_data(rs2_data),
    .store_data(store_data),
    .fn3(fn3)
);

endmodule
