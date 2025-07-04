module data_mem (
    input wire clk,
    input wire mem_write,
    input wire mem_read,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);

    reg [7:0] mem [0:1023];  // 1024 bytes (byte-addressable memory)

    // Write operation (on rising edge of clk)
    always @(posedge clk) begin
        if (mem_write) begin
            mem[addr]     <= write_data[7:0];
            mem[addr + 1] <= write_data[15:8];
            mem[addr + 2] <= write_data[23:16];
            mem[addr + 3] <= write_data[31:24];
        end
    end

    // Read operation (combinational)
    always @(*) begin
        if (mem_read) begin
            read_data = {
                mem[addr + 3],
                mem[addr + 2],
                mem[addr + 1],
                mem[addr]
            };
        end else begin
            read_data = 32'b0;
        end
    end

endmodule
