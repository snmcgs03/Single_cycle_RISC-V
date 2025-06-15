module imm_generator (
    input wire [11:0] imm_input,
    input wire [6:0] opcode,
    input wire [2:0] fn3,
    input wire [19:0] imm_input_uj,
    output reg [31:0] imm_output
);

    always @(*) 
    begin
        // Default value
        imm_output = 0;

        // Generate immediate based on opcode
        case (opcode)
            7'b1100011: // B-Type
                imm_output = {{20{imm_input[11]}}, imm_input} << 1;

            7'b1101111: // JAL-Type
                imm_output = {{12{imm_input_uj[19]}}, imm_input_uj} << 1;

            7'b0110111: // U-Type (LUI)
                imm_output = {imm_input_uj, 12'b0};

            7'b1100111: // JALR-Type
                imm_output = {{20{imm_input[11]}}, imm_input};

            7'b0010111: // U-Type (AUIPC)
                imm_output = {imm_input_uj, 12'b0};
                
            7'b0010011:
            begin // I-Type (immediate ALU ops)
                if (fn3 == 3'b001) 
                  begin // SLLI
                   imm_output = {27'b0, imm_input[4:0]};
                  end
                else if (fn3 == 3'b101) 
                begin
                    if (imm_input[11:5] == 7'b0000000) // SRLI
                        imm_output = {27'b0, imm_input[4:0]};
                    else if (imm_input[11:5] == 7'b0100000) // SRAI
                        imm_output = {27'b0, imm_input[4:0]};
                end
                else
                begin // Other immediate ALU ops (e.g., ADDI, ANDI, ORI, etc.)
                    imm_output = {{20{imm_input[11]}}, imm_input};
                end
            end

            default: // Default case
                imm_output = {{20{imm_input[11]}}, imm_input};
        endcase
    end

endmodule
