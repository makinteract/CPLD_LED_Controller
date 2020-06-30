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
			output wire [15:0] LED
			);

parameter MSB = 7;

wire[MSB-1:0] buffer;

/*shift_reg  #(MSB) sr0  (.reset(RESET),
                        .clk (CLK),
						.data (DATA),
                        .en (LATCH),
                        .registers (buffer)
						);*/

dff d0(CLK, DATA, buffer[0]);
dff d1(CLK, buffer[0], buffer[1]);
dff d2(CLK, buffer[1], buffer[2]);
dff d3(CLK, buffer[2], buffer[3]);
dff d4(CLK, buffer[3], buffer[4]);
dff d5(CLK, buffer[4], buffer[5]);
dff d6(CLK, buffer[5], buffer[6]);

assign LED = buffer;

/*
reg [15:0] active;
reg [15:0] pattern;
wire [15:0] patternSignal;
reg [15:0] out;

// 7 bits instructions
reg [4:0] ledAddress;
reg [1:0] instruction;



always @*
begin
	
	if (LATCH == 1'b1) begin
		ledAddress <= buffer[4:0]; // 5 bits address
		instruction <= buffer[MSB-1:5]; // 2 bits instructions

		case (ledAddress)  // led address
			0: begin  active[0] <= instruction[0]; pattern[0] <= instruction[1]; end
			1: begin  active[1] <= instruction[0]; pattern[1] <= instruction[1]; end
			2: begin  active[2] <= instruction[0]; pattern[2] <= instruction[1]; end
			3: begin  active[3] <= instruction[0]; pattern[3] <= instruction[1]; end
			4: begin  active[4] <= instruction[0]; pattern[4] <= instruction[1]; end
			5: begin  active[5] <= instruction[0]; pattern[5] <= instruction[1]; end
			6: begin  active[6] <= instruction[0]; pattern[6] <= instruction[1]; end
			7: begin  active[7] <= instruction[0]; pattern[7] <= instruction[1]; end
			8: begin  active[8] <= instruction[0]; pattern[8] <= instruction[1]; end
			9: begin  active[9] <= instruction[0]; pattern[9] <= instruction[1]; end
			10: begin  active[10] <= instruction[0]; pattern[10] <= instruction[1]; end
			11: begin  active[11] <= instruction[0]; pattern[11] <= instruction[1]; end
			12: begin  active[12] <= instruction[0]; pattern[12] <= instruction[1]; end
			13: begin  active[13] <= instruction[0]; pattern[13] <= instruction[1]; end
			14: begin  active[14] <= instruction[0]; pattern[14] <= instruction[1]; end
			15: begin  active[15] <= instruction[0]; pattern[15] <= instruction[1]; end
			// 16: begin  active[16] <= instruction[0]; pattern[16] <= instruction[1]; end
			// 17: begin  active[17] <= instruction[0]; pattern[17] <= instruction[1]; end
			// 18: begin  active[18] <= instruction[0]; pattern[18] <= instruction[1]; end
			// 19: begin  active[19] <= instruction[0]; pattern[19] <= instruction[1]; end
			// 20: begin  active[20] <= instruction[0]; pattern[20] <= instruction[1]; end
			// 21: begin  active[21] <= instruction[0]; pattern[21] <= instruction[1]; end
			// 22: begin  active[22] <= instruction[0]; pattern[22] <= instruction[1]; end
			// 23: begin  active[23] <= instruction[0]; pattern[23] <= instruction[1]; end
			// 24: begin  active[24] <= instruction[0]; pattern[24] <= instruction[1]; end
			
		endcase
	end
end

always @(PATTERN)
begin
	// led[0] <= pattern[0] ? PATTERN : active[0];
	// same as above
	out <= (pattern & patternSignal) | active;
end

assign patternSignal = {16{PATTERN}};
assign LED = out;
*/
endmodule
