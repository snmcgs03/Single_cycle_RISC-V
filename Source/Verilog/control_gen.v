module control_gen (
    input wire [6:0] opcode_out_d,    // Input opcode
    output reg [1:0] U_control        // Output control signal
);

    // Combinational logic for generating control signals
    always @(*) begin
        case (opcode_out_d)
            7'b1101111: U_control = 2'b00; // JAL
            7'b1100111: U_control = 2'b00; // JALR
            7'b0110111: U_control = 2'b01; // LUI
            7'b0010111: U_control = 2'b10; // AUIPC
            default:    U_control = 2'b00;
        endcase
    end

endmodule
