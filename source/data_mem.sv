module data_mem 
//#(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) 
(
    // Parameterized memory: ADDR_WIDTH = 12 means 2^12 = 4096 bytes, DATA_WIDTH = 32 for 32-bit word size
    input logic clk,                            // Clock signal
    input logic mem_write,                      // Control signal to enable write operation
    input logic mem_read,                       // Control signal to enable read operation
    input logic [31:0] addr,          // Address input (byte-addressable)
    input logic [31:0] write_data,    // 32-bit data to be written into memory
    output logic [31:0] read_data     // 32-bit data read from memory
);

    // Declare 4096 bytes of memory, each 8 bits wide (1 byte)
    logic [7:0] mem [0:4095];

    // Initialize memory contents from an external hex file at simulation start
    initial begin
        $readmemh("C:/Users/DELL/Desktop/RV32IM_modified/RV32IM_modified.srcs/sources_1/new/data.mem", mem);
    end

    // Write logic: On rising clock edge, if mem_write is high, write 32-bit data into memory
    always_ff @(posedge clk) begin
        if (mem_write) begin
            // Write 4 bytes in little-endian order (LSB at lowest address)
            mem[addr]     <= write_data[7:0];     // Byte 0 (least significant byte)
            mem[addr + 1] <= write_data[15:8];    // Byte 1
            mem[addr + 2] <= write_data[23:16];   // Byte 2
            mem[addr + 3] <= write_data[31:24];   // Byte 3 (most significant byte)
        end
    end

    // Read logic: On rising clock edge, if mem_read is high, read 32-bit data from memory
    always_ff @(posedge clk) begin
        if (mem_read) begin
            // Read 4 bytes from memory in little-endian order and combine into 32-bit word
            read_data <= {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
        end
    end

endmodule
