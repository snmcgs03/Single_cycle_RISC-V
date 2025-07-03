module adder
(
    input logic [31:0] address, b,
    output logic [31:0] pc_new
);

always_comb
pc_new = address + b;

endmodule
