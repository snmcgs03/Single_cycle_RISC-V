module alu_control (
    input wire [2:0] alu_op,        // ALU operation code
    input wire [2:0] fn3,          // Function 3 bits
    input wire [6:0] imm11_5,      // Immediate 11:5 bits
    input wire fn7_5,              // Function 7, bit 5
    output reg [3:0] control_out   // ALU control output
);

    // Combinational logic block
    always @(*) begin
        // Default value for control_out
        control_out = 4'b0000;

        case (alu_op)
            3'b000: begin // R-Type
                if (fn3 == 3'b000 && fn7_5 == 1'b0)
                    control_out = 4'b0000; // add
                else if (fn3 == 3'b000 && fn7_5 == 1'b1)
                    control_out = 4'b0001; // subtract
                else if (fn3 == 3'b100)
                    control_out = 4'b0010; // xor
                else if (fn3 == 3'b110)
                    control_out = 4'b0011; // or
                else if (fn3 == 3'b111)
                    control_out = 4'b0100; // and
                else if (fn3 == 3'b001)
                    control_out = 4'b0101; // sll
                else if (fn3 == 3'b101 && fn7_5 == 1'b0)
                    control_out = 4'b0110; // srl
                else if (fn3 == 3'b101 && fn7_5 == 1'b1)
                    control_out = 4'b0111; // sra
                else if (fn3 == 3'b010)
                    control_out = 4'b1000; // slt
                else if (fn3 == 3'b011)
                    control_out = 4'b1001; // sltu
            end

            3'b001: begin // I-Type
                if (fn3 == 3'b000)
                    control_out = 4'b0000; // addi or jalr
                else if (fn3 == 3'b100)
                    control_out = 4'b0010; // xori
                else if (fn3 == 3'b110)
                    control_out = 4'b0011; // ori
                else if (fn3 == 3'b111)
                    control_out = 4'b0100; // andi
                else if (fn3 == 3'b001)
                    control_out = 4'b0101; // slli
                else if (fn3 == 3'b101 && imm11_5 == 7'h00)
                    control_out = 4'b0110; // srli
                else if (fn3 == 3'b101 && imm11_5 == 7'h20)
                    control_out = 4'b0111; // srai
                else if (fn3 == 3'b010)
                    control_out = 4'b1000; // slti
                else if (fn3 == 3'b011)
                    control_out = 4'b1001; // sltiu
            end

            3'b010: begin // Load
                control_out = 4'b0000; // Generic load operation for all fn3
            end

            3'b011: begin // S-Type
                control_out = 4'b0000; // Generic store operation for all fn3
            end

            3'b100: begin // B-Type
                if (fn3 == 3'b000)
                    control_out = 4'b1010; // beq
                else if (fn3 == 3'b001)
                    control_out = 4'b1011; // bne
                else if (fn3 == 3'b100)
                    control_out = 4'b1100; // blt
                else if (fn3 == 3'b101)
                    control_out = 4'b1101; // bge
                else if (fn3 == 3'b110)
                    control_out = 4'b1110; // bltu
                else if (fn3 == 3'b111)
                    control_out = 4'b1111; // bgeu
            end

            3'b101: begin // JAL and JALR
                control_out = 4'b0000; // jalr and jal 
            end

            default: control_out = 4'b0000; // Default case
        endcase
    end
endmodule
