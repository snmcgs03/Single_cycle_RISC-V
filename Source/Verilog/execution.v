module execution (
    output wire [31:0] alu_out,       // ALU output
    output wire [31:0] pc_ex_out,     // PC execution output
    output wire and_out_ex,           // AND gate output
    input wire [31:0] rs1_data,       // Register source 1 data
    input wire [31:0] rs2_data,       // Register source 2 data
    input wire [31:0] imm_out,        // Immediate output
    input wire [31:0] address,        // Address input
    input wire branch,                // Branch signal
    input wire alu_src,               // ALU source control
    input wire fn7_5,                 // Function 7 bit 5
    input wire mux_inp,               // Mux input control
    input wire [2:0] fn3,             // Function 3
    input wire [6:0] imm11_5,         // Immediate 11:5
    input wire [2:0] aluop            // ALU operation
);

    // Internal wires
    wire [31:0] mux_ex_out;           // Mux output for ALU input
    wire zero;                        // Zero flag from ALU
    wire [3:0] alu_operation;         // ALU control signal
    wire [31:0] pc_signed_offset;     // PC signed offset

    // Mux for PC
    (* DONT_TOUCH = "TRUE" *) mux21 mux_pc (
        .a(pc_signed_offset),
        .b(alu_out),
        .y(pc_ex_out),
        .control(mux_inp)
    );

    // AND gate for branch control
    (* DONT_TOUCH = "TRUE" *) and_gate and_ex (
        .zero(zero),
        .branch(branch),
        .and_out(and_out_ex)
    );

    // Adder for PC calculation
    (* DONT_TOUCH = "TRUE" *) if_adder ex_add (
        .address(address),
        .pc_signed_offset(pc_signed_offset),
        .imm_out(imm_out)
    );

    // ALU
    (* DONT_TOUCH = "TRUE" *) alu alu1 (
        .alu_control(alu_operation),
        .rs1_data(rs1_data),
        .rs2_data(mux_ex_out),
        .alu_out(alu_out),
        .zero(zero)
    );

    // Mux for ALU input
    (* DONT_TOUCH = "TRUE" *) mux21 mux_ex (
        .a(rs2_data),
        .b(imm_out),
        .control(alu_src),
        .y(mux_ex_out)
    );

    // ALU control
    (* DONT_TOUCH = "TRUE" *) alu_control ac (
        .alu_op(aluop),
        .control_out(alu_operation),
        .fn3(fn3),
        .imm11_5(imm11_5),
        .fn7_5(fn7_5)
    );

endmodule
