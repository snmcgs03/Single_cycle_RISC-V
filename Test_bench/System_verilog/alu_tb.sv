`timescale 1ns / 1ps

module alu_tb;

    // DUT inputs
    logic [3:0] alu_control;
    logic [31:0] rs1_data, rs2_data;

    // DUT outputs
    logic [31:0] alu_out;
    logic zero;

    // Instantiate the ALU
    alu uut (
        .alu_control(alu_control),
        .alu_out(alu_out),
        .zero(zero),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    initial begin
        $display("=== ALU Testbench Started ===");

        // Test ADD
        alu_control = 4'b0000;
        rs1_data = 32'd10;
        rs2_data = 32'd20;
        #1;
        $display("ADD: %d + %d = %d", rs1_data, rs2_data, alu_out);

        // Test SUB
        alu_control = 4'b0001;
        rs1_data = 32'd30;
        rs2_data = 32'd10;
        #1;
        $display("SUB: %d - %d = %d", rs1_data, rs2_data, alu_out);

        // Test XOR
        alu_control = 4'b0010;
        rs1_data = 32'hFF00FF00;
        rs2_data = 32'h00FF00FF;
        #1;
        $display("XOR: %h ^ %h = %h", rs1_data, rs2_data, alu_out);

        // Test OR
        alu_control = 4'b0011;
        rs1_data = 32'hA5A5A5A5;
        rs2_data = 32'h5A5A5A5A;
        #1;
        $display("OR : %h | %h = %h", rs1_data, rs2_data, alu_out);

        // Test AND
        alu_control = 4'b0100;
        rs1_data = 32'hFFFF0000;
        rs2_data = 32'h00FFFF00;
        #1;
        $display("AND: %h & %h = %h", rs1_data, rs2_data, alu_out);

        // Test SLL
        alu_control = 4'b0101;
        rs1_data = 32'd1;
        rs2_data = 32'd4;
        #1;
        $display("SLL: %d << %d = %d", rs1_data, rs2_data, alu_out);

        // Test SRL
        alu_control = 4'b0110;
        rs1_data = 32'd16;
        rs2_data = 32'd2;
        #1;
        $display("SRL: %d >> %d = %d", rs1_data, rs2_data, alu_out);

        // Test SRA
        alu_control = 4'b0111;
        rs1_data = -32'd8;
        rs2_data = 32'd1;
        #1;
        $display("SRA: %d >>> %d = %d", rs1_data, rs2_data, alu_out);

        // Test SLT
        alu_control = 4'b1000;
        rs1_data = -32'd5;
        rs2_data = 32'd3;
        #1;
        $display("SLT: %d < %d = %h", rs1_data, rs2_data, alu_out);

        // Test SLTU
        alu_control = 4'b1001;
        rs1_data = 32'd5;
        rs2_data = 32'd10;
        #1;
        $display("SLTU: %d < %d = %h", rs1_data, rs2_data, alu_out);

        // Test BEQ (equal)
        alu_control = 4'b1010;
        rs1_data = 32'd15;
        rs2_data = 32'd15;
        #1;
        $display("BEQ: %d == %d => zero = %b", rs1_data, rs2_data, zero);

        // Test BNE (not equal)
        alu_control = 4'b1011;
        rs1_data = 32'd20;
        rs2_data = 32'd25;
        #1;
        $display("BNE: %d != %d => zero = %b", rs1_data, rs2_data, zero);

        // Test BLT (signed)
        alu_control = 4'b1100;
        rs1_data = -32'd5;
        rs2_data = 32'd1;
        #1;
        $display("BLT: %d < %d => zero = %b", rs1_data, rs2_data, zero);

        // Test BGE (signed)
        alu_control = 4'b1101;
        rs1_data = 32'd10;
        rs2_data = 32'd5;
        #1;
        $display("BGE: %d >= %d => zero = %b", rs1_data, rs2_data, zero);

        // Test BLTU (unsigned)
        alu_control = 4'b1110;
        rs1_data = 32'd5;
        rs2_data = 32'd10;
        #1;
        $display("BLTU: %d < %d => zero = %b", rs1_data, rs2_data, zero);

        // Test BGEU (unsigned)
        alu_control = 4'b1111;
        rs1_data = 32'd100;
        rs2_data = 32'd50;
        #1;
        $display("BGEU: %d >= %d => zero = %b", rs1_data, rs2_data, zero);

        $display("=== ALU Testbench Finished ===");
        $finish;
    end

endmodule
