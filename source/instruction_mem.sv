module instruction_mem 
//#(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32)
 (
    input logic clk, // Clock input
    input logic [31:0] address, // Address input (byte addressable)
    output logic [31:0] instruction // 32-bit instruction output
);
    // Byte-addressable memory: 1 KB = 1024 bytes
    logic [7:0] mem [0:1023];
    logic [31:0] temp_instr; // Temporary storage for fetched instruction

    initial begin
        // Load instructions from hex file into memory during simulation start
        $readmemh("C:/Users/DELL/Desktop/RV32IM_modified/RV32IM_modified.srcs/sources_1/new/instruction.mem", mem);
    end

    always_comb begin
        // Read 4 consecutive bytes in little-endian order and form a 32-bit instruction
        temp_instr = {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
    end

    always_ff @(posedge clk) begin
        // Update the instruction output on the positive edge of the clock
        instruction <= temp_instr;
    end
endmodule