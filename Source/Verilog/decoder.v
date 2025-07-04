module decoder (
    input wire [31:0] instruction,
    output reg [4:0] rs1, rs2, rd,
    output reg [6:0] opcode, imm11_5,
    output reg [2:0] fn3,
    output reg [11:0] imm,
    output reg [19:0] imm_uj,
    output reg fn7_5
);

    always @(*) begin
        // Default values
        rd = 0;
        fn3 = 0;
        rs1 = 0;
        rs2 = 0;
        imm = 0;
        imm_uj = 0;
        imm11_5 = 0;
        fn7_5 = 0;
        opcode = instruction[6:0];

        // Decode based on opcode
        case (opcode)
            7'b0110011: // R-Type
            begin
                rd = instruction[11:7];
                fn3 = instruction[14:12];
                rs1 = instruction[19:15];
                rs2 = instruction[24:20];
                fn7_5 = instruction[30];
            end
            7'b0010011: // I-Type
            begin
                rd = instruction[11:7];
                fn3 = instruction[14:12];
                rs1 = instruction[19:15];
                imm = instruction[31:20];
                imm11_5 = instruction[31:25];
            end
            7'b0000011: // Load
            begin
                rd = instruction[11:7];
                fn3 = instruction[14:12];
                rs1 = instruction[19:15];
                imm = instruction[31:20];
            end
            7'b0100011: // Store
            begin
                fn3 = instruction[14:12];
                rs1 = instruction[19:15];
                rs2 = instruction[24:20];
                imm = {instruction[31:25], instruction[11:7]};
            end
            7'b1100011: // B-Type
            begin
                fn3 = instruction[14:12];
                rs1 = instruction[19:15];
                rs2 = instruction[24:20];
                imm = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
            end
            7'b1101111: // J-Type (JAL)
            begin
                rd = instruction[11:7];
                imm_uj = {instruction[31], instruction[19:12], instruction[20], instruction[30:21]};
            end
            7'b0110111: // U-Type (LUI)
            begin
                rd = instruction[11:7];
                imm_uj = instruction[31:12];
            end
            7'b1100111: // J-Type (JALR)
            begin
                rd = instruction[11:7];
                rs1 = instruction[19:15];
                fn3 = instruction[14:12]; // Should be 000
                imm = instruction[31:20]; // 12-bit signed immediate
            end
            7'b0010111: // U-Type (AUIPC)
            begin
                rd = instruction[11:7];
                imm_uj = instruction[31:12]; // Upper 20 bits
            end
            default:
            begin
                // Default values for invalid opcodes
                rd = 0;
                fn3 = 0;
                rs1 = 0;
                rs2 = 0;
                imm = 0;
                imm_uj = 0;
                imm11_5 = 0;
                fn7_5 = 0;
                opcode = instruction[6:0];
            end
        endcase
    end

endmodule
