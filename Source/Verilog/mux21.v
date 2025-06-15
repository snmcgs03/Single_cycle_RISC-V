module mux21 (
    input wire [31:0] a,        // Input A
    input wire [31:0] b,        // Input B
    input wire control,         // Control Signal
    output reg [31:0] y         // Output Y
);

    // Combinational logic for 2:1 MUX
    always @(*) begin
        if (control == 1'b1) begin
            y = b; // Select input B
        end else begin
            y = a; // Select input A
        end
    end

endmodule
