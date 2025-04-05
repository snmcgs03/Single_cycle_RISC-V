module decoder #(parameter N=32)(instruction,rs1,rs2,rd,opcode,fn3,imm,imm_uj,fn7_5,imm11_5);
input logic [31:0]instruction;
output logic [4:0]rs1,rs2,rd;
output logic [6:0]opcode,imm11_5;
output logic [2:0]fn3;
output logic [11:0]imm;
output logic [19:0]imm_uj;
output logic fn7_5;
//output logic fn7_1;
always_comb
begin
rd = 0;
fn3 = 0;
rs1 = 0;
rs2 = 0;
imm = 0;
imm_uj = 0;
imm11_5 = 0;
fn7_5 = 0;
//fn7_1 = 0;
opcode = instruction[6:0];

case(opcode)
    7'b0110011: //R-Type and M-Type
    begin
        rd = instruction[11:7];
        fn3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        fn7_5 = instruction[29];
       // fn7_1 = instruction[25];
    end
    7'b0010011: //I-Type
    begin
        rd = instruction[11:7];
        fn3 = instruction[14:12];
        rs1 = instruction[19:15];
        imm = instruction[31:20];
        imm11_5 = instruction[31:25];
    end
    7'b0000011: //load
    begin 
        rd = instruction[11:7];
        fn3 = instruction[14:12];
        rs1 = instruction[19:15];
        imm = instruction[31:20];
    end
    7'b0100011: //store
    begin
        fn3 = instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm = {instruction[31:25],instruction[11:7]};
    end
    7'b1100011: //B-Type
    begin
        fn3= instruction[14:12];
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        imm = {instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    end
    7'b1101111: //J-Type
    begin
        rd = instruction[11:7];
        imm_uj = {instruction[31],instruction[19:12],instruction[20],instruction[30:21]};
    end
    7'b0110111: //U-Type
    begin
        rd = instruction[11:7];
        imm_uj = {instruction[31:12]};
    end
    default:
    begin
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
