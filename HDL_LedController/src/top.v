`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MAKinteract Lab KAIST
// Engineer: Andrea Bianchi
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
			input wire PATTERN_555,
			input wire PWM,	
			output wire [19:0] LED
			);


parameter MSB = 8;

wire[MSB-1:0] buffer;

shift_reg  #(MSB) sr0  (.reset(RESET),
						.clk (CLK),
						.data (DATA),
                        .en (LATCH),
                        .registers (buffer)
						);


wire [2:0] instruction;
wire [4:0] ledAddress;

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


assign instruction = buffer[MSB-1:5];
assign ledAddress = buffer[4:0];	


// half of pattern1
reg half_pattern;
reg temp;

always @(posedge PATTERN_555)
	temp <= ~temp;

always @(posedge temp)
	half_pattern <= ~half_pattern;



always @*
begin
	
	if (LATCH == 1'b1) begin
	
		case (ledAddress)
			0: led0 <= instruction;
			1: led1 <= instruction;
			2: led2 <= instruction;
			3: led3 <= instruction;
			4: led4 <= instruction;
			5: led5 <= instruction;
			6: led6 <= instruction;
			7: led7 <= instruction;

			8: led8 <= instruction;
			9: led9 <= instruction;
			10: led10 <= instruction;
			11: led11 <= instruction;
			12: led12 <= instruction;
			13: led13 <= instruction;
			14: led14 <= instruction;
			15: led15 <= instruction;

			16: led16 <= instruction;
			17: led17 <= instruction;
			18: led18 <= instruction;
			19: led19 <= instruction;

		endcase
	end
end


ledCtrl lc0 (.state(led0),
            .led(LED[0]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc1 (.state(led1),
            .led(LED[1]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc2 (.state(led2),
            .led(LED[2]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc3 (.state(led3),
            .led(LED[3]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc4 (.state(led4),
            .led(LED[4]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc5 (.state(led5),
            .led(LED[5]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc6 (.state(led6),
            .led(LED[6]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc7 (.state(led7),
            .led(LED[7]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc8 (.state(led8),
            .led(LED[8]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc9 (.state(led9),
            .led(LED[9]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc10 (.state(led10),
            .led(LED[10]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc11 (.state(led11),
            .led(LED[11]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc12 (.state(led12),
            .led(LED[12]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc13 (.state(led13),
            .led(LED[13]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc14 (.state(led14),
            .led(LED[14]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc15 (.state(led15),
            .led(LED[15]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc16 (.state(led16),
            .led(LED[16]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc17 (.state(led17),
            .led(LED[17]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc18 (.state(led18),
            .led(LED[18]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);

ledCtrl lc19 (.state(led19),
            .led(LED[19]),
            .ledOn(PWM),
			.pattern1 (PATTERN_555),
			.pattern2 (half_pattern)
			);


endmodule