module memory_stage (alu_out, mem_read, mem_write, data_in, mem_out,mem_by_in);
input logic [31:0] alu_out, data_in;
output logic [31:0] mem_out;
input logic mem_read, mem_write;
input logic [1:0]mem_by_in;
reg [7:0]mem[0:1023];  

initial 
begin
$readmemh("C:/Users/Lenovo/OneDrive/Desktop/single_cycle_riscv/memory.data", mem);
end


always @(*)
begin
if(mem_write)
begin
if(mem_by_in == 2'b01)  //byte
mem[alu_out] <= data_in[7:0];
if(mem_by_in == 2'b10)  //half
{mem[alu_out+1],mem[alu_out]} <= data_in[15:0];
if(mem_by_in == 2'b11)  //word
{mem[alu_out+3],mem[alu_out+2],mem[alu_out+1],mem_out[alu_out]}<= data_in;
end


if(mem_read)
begin
mem_out = 0;
case(mem_by_in)
2'b01:  //byte
mem_out = mem_read? {24'b0,mem[alu_out]}:0;
2'b10:  //half-word
mem_out = mem_read? {16'b0,mem[alu_out+1],mem[alu_out]}:0;
2'b11:  //word
mem_out = mem_read? {mem[alu_out+3],mem[alu_out+2],mem[alu_out+1],mem[alu_out]}:0;
default:
mem_out = 0;
endcase
end
end

endmodule
