`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: MAKinteract Lab KAIST
// Engineer: Andrea Bianchi
// 
// Create Date:    13:48:01 06/29/2020 
// Design Name: 
// Module Name:    ledCtrl 
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
module ledCtrl(input wire [1:0] state,
               output wire led,
               input wire ledOn,
               input wire pattern1,
               input wire pattern2
               );

    reg out;

    always @* begin
        case (state)
            3'b0: out <= 1'b0;
            3'b1: out <= ledOn;
            3'b10: out <= pattern1 & ledOn;
            3'b11: out <= pattern2 & ledOn;
        endcase
    end


    assign led= out;

endmodule
