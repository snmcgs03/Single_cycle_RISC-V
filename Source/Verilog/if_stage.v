module if_stage #(parameter N = 32) (
    input wire clk,                  // Clock input
    input wire and_out,              // Control signal
    input wire reset,                // Reset signal
    input wire [N-1:0] pc_signed_offset, // Program counter offset
    input wire [6:0] opcode,         // Opcode input
    output wire [N-1:0] address,     // Current program counter
    output wire [N-1:0] pc_new       // Next program counter
);

    wire [N-1:0] pc_next;            // Output of mux21
    wire pc_gen_out;                 // Control signal for the mux21

    // Adder instance
    (* DONT_TOUCH = "TRUE" *) adder #(N) add (
        .address(address),
        .b(4),
        .pc_new(pc_new)
    );

    // MUX instance
    (* DONT_TOUCH = "TRUE" *) mux21 mu (
        .a(pc_new),
        .b(pc_signed_offset),
        .control(pc_gen_out),
        .y(pc_next)
    );

    // Program Counter instance
    (* DONT_TOUCH = "TRUE" *) Program_Counter programc (
        .pc_next(pc_next),
        .address(address),
        .clk(clk),
        .reset(reset)
    );

    // PC Control Logic instance
    (* DONT_TOUCH = "TRUE" *) pc_cntrl pc_cnt (
        .opcode(opcode),
        .and_out(and_out),
        .pc_gen_out(pc_gen_out)
    );

endmodule
