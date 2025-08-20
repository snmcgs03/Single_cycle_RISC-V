module instruction_mem (
    input  logic        clk,
    input  logic        reset,
    input  logic        write_en,   
    input  logic [31:0] address,
    input  logic [31:0] write_inst,
    output logic [31:0] instruction
);

    logic [7:0] mem [0:1023];

    // Sequential write, now conditional on write_en
    always_ff @(posedge clk) begin
//        if (reset && write_en) begin // This prevents the CPU from overwriting the program
          if (write_en) begin 
            if ((address <= 1020) && (address[1:0] == 2'b00)) begin
                mem[address + 0] <= write_inst[7:0];
                mem[address + 1] <= write_inst[15:8];
                mem[address + 2] <= write_inst[23:16];
                mem[address + 3] <= write_inst[31:24];
            end
        end
    end

    // Sequential read
    always_ff @(posedge clk) begin
        if (reset) begin
            instruction <= 32'h00000013; // NOP
        end
        else if ((address <= 1020) && (address[1:0] == 2'b00)) begin
            instruction <= { mem[address + 3], mem[address + 2], mem[address + 1], mem[address + 0] };
        end
        else begin
            instruction <= 32'h00000013; // NOP on invalid address
        end
    end

endmodule