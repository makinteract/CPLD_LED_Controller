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
	(  input reset,
      input clk,                    
		input data,         
      input en,                     // enable low
      output reg [MSB-1:0] registers 
	);    
 	
   always @ (posedge clk)
	begin
      if (!reset)
         registers <= 0;
      else
         if (~en)
            registers <= {registers[MSB-2:0], data}; // MSBFIRST 
            //registers <= {data, registers[MSB-1:1]};
         else
            registers <= registers;
   end
		
endmodule
 
