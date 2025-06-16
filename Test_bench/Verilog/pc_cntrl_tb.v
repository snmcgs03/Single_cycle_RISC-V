`timescale 1ns / 1ps

module pc_cntrl_tb;

    // Testbench signals
    reg [6:0] opcode;
    reg and_out;
    wire pc_gen_out;

    // Instantiate the pc_cntrl module
    pc_cntrl uut (
        .opcode(opcode),
        .and_out(and_out),
        .pc_gen_out(pc_gen_out)
    );

    // Task to apply inputs and display result
    task apply_test(input [6:0] t_opcode, input t_and_out);
        begin
            opcode = t_opcode;
            and_out = t_and_out;
            #1; // Wait for combinational logic to evaluate
            $display("Opcode = %b | and_out = %b | pc_gen_out = %b", opcode, and_out, pc_gen_out);
        end
    endtask

    initial begin
        $display("=== Starting pc_cntrl Testbench ===");

        // Branch instruction with and_out = 1
        apply_test(7'b1100011, 1);

        // Branch instruction with and_out = 0
        apply_test(7'b1100011, 0);

        // JAL instruction
        apply_test(7'b1101111, 0);

        // Some other opcode
        apply_test(7'b0000011, 0);

        apply_test(7'b0110011, 1);

        $display("=== Testbench Finished ===");
        $finish;
    end

endmodule

