module alu (
    input wire [3:0] alu_control,       // ALU control signals
    input wire [31:0] rs1_data,         // Source register 1 data
    input wire [31:0] rs2_data,         // Source register 2 data
    output reg zero,                    // Zero flag
    output reg [31:0] alu_out           // ALU output
);

    wire signed [31:0] rss1_data;       // Signed version of rs1_data
    wire signed [31:0] rss2_data;       // Signed version of rs2_data

    // Assign signed inputs
    assign rss1_data = $signed(rs1_data);
    assign rss2_data = $signed(rs2_data);

    // Combinational logic for ALU operations
    always @(*) begin
        zero = 1'b0; // Default value for zero flag
        alu_out = 32'b0; // Default value for ALU output
        
        case (alu_control)
            4'b0000: alu_out = rss1_data + rss2_data;                     // ADD
            4'b0001: alu_out = rss1_data - rss2_data;                     // SUB
            4'b0010: alu_out = rss1_data ^ rss2_data;                     // XOR
            4'b0011: alu_out = rss1_data | rss2_data;                     // OR
            4'b0100: alu_out = rss1_data & rss2_data;                     // AND
            4'b0101: alu_out = rss1_data << rss2_data[4:0];               // SLL
            4'b0110: alu_out = rss1_data >> rss2_data[4:0];               // SRL
            4'b0111: alu_out = rss1_data >>> rss2_data[4:0];              // SRA
            4'b1000: alu_out = (rss1_data < rss2_data) ? 32'h1 : 32'h0;   // SLT
            4'b1001: alu_out = (rs1_data < rs2_data) ? 32'h1 : 32'h0;     // SLTU
            4'b1010: zero = (rss1_data == rss2_data) ? 1'b1 : 1'b0;       // BEQ
            4'b1011: zero = (rss1_data != rss2_data) ? 1'b1 : 1'b0;       // BNE
            4'b1100: zero = (rss1_data < rss2_data) ? 1'b1 : 1'b0;        // BLT
            4'b1101: zero = (rss1_data >= rss2_data) ? 1'b1 : 1'b0;       // BGE
            4'b1110: zero = (rs1_data < rs2_data) ? 1'b1 : 1'b0;          // BLTU
            4'b1111: zero = (rs1_data >= rs2_data) ? 1'b1 : 1'b0;         // BGEU
            default: begin
                alu_out = 32'b0; // Default ALU output
                zero = 1'b0;     // Default zero flag
            end
        endcase
    end

endmodule

