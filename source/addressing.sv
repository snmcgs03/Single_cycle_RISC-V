module addressing(fn3,out,mem_read,mem_write);
input logic [2:0]fn3;
output logic [1:0]out;
input logic mem_read,mem_write;

always_comb
begin
out = 2'b00;
if (mem_read|mem_write == 1)
begin
case(fn3)
3'b000:
out = 2'b01;
3'b001:
out = 2'b10;
3'b010:
out = 2'b11;
default: out = 2'b00;
endcase
end
end
endmodule
