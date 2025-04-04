module main_control (
    input logic [6:0] opcode,
    output logic branch,
    output logic memread,
    output logic [1:0] memtoreg,
    output logic memwrite,
    output logic alusrc,
    output logic reg_write,
    output logic [2:0]aluop
);

always @(*) begin
    // Default values
    branch = 0;
    memread = 0;
    memtoreg = 2'b11; // Ensure this is initialized correctly
    memwrite = 0;
    alusrc = 0;
    reg_write = 0;
    aluop = 3'b000;

    case (opcode)
        7'b0110011: // R-type
        begin
            branch = 0;
            memread = 0;
            memtoreg = 2'b00;
            memwrite = 0;
            alusrc = 0;
            reg_write = 1;
            aluop = 3'b000;
        end

        7'b0010011: // I-type
        begin 
            branch = 0;
            memread = 0;
            memtoreg = 2'b00;
            memwrite = 0;
            alusrc = 1;
            reg_write = 1;
            aluop = 3'b001;
        end

        7'b0000011: // Load
        begin
            branch = 0;
            memread = 1;
            memtoreg = 2'b01; // Correctly set as a two-bit value
            memwrite = 0;
            alusrc = 1;
            reg_write = 1;
            aluop = 3'b010;
        end

        7'b0100011: // Store
        begin
            branch = 0;
            memread = 0;
            memtoreg = 2'b11; 
            memwrite=1; 
            alusrc = 1; 
            reg_write = 0; 
            aluop = 3'b011; 
        end

        7'b1100011: // Branch
        begin
            branch = 1; 
            memread = 0; 
            memtoreg = 2'b00; // Fixed from '2'b0' to '2'b00'
            memwrite = 0; 
            alusrc = 0; 
            reg_write = 0; 
            aluop = 3'b100; 
        end

        7'b1101111: // JAL
        begin
            branch = 0; 
            memread = 0; 
            memtoreg = 2'b10; 
            memwrite = 0; 
            alusrc = 1; 
            reg_write = 1; 
            aluop = 3'b101; 
        end

        // U-type instruction handling
        7'b0110111: 
        begin
            branch = 0; 
            memread = 0; 
            memtoreg = 2'b10; 
            memwrite = 0; 
            alusrc = 1; 
            reg_write = 1; 
            aluop = 3'b110; 
        end
        
        default: // Handle unspecified opcodes
        begin
             branch   = 'b0;  
             memread   = 'b0;  
             memtoreg = 'b11;  
             memwrite = 'b0;  
             alusrc   = 'b0;  
             reg_write = 'b0;  
             aluop    = 'b000;  
         end
    endcase
end

endmodule