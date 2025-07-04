module instruction_mem (
    input wire clk,                   // Clock input
    input wire [31:0] address,        // Byte address input (usually PC)
    output reg [31:0] instruction     // 32-bit instruction output
);

    reg [7:0] mem [0:1023];           // 1024 bytes = 256 instructions

    // Clocked fetch with alignment and bounds check
    always @(posedge clk) begin
        if ((address[1:0] == 2'b00) && (address <= 32'd1020)) begin
            instruction <= { 
                mem[address + 3],
                mem[address + 2],
                mem[address + 1],
                mem[address + 0]
            };
        end else begin
            instruction <= 32'h00000000;  // Invalid access returns NOP
        end
    end

endmodule
