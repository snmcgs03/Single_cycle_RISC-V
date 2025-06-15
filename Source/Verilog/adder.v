module adder #(parameter N = 32) (
    input wire [N-1:0] address, // Input address
    input wire [N-1:0] b,       // Input value to add
    output reg [N-1:0] pc_new   // Output new PC value
);

    always @(*) begin
        pc_new = address + b; // Combinational addition
    end

endmodule
