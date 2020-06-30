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
			output wire [22:0] LED
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

reg [2:0] led0;
reg [2:0] led1;
reg [2:0] led2;
reg [2:0] led3;
reg [2:0] led4;
reg [2:0] led5;
reg [2:0] led6;
reg [2:0] led7;
reg [2:0] led8;
reg [2:0] led9;
reg [2:0] led10;
reg [2:0] led11;
reg [2:0] led12;
reg [2:0] led13;
reg [2:0] led14;
reg [2:0] led15;
reg [2:0] led16;
reg [2:0] led17;
reg [2:0] led18;
reg [2:0] led19;
reg [2:0] led20;
reg [2:0] led21;
reg [2:0] led22;
// reg [2:0] led23;
// reg [2:0] led24;



always @*
begin
	
	if (LATCH == 1'b1) begin
		instruction <= buffer[MSB-1:5];
		ledAddress <= buffer[4:0];		

		case (ledAddress)
			0: led0 <= instruction;
			1: led1 <= instruction;
			2: led2 <= instruction;
			3: led3 <= instruction;
			4: led4 <= instruction;
			5: led5 <= instruction;
			6: led6 <= instruction;
			7: led7 <= instruction;
		endcase
	end
end


ledCtrl lc0 (.state(led0),
            .led(LED[0]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc1 (.state(led1),
            .led(LED[1]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc2 (.state(led2),
            .led(LED[2]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc3 (.state(led3),
            .led(LED[3]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc4 (.state(led4),
            .led(LED[4]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc5 (.state(led5),
            .led(LED[5]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc6 (.state(led6),
            .led(LED[6]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc7 (.state(led7),
            .led(LED[7]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc8 (.state(led8),
            .led(LED[8]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc9 (.state(led9),
            .led(LED[9]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc10 (.state(led10),
            .led(LED[10]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc11 (.state(led11),
            .led(LED[11]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc12 (.state(led12),
            .led(LED[12]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc13 (.state(led13),
            .led(LED[13]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc14 (.state(led14),
            .led(LED[14]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc15 (.state(led15),
            .led(LED[15]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc16 (.state(led16),
            .led(LED[16]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc17 (.state(led17),
            .led(LED[17]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc18 (.state(led18),
            .led(LED[18]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc19 (.state(led19),
            .led(LED[19]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl l20 (.state(led20),
            .led(LED[20]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc21 (.state(led21),
            .led(LED[21]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

ledCtrl lc22 (.state(led22),
            .led(LED[22]),
            .pattern1 (PATTERN),
			.pattern2 (PATTERN)
			);

// ledCtrl lc23 (.state(led23),
//             .led(LED[23]),
//             .pattern1 (PATTERN),
// 			.pattern2 (PATTERN)
// 			);

// ledCtrl lc24 (.state(led24),
//             .led(LED[24]),
//             .pattern1 (PATTERN),
// 			.pattern2 (PATTERN)
// 			);

endmodule