`timescale 1ns / 1ps

module alu_control_tb;

    // Inputs
    logic [2:0] alu_op;
    logic [2:0] fn3;
    logic [6:0] imm11_5;
    logic fn7_5;

    // Output
    logic [3:0] control_out;

    // Instantiate the DUT
    alu_control dut (
        .alu_op(alu_op),
        .fn3(fn3),
        .imm11_5(imm11_5),
        .fn7_5(fn7_5),
        .control_out(control_out)
    );

    initial begin
        $display("=== ALU Control Testbench Started ===");

        // ---------- R-Type ----------
        alu_op = 3'b000; fn3 = 3'b000; fn7_5 = 0; imm11_5 = 0; #1; // add
        $display("R-type ADD: control = %b", control_out);

        fn3 = 3'b000; fn7_5 = 1; #1; // sub
        $display("R-type SUB: control = %b", control_out);

        fn3 = 3'b100; fn7_5 = 0; #1; // xor
        $display("R-type XOR: control = %b", control_out);

        fn3 = 3'b110; #1; // or
        $display("R-type OR: control = %b", control_out);

        fn3 = 3'b111; #1; // and
        $display("R-type AND: control = %b", control_out);

        fn3 = 3'b001; #1; // sll
        $display("R-type SLL: control = %b", control_out);

        fn3 = 3'b101; fn7_5 = 0; #1; // srl
        $display("R-type SRL: control = %b", control_out);

        fn3 = 3'b101; fn7_5 = 1; #1; // sra
        $display("R-type SRA: control = %b", control_out);

        fn3 = 3'b010; #1; // slt
        $display("R-type SLT: control = %b", control_out);

        fn3 = 3'b011; #1; // sltu
        $display("R-type SLTU: control = %b", control_out);

        // ---------- I-Type ----------
        alu_op = 3'b001;

        fn3 = 3'b000; imm11_5 = 0; #1; // addi
        $display("I-type ADDI: control = %b", control_out);

        fn3 = 3'b100; #1; // xori
        $display("I-type XORI: control = %b", control_out);

        fn3 = 3'b110; #1; // ori
        $display("I-type ORI: control = %b", control_out);

        fn3 = 3'b111; #1; // andi
        $display("I-type ANDI: control = %b", control_out);

        fn3 = 3'b001; #1; // slli
        $display("I-type SLLI: control = %b", control_out);

        fn3 = 3'b101; imm11_5 = 7'h00; #1; // srli
        $display("I-type SRLI: control = %b", control_out);

        fn3 = 3'b101; imm11_5 = 7'h20; #1; // srai
        $display("I-type SRAI: control = %b", control_out);

        fn3 = 3'b010; #1; // slti
        $display("I-type SLTI: control = %b", control_out);

        fn3 = 3'b011; #1; // sltiu
        $display("I-type SLTIU: control = %b", control_out);

        // ---------- Load ----------
        alu_op = 3'b010;

        fn3 = 3'b000; #1; $display("Load LB: control = %b", control_out);
        fn3 = 3'b001; #1; $display("Load LH: control = %b", control_out);
        fn3 = 3'b010; #1; $display("Load LW: control = %b", control_out);
        fn3 = 3'b100; #1; $display("Load LBU: control = %b", control_out);
        fn3 = 3'b101; #1; $display("Load LHU: control = %b", control_out);

        // ---------- Store (S-Type) ----------
        alu_op = 3'b011;

        fn3 = 3'b000; #1; $display("Store SB: control = %b", control_out);
        fn3 = 3'b001; #1; $display("Store SH: control = %b", control_out);
        fn3 = 3'b010; #1; $display("Store SW: control = %b", control_out);

        // ---------- Branch (B-Type) ----------
        alu_op = 3'b100;

        fn3 = 3'b000; #1; $display("BEQ: control = %b", control_out);
        fn3 = 3'b001; #1; $display("BNE: control = %b", control_out);
        fn3 = 3'b100; #1; $display("BLT: control = %b", control_out);
        fn3 = 3'b101; #1; $display("BGE: control = %b", control_out);
        fn3 = 3'b110; #1; $display("BLTU: control = %b", control_out);
        fn3 = 3'b111; #1; $display("BGEU: control = %b", control_out);

        // ---------- Jump ----------
        alu_op = 3'b101;

        fn3 = 3'b000; #1; $display("JAL: control = %b", control_out);
        fn3 = 3'b001; #1; $display("JALR (unexpected fn3): control = %b", control_out);

        // ---------- Default / Corner ----------
        alu_op = 3'b111; fn3 = 3'b111; imm11_5 = 7'h7F; fn7_5 = 1; #1;
        $display("Unknown Instruction: control = %b", control_out);

        $display("=== ALU Control Testbench Finished ===");
        $finish;
    end

endmodule
