module wb_stage (
    input wire [31:0] mem_out,          // Memory output
    input wire [31:0] alu_out,          // ALU output
    input wire [31:0] return_addr,      // Return address
    input wire [31:0] imm_out,          // Immediate output
    input wire [31:0] pc_signed_offset, // PC signed offset
    input wire [6:0] opcode_out_d,       // Opcode output
    input wire [1:0] memtoreg,           // Mem to reg control
    output wire [31:0] wb_data          // Write-back data
);

    // Internal wires
    wire [1:0] U_control;                // Control signal for U_mux
    wire [31:0] out;                     // Output of U_mux

    // Write-back mux
    (* DONT_TOUCH = "TRUE" *) mux31 mux_wb (
        .a(alu_out),
        .b(mem_out),
        .c(out),
        .cntrl(memtoreg),
        .out(wb_data)
    );

    // Control generation for U_mux
    (* DONT_TOUCH = "TRUE" *) control_gen U_cntrl (
        .opcode_out_d(opcode_out_d),
        .U_control(U_control)
    );

    // U_mux for handling return address, immediate output, and PC offset
    (* DONT_TOUCH = "TRUE" *) mux31 U_mux (
        .a(return_addr),
        .b(imm_out),
        .c(pc_signed_offset),
        .cntrl(U_control),
        .out(out)
    );

endmodule

