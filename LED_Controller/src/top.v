`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:10:17 01/03/2020 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top (input wire RESET,
			input wire LATCH,
			input wire CLK,
			input wire DATA,
			input wire PATTERN,	
			output wire [24:0] LED
			);


parameter MSB = 8;

wire[MSB-1:0] buffer;
wire outNext;

shift_reg  #(MSB) sr0  (.reset(RESET),
                        .clk (CLK),
						.data (DATA),
                        .en (LATCH),
						.out (outNext),
                        .registers (buffer)
						);


reg [2:0] instruction;
reg [4:0] ledAddress;

reg [24:0] active;
reg [24:0] pattern;

assign LED[0] = active[0] == 1'b1 ? pattern[0] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[1] = active[1] == 1'b1 ? pattern[1] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[2] = active[2] == 1'b1 ? pattern[2] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[3] = active[3] == 1'b1 ? pattern[3] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[4] = active[4] == 1'b1 ? pattern[4] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[5] = active[5] == 1'b1 ? pattern[5] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[6] = active[6] == 1'b1 ? pattern[6] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[7] = active[7] == 1'b1 ? pattern[7] == 1'b1 ? PATTERN : 1'b1 : 1'b0;

assign LED[8] = active[8] == 1'b1 ? pattern[8] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[9] = active[9] == 1'b1 ? pattern[9] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[10] = active[10] == 1'b1 ? pattern[10] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[11] = active[11] == 1'b1 ? pattern[11] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[12] = active[12] == 1'b1 ? pattern[12] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[13] = active[13] == 1'b1 ? pattern[13] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[14] = active[14] == 1'b1 ? pattern[14] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[15] = active[15] == 1'b1 ? pattern[15] == 1'b1 ? PATTERN : 1'b1 : 1'b0;

assign LED[16] = active[16] == 1'b1 ? pattern[16] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[17] = active[17] == 1'b1 ? pattern[17] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[18] = active[18] == 1'b1 ? pattern[18] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[19] = active[19] == 1'b1 ? pattern[19] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[20] = active[20] == 1'b1 ? pattern[20] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[21] = active[21] == 1'b1 ? pattern[21] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[22] = active[22] == 1'b1 ? pattern[22] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[23] = active[23] == 1'b1 ? pattern[23] == 1'b1 ? PATTERN : 1'b1 : 1'b0;
assign LED[24] = active[24] == 1'b1 ? pattern[24] == 1'b1 ? PATTERN : 1'b1 : 1'b0;


always @*
begin

	if (RESET == 1'b0)
		active <= 8'b00000000;
		
	else if (LATCH == 1'b1) begin
		instruction <= buffer[MSB-1:5];
		ledAddress <= buffer[4:0];		

		case (ledAddress)
			0: 	case (instruction)
            		3'b0: active[0] <= 1'b0;
            		3'b1: begin active[0] <= 1'b1; pattern[0] <= 1'b0; end
            		3'b10: begin active[0] <= 1'b1; pattern[0] <= 1'b1; end
        		endcase
			1: 	case (instruction)
            		3'b0: active[1] <= 1'b0;
            		3'b1: begin active[1] <= 1'b1; pattern[1] <= 1'b0; end
            		3'b10: begin active[1] <= 1'b1; pattern[1] <= 1'b1; end
        		endcase
			2: 	case (instruction)
            		3'b0: active[2] <= 1'b0;
            		3'b1: begin active[2] <= 1'b1; pattern[2] <= 1'b0; end
            		3'b10: begin active[2] <= 1'b1; pattern[2] <= 1'b1; end
        		endcase
			3: 	case (instruction)
            		3'b0: active[3] <= 1'b0;
            		3'b1: begin active[3] <= 1'b1; pattern[3] <= 1'b0; end
            		3'b10: begin active[3] <= 1'b1; pattern[3] <= 1'b1; end
        		endcase
			4: 	case (instruction)
            		3'b0: active[4] <= 1'b0;
            		3'b1: begin active[4] <= 1'b1; pattern[4] <= 1'b0; end
            		3'b10: begin active[4] <= 1'b1; pattern[4] <= 1'b1; end
        		endcase
			5: 	case (instruction)
            		3'b0: active[5] <= 1'b0;
            		3'b1: begin active[5] <= 1'b1; pattern[5] <= 1'b0; end
            		3'b10: begin active[5] <= 1'b1; pattern[5] <= 1'b1; end
        		endcase
			6: 	case (instruction)
            		3'b0: active[6] <= 1'b0;
            		3'b1: begin active[6] <= 1'b1; pattern[6] <= 1'b0; end
            		3'b10: begin active[6] <= 1'b1; pattern[6] <= 1'b1; end
        		endcase
			7: 	case (instruction)
            		3'b0: active[7] <= 1'b0;
            		3'b1: begin active[7] <= 1'b1; pattern[7] <= 1'b0; end
            		3'b10: begin active[7] <= 1'b1; pattern[7] <= 1'b1; end
        		endcase
			8: 	case (instruction)
            		3'b0: active[8] <= 1'b0;
            		3'b1: begin active[8] <= 1'b1; pattern[8] <= 1'b0; end
            		3'b10: begin active[8] <= 1'b1; pattern[8] <= 1'b1; end
        		endcase
			9: 	case (instruction)
            		3'b0: active[9] <= 1'b0;
            		3'b1: begin active[9] <= 1'b1; pattern[9] <= 1'b0; end
            		3'b10: begin active[9] <= 1'b1; pattern[9] <= 1'b1; end
        		endcase
			10: case (instruction)
            		3'b0: active[10] <= 1'b0;
            		3'b1: begin active[10] <= 1'b1; pattern[10] <= 1'b0; end
            		3'b10: begin active[10] <= 1'b1; pattern[10] <= 1'b1; end
        		endcase
			11: case (instruction)
            		3'b0: active[11] <= 1'b0;
            		3'b1: begin active[11] <= 1'b1; pattern[11] <= 1'b0; end
            		3'b10: begin active[11] <= 1'b1; pattern[11] <= 1'b1; end
        		endcase
			12: case (instruction)
            		3'b0: active[12] <= 1'b0;
            		3'b1: begin active[12] <= 1'b1; pattern[12] <= 1'b0; end
            		3'b10: begin active[12] <= 1'b1; pattern[12] <= 1'b1; end
        		endcase
			13: case (instruction)
            		3'b0: active[13] <= 1'b0;
            		3'b1: begin active[13] <= 1'b1; pattern[13] <= 1'b0; end
            		3'b10: begin active[13] <= 1'b1; pattern[13] <= 1'b1; end
        		endcase
			14: case (instruction)
            		3'b0: active[14] <= 1'b0;
            		3'b1: begin active[14] <= 1'b1; pattern[14] <= 1'b0; end
            		3'b10: begin active[14] <= 1'b1; pattern[14] <= 1'b1; end
        		endcase	

		endcase
	end
	
end


endmodule
