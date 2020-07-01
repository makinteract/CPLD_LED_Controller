#include <Arduino.h>
#include <MsTimer2.h>

//Pin connected to ST_CP of 74HC595
int latchPin = 8;
//Pin connected to SH_CP of 74HC595
int clockPin = 12;
////Pin connected to DS of 74HC595
int dataPin = 11;

boolean on = true;
const int led_pin = 6; // 1.0 built in LED pin var


enum LED_State { ON, OFF, BLINK, BLINK2 };


void flash();
void sendCommand (uint8_t ledNumber, LED_State state);


void setup()
{
  pinMode(led_pin, OUTPUT);

  MsTimer2::set(100, flash); // 500ms period
  MsTimer2::start();

  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);


  sendCommand (0, BLINK);
  sendCommand (1, BLINK);
  sendCommand (2, BLINK);
  sendCommand (3, OFF);
  sendCommand (4, OFF);
  sendCommand (5, ON);
  sendCommand (6, ON);
  sendCommand (7, BLINK2);
}

void loop()
{
  
  delay(1000);
}

void flash()
{
  static boolean output = HIGH;

  digitalWrite(led_pin, output);
  output = !output;
}

void sendCommand (uint8_t ledNumber, LED_State state)
{
  byte op = 0;
  switch (state)
  {
    case OFF: op= 0; break;   // 00
    case ON: op= 1; break;    // 01
    case BLINK: op= 2; break; // 10
    case BLINK2: op= 3; break; // 11
  }

  digitalWrite(latchPin, LOW);
  shiftOut(dataPin, clockPin, MSBFIRST, ledNumber | (op << 5 ));
  digitalWrite(latchPin, HIGH);

}


/*
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
module top(	input wire CLK,
				input wire S_IN,
				output wire S_OUT,
				input wire LATCH,
				output wire [7:0] LED
				);

parameter MSB = 16;


wire[MSB-1:0] buffer;

shift_reg  #(MSB) sr0  ( .data (S_IN),
                         .clk (CLK),
                         .en (LATCH),
								 .out (S_OUT),
                         .registers (buffer)
								);


assign LED = buffer[7:0]; // ignore the first 2 bits
reg [7:0] ctrlData; 

always @*
begin
	ctrlData <= buffer[MSB-1:8];
	
	case (ctrlData)
		0 :  out <= {out[MSB-2:0], d};
      1 :  out <= {d, out[MSB-1:1]};
   endcase
end

endmodule

*/