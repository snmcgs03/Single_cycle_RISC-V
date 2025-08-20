`timescale 1ns/1ps

module imm_generator_tb;

    logic [11:0] imm_input;
    logic [6:0] opcode;
    logic [19:0] imm_input_uj;
    logic [31:0] imm_output;

    // Instantiate DUT
    imm_generator uut (
        .imm_input(imm_input),
        .opcode(opcode),
        .imm_output(imm_output),
        .imm_input_uj(imm_input_uj)
    );

    task check(string name, logic [31:0] expected);
        if (imm_output === expected)
            $display("%s is correct", name);
        else
            $display("%s FAILED: Expected %h, Got %h", name, expected, imm_output);
    endtask

    initial begin
        $display("Starting imm_generator testbench...\n");

        // B-Type (e.g., BEQ) imm = 12'b000000100100 = 0x024
        imm_input = 12'b000000100100;
        opcode = 7'b1100011;
        #1;
        check("B-Type positive", {{20{1'b0}}, imm_input} << 1);

        // B-Type negative immediate (sign-extended)
        imm_input = 12'b100000000000;  // MSB is 1
        opcode = 7'b1100011;
        #1;
        check("B-Type negative", {{20{1'b1}}, imm_input} << 1);

        // J-Type (e.g., JAL) imm = 20'b00000000000000000010 = 0x2
        imm_input_uj = 20'h00002;
        opcode = 7'b1101111;
        #1;
        check("J-Type positive", {{12{1'b0}}, imm_input_uj} << 1);

        // J-Type negative (sign-extended)
        imm_input_uj = 20'b10000000000000000000;
        opcode = 7'b1101111;
        #1;
        check("J-Type negative", {{12{1'b1}}, imm_input_uj} << 1);

        // U-Type (e.g., LUI) - just shift left 12 bits
        imm_input_uj = 20'hABCDE;
        opcode = 7'b0110111;
        #1;
        check("U-Type", {imm_input_uj, 12'b0});

        // Default case (I-type/S-type) with positive imm
        imm_input = 12'h00F;
        opcode = 7'b0010011; // I-type opcode
        #1;
        check("I-type", {{20{1'b0}}, imm_input});

        // Default case with negative immediate
        imm_input = 12'hFFF; // -1 in 12-bit
        opcode = 7'b0100011; // S-type opcode
        #1;
        check("S-type negative", {{20{1'b1}}, imm_input});

        // Corner: all zero
        imm_input = 12'b0;
        imm_input_uj = 20'b0;
        opcode = 7'b0000000;
        #1;
        check("All zero", 32'b0);

        // Corner: all one (imm_input = 0xFFF, imm_input_uj = 0xFFFFF)
        imm_input = 12'hFFF;
        imm_input_uj = 20'hFFFFF;
        opcode = 7'b1100011;
        #1;
        check("All ones B-Type", {{20{1'b1}}, imm_input} << 1);

        opcode = 7'b1101111;
        #1;
        check("All ones J-Type", {{12{1'b1}}, imm_input_uj} << 1);

        opcode = 7'b0110111;
        #1;
        check("All ones U-Type", {imm_input_uj, 12'b0});

        $display("\nTestbench completed.");
        $finish;
    end

endmodule