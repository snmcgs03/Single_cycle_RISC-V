module id_stage (
    input wire [31:0] instruction,   // Instruction input
    input wire [31:0] wb_data,       // Write-back data
    input wire clk,                  // Clock input
    input wire reset,                // Reset input
    output wire mux_inp,             // Mux input control
    output wire [31:0] rs1_data,     // Register source 1 data
    output wire [31:0] rs2_data,     // Register source 2 data
    output wire [31:0] imm_out,      // Immediate output
    output wire [6:0] opcode_out_d,  // Decoded opcode
    output wire [6:0] imm11_5,       // Immediate 11:5
    output wire [2:0] fn3_out_d,     // Function 3 output
    output wire [2:0] aluop,         // ALU operation
    output wire [1:0] memtoreg,      // Memory-to-register control
    output wire fn7_5,               // Function 7 bit 5
    output wire branch,              // Branch control
    output wire mem_read,            // Memory read enable
    output wire mem_write,           // Memory write enable
    output wire alu_src              // ALU source control
);

    // Internal wires
    wire reg_write;                  // Register write enable
    wire [4:0] rs1, rs2, rd;         // Register addresses
    wire [19:0] imm_uj_outd;         // UJ-type immediate
    wire [11:0] imm_out_d;           // Immediate from decoder

    // Decoder instance
    (* DONT_TOUCH = "TRUE" *) decoder #(32) decode (
        .imm11_5(imm11_5),
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .imm(imm_out_d),
        .imm_uj(imm_uj_outd),
        .fn3(fn3_out_d),
        .opcode(opcode_out_d),
        .fn7_5(fn7_5)
    );

    // Immediate generator instance
    (* DONT_TOUCH = "TRUE" *) imm_generator imm_gen (
        .imm_input_uj(imm_uj_outd),
        .imm_input(imm_out_d),
        .imm_output(imm_out),
        .fn3(fn3_out_d),
        .opcode(opcode_out_d)
    );

    // Register file instance
    (* DONT_TOUCH = "TRUE" *) reg_file register_file (
        .rd_sel(rd),
        .reg_write(reg_write),
        .wb_data(wb_data),
        .clk(clk),
        .reset(reset),
        .rs1_sel(rs1),
        .rs2_sel(rs2),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Main control instance
    (* DONT_TOUCH = "TRUE" *) main_control mc (
        .mux_inp(mux_inp),
        .opcode(opcode_out_d),
        .branch(branch),
        .memread(mem_read),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .memwrite(mem_write),
        .alusrc(alu_src),
        .reg_write(reg_write)
    );

endmodule
