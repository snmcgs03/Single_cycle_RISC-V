module and_gate (
    input wire zero,       // Input signal: Zero
    input wire branch,     // Input signal: Branch
    output reg and_out     // Output signal: AND operation result
);

    // Combinational logic for AND gate using always block
    always @(*) begin
        and_out = branch & zero;
    end

endmodule
