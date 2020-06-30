`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:09:07 06/22/2020 
// Design Name: 
// Module Name:    dff 
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

module shift_reg  
	#(parameter MSB=8) 
	(  
      input reset,
      input clk,                    
		input data,         
      input en,                     // enable low
		output wire out,
      output reg [MSB-1:0] registers 
	);    
 
	assign out = registers[MSB-1];
	
   always @ (posedge clk)
	begin
         if (!reset)
            registers <= 0;
         else begin
            if (~en)
               registers <= {registers[MSB-2:0], data};
            else
               registers <= registers;
         end
   end
		
endmodule
 