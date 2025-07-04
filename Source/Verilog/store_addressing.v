module store_addressing (
    input wire [2:0] fn3,
    input wire [6:0] opcode,
    input wire [31:0] read_data,
    input wire [31:0] rs2_data,
    output reg [31:0] store_data
);

    always @(*) begin
        store_data = rs2_data; // default
        if (opcode == 7'b0100011) begin // store instruction
            case (fn3)
                3'b000: store_data = {read_data[31:8],  rs2_data[7:0]};    // SB
                3'b001: store_data = {read_data[31:16], rs2_data[15:0]};   // SH
                3'b010: store_data = rs2_data;                             // SW
                default: store_data = rs2_data;
            endcase
        end
    end

endmodule
