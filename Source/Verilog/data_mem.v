module data_mem (
    input wire clk,                  // Clock input
    input wire mem_write,            // Memory write enable
    input wire mem_read,             // Memory read enable
    input wire [31:0] addr,          // Address input
    input wire [31:0] write_data,    // Data to write
    output reg [31:0] read_data      // Data read output
);

    reg [7:0] mem [0:255];           // 256 bytes of RAM

    // Write: 
    always @(posedge clk) begin
        if (mem_write) begin
            mem[addr]     <= write_data[7:0];
            mem[addr + 1] <= write_data[15:8];
            mem[addr + 2] <= write_data[23:16];
            mem[addr + 3] <= write_data[31:24];
        end
    end

    // Read: 
    always @(posedge clk) begin
        if (mem_read) begin
            read_data <= {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
        end
    end

endmodule
