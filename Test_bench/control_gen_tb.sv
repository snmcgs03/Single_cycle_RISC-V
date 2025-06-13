`timescale 1ns / 1ps

module control_gen_tb;

    // Inputs
    logic [6:0] opcode_out_d;

    // Outputs
    logic [1:0] U_control;

    // Instantiate the DUT
    control_gen dut (
        .opcode_out_d(opcode_out_d),
        .U_control(U_control)
    );

    initial begin
        $display("=== control_gen Testbench Started ===");

        // Test JAL
        opcode_out_d = 7'b1101111; #1;
        $display("JAL: opcode = %b -> U_control = %b", opcode_out_d, U_control);

        // Test LUI
        opcode_out_d = 7'b0110111; #1;
        $display("LUI: opcode = %b -> U_control = %b", opcode_out_d, U_control);

        // Test AUIPC
        opcode_out_d = 7'b0010111; #1;
        $display("AUIPC: opcode = %b -> U_control = %b", opcode_out_d, U_control);

        // Test default/invalid opcode
        opcode_out_d = 7'b1010100; #1;
        $display("Default: opcode = %b -> U_control = %b", opcode_out_d, U_control);

        $display("=== control_gen Testbench Finished ===");
        $finish;
    end

endmodule
