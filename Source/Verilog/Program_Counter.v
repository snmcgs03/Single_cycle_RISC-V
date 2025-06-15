module Program_Counter (
    input wire [31:0] pc_next,   // Next PC value
    input wire clk,             // Clock signal
    input wire reset,           // Reset signal
    output reg [31:0] address   // Current PC value
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            address <= 32'b0;    // Reset PC to 0
        else
            address <= pc_next;  // Update PC with next value
    end

endmodule

