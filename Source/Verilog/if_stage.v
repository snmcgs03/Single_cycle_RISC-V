module if_stage (
    input clk,
    input and_out,
    input reset,
    input [31:0] pc_signed_offset,
    input [6:0] opcode,
    output [31:0] address,
    output [31:0] pc_new
);

    wire [31:0] pc_next;
    wire pc_gen_out;

    // Adder: PC + 4
    (* DONT_TOUCH = "TRUE" *) adder add (
        .address(address),
        .b(4),
        .pc_new(pc_new)
    );

    // Mux: Select between PC+4 and branch target
    (* DONT_TOUCH = "TRUE" *) mux21 mu (
        .a(pc_new),
        .b(pc_signed_offset),
        .control(pc_gen_out),
        .y(pc_next)
    );

    // Program Counter register
    (* DONT_TOUCH = "TRUE" *) Program_Counter programc (
        .pc_next(pc_next),
        .address(address),
        .clk(clk),
        .reset(reset)
    );

    // PC Control logic
    (* DONT_TOUCH = "TRUE" *) pc_cntrl pc_cnt (
        .opcode(opcode),
        .and_out(and_out),
        .pc_gen_out(pc_gen_out)
    );

endmodule
