module main_control (
    input [6:0] opcode,
    output reg branch,
    output reg mux_inp,
    output reg memread,
    output reg [1:0] memtoreg,
    output reg memwrite,
    output reg alusrc,
    output reg reg_write,
    output reg [2:0] aluop
);

always @(*) begin
    // Default values
    branch   = 1'b0;
    memread  = 1'b0;
    memtoreg = 2'b11; // Default: No memory operation
    memwrite = 1'b0;
    alusrc   = 1'b0;
    reg_write = 1'b0;
    aluop    = 3'b000; // Default: No operation
    mux_inp  = 1'b0;

    case (opcode)
        // R-Type: ALU operations
        7'b0110011: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b00;
            memwrite = 1'b0;
            alusrc   = 1'b0;
            reg_write = 1'b1;
            aluop    = 3'b000;
            mux_inp  = 1'b0;
        end

        // I-Type: Immediate ALU operations
        7'b0010011: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b00;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b001;
            mux_inp  = 1'b0;
        end

        // Load instructions
        7'b0000011: begin
            branch   = 1'b0;
            memread  = 1'b1;
            memtoreg = 2'b01;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b010;
            mux_inp  = 1'b0;
        end

        // Store instructions
        7'b0100011: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b11;
            memwrite = 1'b1;
            alusrc   = 1'b1;
            reg_write = 1'b0;
            aluop    = 3'b011;
            mux_inp  = 1'b0;
        end

        // Branch instructions
        7'b1100011: begin
            branch   = 1'b1;
            memread  = 1'b0;
            memtoreg = 2'b00;
            memwrite = 1'b0;
            alusrc   = 1'b0;
            reg_write = 1'b0;
            aluop    = 3'b100;
            mux_inp  = 1'b0;
        end

        // JAL: Jump and Link
        7'b1101111: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b10;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b101;
            mux_inp  = 1'b0;
        end

        // JALR: Jump and Link Register
        7'b1100111: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b10;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b001;
            mux_inp  = 1'b1;
        end

        // U-Type: LUI (Load Upper Immediate)
        7'b0110111: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b10;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b110;
            mux_inp  = 1'b0;
        end

        // U-Type: AUIPC (Add Upper Immediate to PC)
        7'b0010111: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b10;
            memwrite = 1'b0;
            alusrc   = 1'b1;
            reg_write = 1'b1;
            aluop    = 3'b000;
            mux_inp  = 1'b0;
        end

        // Default: For unsupported instructions
        default: begin
            branch   = 1'b0;
            memread  = 1'b0;
            memtoreg = 2'b11;
            memwrite = 1'b0;
            alusrc   = 1'b0;
            reg_write = 1'b0;
            aluop    = 3'b000;
            mux_inp  = 1'b0;
        end
    endcase
end

endmodule
