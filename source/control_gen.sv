module control_gen(opcode_out_d,U_control);
input logic [6:0]opcode_out_d;
output logic [1:0]U_control;

always_comb
begin
U_control = 2'b0;
case(opcode_out_d)
7'b1101111: //Jal
U_control = 2'b00;


7'b0110111: //lui
U_control = 2'b01;

7'b0010111: //auipc
U_control = 2'b10;

default: 
begin
U_control = 2'b0;
end
endcase
end
endmodule
