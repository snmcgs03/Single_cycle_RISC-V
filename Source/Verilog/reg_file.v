module reg_file (
    input wire [4:0] rs1_sel, rs2_sel,
    input wire reg_write, clk, reset,
    input wire [31:0] wb_data,
    input wire [4:0] rd_sel,
    output reg [31:0] rs1_data, rs2_data
);
    reg [31:0] register [31:0];

    // Combinational read logic
    always @(*) begin
        rs1_data = register[rs1_sel];
        rs2_data = register[rs2_sel];
    end

    // Synchronous write and reset logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            register[0]  <= 32'h00000000; // x0 always 0
            register[1]  <= 32'h00000001;
            register[2]  <= 32'h00000002;
            register[3]  <= 32'h00000003;
            register[4]  <= 32'h00000004;
            register[5]  <= 32'h00000005;
            register[6]  <= 32'h00000006;
            register[7]  <= 32'h00000007;
            register[8]  <= 32'h00000008;
            register[9]  <= 32'h00000009;
            register[10] <= 32'h0000000A;
            register[11] <= 32'h0000000B;
            register[12] <= 32'h0000000C;
            register[13] <= 32'h0000000D;
            register[14] <= 32'h0000000E;
            register[15] <= 32'h0000000F;
            register[16] <= 32'h00000010;
            register[17] <= 32'h00000011;
            register[18] <= 32'h00000012;
            register[19] <= 32'h00000013;
            register[20] <= 32'h00000014;
            register[21] <= 32'h00000015;
            register[22] <= 32'h00000016;
            register[23] <= 32'h00000017;
            register[24] <= 32'h00000018;
            register[25] <= 32'h00000019;
            register[26] <= 32'h0000001A;
            register[27] <= 32'h0000001B;
            register[28] <= 32'h0000001C;
            register[29] <= 32'h0000001D;
            register[30] <= 32'h0000001E;
            register[31] <= 32'h0000001F;
        end else begin
            if ((rd_sel != 5'd0) && reg_write)
                register[rd_sel] <= wb_data;
        end
    end
endmodule
