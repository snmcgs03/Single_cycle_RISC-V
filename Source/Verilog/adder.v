module adder (
    input wire [31:0] address, // Input address
    input wire [31:0] b,       // Input value to add
    output reg [31:0] pc_new   // Output new PC value
);

    always @(*) begin
        pc_new = address + b; // Combinational addition
    end

endmodule
