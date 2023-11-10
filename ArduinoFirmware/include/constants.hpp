#ifndef __CONSTANTS__H__
#define __CONSTANTS__H__

// CPLD CONTROL
#define LATCH1 8
#define LATCH2 9
#define LATCH3 10
#define DATA 11
#define CLK 12
#define RESET 13

// INPUT OUTPUT CONTTROL
#define INPUT_A0 A0
#define INPUT_A1 A1
#define INPUT_A2 A2
#define OUTPUT_D0 5
#define OUTPUT_D1 6
#define PWM_PIN 3

// ADDRESSES
#define MCP4725A0 0x60
// #define EEPROM_ADDRESS 0

// SETTINGS
#define DEFAULT_BRIGHTNESS 20
#define BUFFER_SIZE 128
#define MIN_VOLTAGE 0
#define MAX_VOLTAGE 4800
#define MAX_SAMPLES 50
#define ANIMATION_DELAYMS 30
#define ROWS 25

#define VERSION F("1.2")
#define BAUD_RATE 115200

#endif