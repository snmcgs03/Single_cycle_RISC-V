module instruction_mem (
    input  logic         clk,         // Clock input
    input  logic [31:0]  address,     // Byte address input
    output logic [31:0]  instruction  // 32-bit instruction output
);
    // Parameters
    parameter MEM_SIZE = 1024;

    // Memory declaration (1KB byte-addressable)
    logic [7:0] mem [0:MEM_SIZE-1];
    logic [31:0] temp_instr; // Temporary instruction

    // Load memory from hex file at simulation start
    initial begin
        $readmemh("C:/Users/DELL/Desktop/reg_file/reg_file.srcs/sources_1/new/instruction.mem", mem);
    end

    // Combinational logic to fetch instruction (little-endian, with safety checks)
    always_comb begin
        if ((address[1:0] == 2'b00) && (address <= MEM_SIZE - 4)) begin
            temp_instr = {mem[address + 3], mem[address + 2], mem[address + 1], mem[address]};
        end else begin
            temp_instr = 32'h00000000; // Invalid instruction if unaligned or out-of-bounds
        end
    end

    // Synchronous output update on positive clock edge
    always_ff @(posedge clk) begin
        instruction <= temp_instr;
    end
endmodule
