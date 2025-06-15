module control_gen (
    input wire [6:0] opcode_out_d,    // Input opcode
    output reg [1:0] U_control        // Output control signal
);

    // Combinational logic for generating control signals
    always @(*) begin
        U_control = 2'b00; // Default value
        case (opcode_out_d)
            7'b1101111: // JAL and JALR
                U_control = 2'b00;
            7'b0110111: // LUI
                U_control = 2'b01;
            7'b0010111: // AUIPC
                U_control = 2'b10;
            default:
                U_control = 2'b00; // Default case
        endcase
    end

endmodule
