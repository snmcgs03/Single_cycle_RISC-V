module instruction_mem (
    input wire clk,                    // Clock input
    input wire [31:0] address,         // Byte address input
    output reg [31:0] instruction      // 32-bit instruction output
);
    parameter MEM_SIZE = 256;

    reg [7:0] mem [0:MEM_SIZE-1];      // Byte-addressable memory
    reg [31:0] temp_instr;

    // Combinational fetch (little-endian)
    always @(*) begin
        if ((address[1:0] == 2'b00) && (address <= MEM_SIZE - 4)) begin
            temp_instr = {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
        end else begin
            temp_instr = 32'h00000000;
        end
    end

    // Sequential logic for instruction output
    always @(posedge clk) begin
        instruction <= temp_instr;
    end
endmodule
