module adder #(parameter N=32)
(
    input logic [N-1:0] address, b,
    output logic [N-1:0] pc_new
);

always_comb
pc_new = address + b;

endmodule
