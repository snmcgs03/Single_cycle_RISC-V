module mux31 (
    input wire [31:0] a,    // Input A
    input wire [31:0] b,    // Input B
    input wire [31:0] c,    // Input C
    input wire [1:0] cntrl,  // Control signal
    output reg [31:0] out   // Output
);

    // Combinational logic block for 3:1 MUX
    always @(*) begin
        case (cntrl)
            2'b00: out = a;  // Select input A
            2'b01: out = b;  // Select input B
            2'b10: out = c;  // Select input C
            default: out = {N{1'b0}}; // Default to 0
        endcase
    end

endmodule
