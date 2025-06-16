`timescale 1ns/1ps

module decoder_tb;

    reg [31:0] instruction;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode, imm11_5;
    wire [2:0] fn3;
    wire [11:0] imm;
    wire [19:0] imm_uj;
    wire fn7_5;

    // Instantiate the decoder
    decoder uut (
        .instruction(instruction),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .fn3(fn3),
        .imm(imm),
        .imm_uj(imm_uj),
        .imm11_5(imm11_5),
        .fn7_5(fn7_5)
    );

    task check(input string instr_name, input reg condition);
        if (condition)
            $display("%s is correct", instr_name);
        else
            $display("%s FAILED!", instr_name);
    endtask

    initial begin
        $display("Starting decoder testbench...\n");

        // R-type (add x3, x1, x2)
        instruction = 32'b0000000_00010_00001_000_00011_0110011;
        #1;
        check("add", rd == 5'd3 && rs1 == 5'd1 && rs2 == 5'd2 && fn3 == 3'b000 && opcode == 7'b0110011 && fn7_5 == 1'b0);

        // R-type (sub x3, x1, x2) - fn7[5] = 1
        instruction = 32'b0100000_00010_00001_000_00011_0110011;
        #1;
        check("sub", rd == 5'd3 && rs1 == 5'd1 && rs2 == 5'd2 && fn3 == 3'b000 && opcode == 7'b0110011 && fn7_5 == 1'b1);

        // I-type (addi x3, x1, 0x004)
        instruction = 32'b000000000100_00001_000_00011_0010011;
        #1;
        check("addi", rd == 5'd3 && rs1 == 5'd1 && fn3 == 3'b000 && imm == 12'h004);

        // Load (lw x3, 0x004(x1)).
        instruction = 32'b000000000100_00001_010_00011_0000011;
        #1;
        check("lw", rd == 5'd3 && rs1 == 5'd1 && fn3 == 3'b010 && imm == 12'h004);

        // Store (sw x3, 0x004(x2))
        instruction = 32'b0100100_00011_00010_010_00010_0100011;
        #1;
        check("sw", rs1 == 5'd2 && rs2 == 5'd3 && fn3 == 3'b010 && imm == {7'b0100100, 5'b00010});

        // B-type (beq x2, x3, offset=0)
        instruction = 32'b0_000000_00011_00010_000_0000_1_1100011;
        #1;
        check("beq", rs1 == 5'd2 && rs2 == 5'd3 && fn3 == 3'b000);

        // J-type (jal x3, offset)
        instruction = 32'b1_00000000_1_0000000001_00011_1101111;
        #1;
        check("jal", rd == 5'd3 && opcode == 7'b1101111);

        // U-type (lui x3, imm=0x1)
        instruction = 32'b00000000000000000001_00011_0110111;
        #1;
        check("lui", rd == 5'd3 && imm_uj == 20'h00001);

        // Corner: all zero
        instruction = 32'b0;
        #1;
        check("all_zeros", opcode == 7'b0000000 && rd == 0 && rs1 == 0 && rs2 == 0);

        // Corner: all ones
        instruction = 32'hFFFFFFFF;
        #1;
        check("all_ones", opcode == 7'b1111111 && fn3 == 3'b111 && rs1 == 5'b11111 && rs2 == 5'b11111);

        // Corner: Only fn3 & opcode set (I-type)
        instruction = {17'b0, 3'b101, 5'b00000, 7'b0010011};
        #1;
        check("fn3_only", fn3 == 3'b101 && opcode == 7'b0010011);

        // Corner: Only imm field set (I-type)
        instruction = {12'hFFF, 5'b0, 3'b000, 5'b0, 7'b0010011};
        #1;
        check("imm_only", imm == 12'hFFF && opcode == 7'b0010011);

        // Invalid opcode
        instruction = {25'b0, 7'b1111111};
        #1;
        check("invalid_opcode", opcode == 7'b1111111);

        $display("\nTestbench completed.");
        $finish;
    end

endmodule
