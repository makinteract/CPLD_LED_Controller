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
			output wire [18:0] LED
			);

parameter MSB = 7;
parameter LED_TOT = 19;

// Shift-register 7 bits
wire[MSB-1:0] buffer;
shift_reg  #(MSB) sr0  (.reset(RESET),
                        .clk (CLK),
						.data (DATA),
                        .en (LATCH),
                        .registers (buffer)
						);

// Same
// dff d0(CLK, DATA, buffer[0]);
// dff d1(CLK, buffer[0], buffer[1]);
// dff d2(CLK, buffer[1], buffer[2]);
// dff d3(CLK, buffer[2], buffer[3]);
// dff d4(CLK, buffer[3], buffer[4]);
// dff d5(CLK, buffer[4], buffer[5]);
// dff d6(CLK, buffer[5], buffer[6]);



reg [LED_TOT-1:0] active;
reg [LED_TOT-1:0] pattern;
wire [LED_TOT-1:0] patternSignal;
reg [LED_TOT-1:0] out;

// 7 bits instructions
// reg [4:0] ledAddress;
// reg [1:0] instruction;



always @*
begin
	
	if (LATCH == 1'b1) begin
		// ledAddress <= buffer[4:0]; // 5 bits address
		// instruction <= buffer[MSB-1:5]; // 2 bits instructions

		case (buffer[4:0])  // led address
			0: begin  active[0] <= buffer[5]; pattern[0] <= buffer[6]; end
			1: begin  active[1] <= buffer[5]; pattern[1] <= buffer[6]; end
			2: begin  active[2] <= buffer[5]; pattern[2] <= buffer[6]; end
			3: begin  active[3] <= buffer[5]; pattern[3] <= buffer[6]; end
			4: begin  active[4] <= buffer[5]; pattern[4] <= buffer[6]; end
			5: begin  active[5] <= buffer[5]; pattern[5] <= buffer[6]; end
			6: begin  active[6] <= buffer[5]; pattern[6] <= buffer[6]; end
			7: begin  active[7] <= buffer[5]; pattern[7] <= buffer[6]; end
			8: begin  active[8] <= buffer[5]; pattern[8] <= buffer[6]; end
			9: begin  active[9] <= buffer[5]; pattern[9] <= buffer[6]; end
			10: begin  active[10] <= buffer[5]; pattern[10] <= buffer[6]; end
			11: begin  active[11] <= buffer[5]; pattern[11] <= buffer[6]; end
			12: begin  active[12] <= buffer[5]; pattern[12] <= buffer[6]; end
			13: begin  active[13] <= buffer[5]; pattern[13] <= buffer[6]; end
			14: begin  active[14] <= buffer[5]; pattern[14] <= buffer[6]; end
			15: begin  active[15] <= buffer[5]; pattern[15] <= buffer[6]; end
			16: begin  active[16] <= buffer[5]; pattern[16] <= buffer[6]; end
			17: begin  active[17] <= buffer[5]; pattern[17] <= buffer[6]; end
			18: begin  active[18] <= buffer[5]; pattern[18] <= buffer[6]; end
			// 19: begin  active[19] <= buffer[5]; pattern[19] <= buffer[6]; end
			// 20: begin  active[20] <= buffer[5]; pattern[20] <= buffer[6]; end
			// 21: begin  active[21] <= buffer[5]; pattern[21] <= buffer[6]; end
			// 22: begin  active[22] <= buffer[5]; pattern[22] <= buffer[6]; end
			// 23: begin  active[23] <= buffer[5]; pattern[23] <= buffer[6]; end
			// 24: begin  active[24] <= buffer[5]; pattern[24] <= buffer[6]; end
			
		endcase
	end
end

always @(PATTERN)
begin
	// led[0] <= pattern[0] ? PATTERN : active[0];
	// same as above
	out <= (pattern & patternSignal) | active;
end

assign patternSignal = {LED_TOT{PATTERN}};
assign LED = out;

endmodule
