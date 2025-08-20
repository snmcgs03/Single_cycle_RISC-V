module program_counter 
(
    input logic [31:0] pc_next,
    input logic clk, reset,
    output logic [31:0] address
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            address <= 32'h00000000;
        else
            address <= pc_next;
    end

endmodule
