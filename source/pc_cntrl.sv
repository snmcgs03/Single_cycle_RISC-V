module pc_cntrl(opcode,and_out,pc_gen_out);
input logic [6:0]opcode;
input logic and_out;
output logic pc_gen_out;


always_comb
begin
pc_gen_out = 0;
case(opcode)
7'b1100011: //Branch
if(and_out == 1)
pc_gen_out = 1;

7'b1101111: //Jal
begin
pc_gen_out = 1;
end

default: 
pc_gen_out = 0;

endcase
end
endmodule

