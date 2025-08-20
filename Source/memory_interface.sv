`timescale 1ns/1ps

module memory_interface (
    // --- CPU-facing Ports ---
    input  logic [6:0]   opcode,
    input  logic [2:0]   fn3,
    input  logic [31:0]  cpu_store_data,
    output logic [31:0]  cpu_writeback_data,

    // --- Memory-facing Ports ---
    input  logic [1:0]   addr_lsb,
    input  logic [31:0]  mem_read_data,
    output logic [3:0]   byte_enable,
    output logic [31:0]  mem_write_data
);

    assign mem_write_data = cpu_store_data;

    // Store Logic: Generate Byte Enables
    always_comb begin
        byte_enable = 4'b0000;
        if (opcode == 7'b0100011) begin // Store instructions
            case (fn3)
                3'b010: byte_enable = 4'b1111; // SW
                3'b001: begin // SH
                    case (addr_lsb)
                        2'b00:   byte_enable = 4'b0011;
                        2'b10:   byte_enable = 4'b1100;
                        default: byte_enable = 4'b0000;
                    endcase
                end
                3'b000: begin // SB
                    case (addr_lsb)
                        2'b00:   byte_enable = 4'b0001;
                        2'b01:   byte_enable = 4'b0010;
                        2'b10:   byte_enable = 4'b0100;
                        2'b11:   byte_enable = 4'b1000;
                        default: byte_enable = 4'b0000;
                    endcase
                end
                default: byte_enable = 4'b0000;
            endcase
        end
    end

    // Load Logic: Select and Extend Data
    logic [15:0] selected_halfword;
    logic [7:0]  selected_byte;
    always_comb begin
        selected_byte     = 8'dx;
        selected_halfword = 16'dx;

        case (addr_lsb)
            2'b00: begin selected_byte = mem_read_data[7:0];  selected_halfword = mem_read_data[15:0]; end
            2'b01: begin selected_byte = mem_read_data[15:8]; /* halfword unaligned */                  end
            2'b10: begin selected_byte = mem_read_data[23:16]; selected_halfword = mem_read_data[31:16]; end
            2'b11: begin selected_byte = mem_read_data[31:24]; /* halfword unaligned */                  end
        endcase

        cpu_writeback_data = 32'b0;
        if (opcode == 7'b0000011) begin // Load instructions
            case (fn3)
                3'b000: cpu_writeback_data = {{24{selected_byte[7]}}, selected_byte};       // LB
                3'b001: cpu_writeback_data = {{16{selected_halfword[15]}}, selected_halfword}; // LH
                3'b010: cpu_writeback_data = mem_read_data;                                  // LW
                3'b100: cpu_writeback_data = {{24{1'b0}}, selected_byte};                     // LBU
                3'b101: cpu_writeback_data = {{16{1'b0}}, selected_halfword};                 // LHU
                default: cpu_writeback_data = 32'b0;
            endcase
        end
    end
endmodule