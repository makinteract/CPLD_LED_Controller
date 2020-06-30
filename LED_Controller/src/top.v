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
                        .registers (buffer)
						);




reg [1:0] led0;
reg [1:0] led1;
reg [1:0] led2;
reg [1:0] led3;
reg [1:0] led4;
reg [1:0] led5;
reg [1:0] led6;
reg [1:0] led7;
reg [1:0] led8;
reg [1:0] led9;
reg [1:0] led10;
reg [1:0] led11;
reg [1:0] led12;
reg [1:0] led13;
reg [1:0] led14;
reg [1:0] led15;
reg [1:0] led16;
reg [1:0] led17;
reg [1:0] led18;
reg [1:0] led19;
// reg [1:0] led20;
// reg [1:0] led21;
// reg [1:0] led22;
// reg [1:0] led23;
// reg [1:0] led24;



always @*
begin
	
	if (LATCH == 1'b1) begin

		case (buffer[5:0])  // address
			0: led0 <= buffer[MSB-1:6];  // instruction
			1: led1 <= buffer[MSB-1:6];
			2: led2 <= buffer[MSB-1:6];
			3: led3 <= buffer[MSB-1:6];
			4: led4 <= buffer[MSB-1:6];
			5: led5 <= buffer[MSB-1:6];
			6: led6 <= buffer[MSB-1:6];
			7: led7 <= buffer[MSB-1:6];
			8: led8 <= buffer[MSB-1:6];
			9: led9 <= buffer[MSB-1:6];
			10: led10 <= buffer[MSB-1:6];
			11: led11 <= buffer[MSB-1:6];
			12: led12 <= buffer[MSB-1:6];
			13: led13 <= buffer[MSB-1:6];
			14: led14 <= buffer[MSB-1:6];
			15: led15 <= buffer[MSB-1:6];
			16: led16 <= buffer[MSB-1:6];
			17: led17 <= buffer[MSB-1:6];
			18: led18 <= buffer[MSB-1:6];
			19: led19 <= buffer[MSB-1:6];
			// 20: led20 <= buffer[MSB-1:6];
			// 21: led21 <= buffer[MSB-1:6];
			// 22: led22 <= buffer[MSB-1:6];
			// 23: led23 <= buffer[MSB-1:6];
			// 24: led24 <= buffer[MSB-1:6];
		endcase
	end
end


ledCtrl lc0 (.state(led0),
            .led(LED[0]),
            .pattern1 (PATTERN)
			);

ledCtrl lc1 (.state(led1),
            .led(LED[1]),
            .pattern1 (PATTERN)
			);

ledCtrl lc2 (.state(led2),
            .led(LED[2]),
            .pattern1 (PATTERN)
			);

ledCtrl lc3 (.state(led3),
            .led(LED[3]),
            .pattern1 (PATTERN)
			);

ledCtrl lc4 (.state(led4),
            .led(LED[4]),
            .pattern1 (PATTERN)
			);

ledCtrl lc5 (.state(led5),
            .led(LED[5]),
            .pattern1 (PATTERN)
			);

ledCtrl lc6 (.state(led6),
            .led(LED[6]),
            .pattern1 (PATTERN)
			);

ledCtrl lc7 (.state(led7),
            .led(LED[7]),
            .pattern1 (PATTERN)
			);

ledCtrl lc8 (.state(led8),
            .led(LED[8]),
            .pattern1 (PATTERN)
			);

ledCtrl lc9 (.state(led9),
            .led(LED[9]),
            .pattern1 (PATTERN)
			);

ledCtrl lc10 (.state(led10),
            .led(LED[10]),
            .pattern1 (PATTERN)
			);

ledCtrl lc11 (.state(led11),
            .led(LED[11]),
            .pattern1 (PATTERN)
			);

ledCtrl lc12 (.state(led12),
            .led(LED[12]),
            .pattern1 (PATTERN)
			);

ledCtrl lc13 (.state(led13),
            .led(LED[13]),
            .pattern1 (PATTERN)
			);

ledCtrl lc14 (.state(led14),
            .led(LED[14]),
            .pattern1 (PATTERN)
			);

ledCtrl lc15 (.state(led15),
            .led(LED[15]),
            .pattern1 (PATTERN)
			);

ledCtrl lc16 (.state(led16),
            .led(LED[16]),
            .pattern1 (PATTERN)
			);

ledCtrl lc17 (.state(led17),
            .led(LED[17]),
            .pattern1 (PATTERN)
			);

ledCtrl lc18 (.state(led18),
            .led(LED[18]),
            .pattern1 (PATTERN)
			);

ledCtrl lc19 (.state(led19),
            .led(LED[19]),
            .pattern1 (PATTERN)
			);

// ledCtrl l20 (.state(led20),
//             .led(LED[20]),
//             .pattern1 (PATTERN)
// 			);

// ledCtrl lc21 (.state(led21),
//             .led(LED[21]),
//             .pattern1 (PATTERN)
// 			);

// ledCtrl lc22 (.state(led22),
//             .led(LED[22]),
//             .pattern1 (PATTERN)
// 			);

// ledCtrl lc23 (.state(led23),
//             .led(LED[23]),
//             .pattern1 (PATTERN)
// 			);

// ledCtrl lc24 (.state(led24),
//             .led(LED[24]),
//             .pattern1 (PATTERN)
// 			);

endmodule
