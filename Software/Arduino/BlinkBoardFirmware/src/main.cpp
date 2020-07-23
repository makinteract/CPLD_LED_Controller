#include <Arduino.h>

// Libs
#include <MsTimer2.h>
#include <ArduinoJson.h>
#include <Adafruit_MCP4725.h>

// Constants
#include "constants.hpp"

// Types
enum LED_State { ON, OFF, PTRN1, PTRN2 };

// Forward declarations
void initialize();
void reset();
void blink();
void parse(const String &buffer);
// void sendCommand (uint8_t ledNumber, LED_State state);
uint32_t setVoltage(uint32_t mV);
void sendJson();
void readAnalogSamples (uint16_t& a0, uint16_t& a1, uint16_t& a2, uint8_t samples);
void invalidCommand();
uint16_t dutyCycleToByte (uint16_t value);

// Globals
StaticJsonDocument<BUFFER_SIZE> json;
Adafruit_MCP4725 dac;
String buffer = "";



// Main

void setup()
{
  initialize();
  reset();

  MsTimer2::set(PATTERN2_PERIOD_MS, blink);
  MsTimer2::start();

  
}


void loop()
{
  while (Serial.available())
  {
    char inChar = (char)Serial.read();
    if (inChar == '\n')
    {
      parse(buffer);
      buffer = "";
    }
    else
    {
      buffer += inChar;
    }
  }
}


// Helpers

void initialize()
{
  Serial.begin(115200);

  pinMode(LATCH1, OUTPUT);
  pinMode(LATCH2, OUTPUT);
  pinMode(LATCH3, OUTPUT);
  pinMode(DATA, OUTPUT);
  pinMode(CLK, OUTPUT);
  pinMode(RESET, OUTPUT);

  pinMode(OUTPUT_D0, OUTPUT);
  pinMode(OUTPUT_D1, OUTPUT);
  pinMode(PATTERN2, OUTPUT);

  // DAC
  dac.begin(MCP4725A0);

  reset();

  json["status"] = "ready";
  sendJson();

}


void blink()
{
  static boolean output = HIGH;

  digitalWrite(PATTERN2, output);
  output = !output;
}

void reset()
{
  setVoltage(MIN_VOLTAGE);
  digitalWrite (OUTPUT_D0, LOW);
  digitalWrite (OUTPUT_D1, LOW);
}


void parse(const String &buffer)
{
  
  DeserializationError error = deserializeJson(json, buffer);

  // Test if parsing succeeds.
  if (error)
  {
    json.clear();
    json["ack"] = "json parse fail";
    sendJson();
    return;
  }

  // Parse JSON
  // READY
  if (json["cmd"] == F("status"))
  {
    json.clear();
    json["status"] = "ready";
    sendJson();
  }
  // RESET
  else if (json["cmd"] == F("reset"))
  {
    reset();
    
    json.clear();
    json["ack"] = "reset";
    sendJson();
  }
  // READ ANALOG
  else if (json["cmd"] == F("analogRead"))
  {
    long samples= json["samples"].as<long>();
    if (samples==0) samples=1; // default if not specified

    uint16_t a0, a1, a2;
    readAnalogSamples (a0, a1, a2, samples);

    json.clear();
    json["ack"] = "analogRead";
    json["A0"] = a0;
    json["A1"] = a1;
    json["A2"] = a2;
    sendJson();
  }
  // SET HIGH
  else if (json["cmd"] == F("sethigh"))
  {
    String pin= json["pin"].as<String>();
    if (pin=="D0") digitalWrite(OUTPUT_D0, HIGH);
    else if (pin=="D1") digitalWrite(OUTPUT_D1, HIGH);
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "sethigh";
    json["pin"] = pin;
    sendJson();
  }
  // SET LOW
  else if (json["cmd"] == F("setlow"))
  {
    String pin= json["pin"].as<String>();
    if (pin=="D0") digitalWrite(OUTPUT_D0, LOW);
    else if (pin=="D1") digitalWrite(OUTPUT_D1, LOW);
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "setlow";
    json["pin"] = pin;
    sendJson();
  }
  // SET PWM
  else if (json["cmd"] == F("setpwm"))
  {
    String pin= json["pin"].as<String>();
    uint16_t duty= json["duty"].as<long>();
    if (duty>100) duty= 100;

    if (pin=="D0") analogWrite(OUTPUT_D0, dutyCycleToByte(duty));
    else if (pin=="D1") analogWrite(OUTPUT_D1, dutyCycleToByte(duty));
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "setpwm";
    json["pin"] = pin;
    json["duty"] = duty;
    sendJson();
  }
  // SET VOLTAGE
  else if (json["cmd"] == F("setv"))
  {
    long val= json["value"].as<long>();
    val= setVoltage(val);
    
    json.clear();
    json["ack"] = "voltage";
    json["value"] = val;
    sendJson();
  }
  // SET LED
  else if (json["cmd"] == F("setled"))
  {
    // String pt= json["pattern"].as<String>();
    // String type= json["type"].as<String>();
    // long val= json["value"].as<long>();

    // json.clear();
    // json["ack"] = "ledChange";
    // sendJson();
    
  }
  // ELSE
  else
  {
    invalidCommand();
  }
}


uint32_t setVoltage(uint32_t mV)
{
  // clip
  if (mV> MAX_VOLTAGE) mV= MAX_VOLTAGE;

  uint32_t v = mV * 4095 / MAX_VOLTAGE; // up to 4500 mV
  dac.setVoltage(v, false); // to do the convertion
  return mV;
}

void readAnalogSamples (uint16_t& a0, uint16_t& a1, uint16_t& a2, uint8_t samples)
{
  a0= analogRead (INPUT_A0);
  a1= analogRead (INPUT_A1);
  a2= analogRead (INPUT_A2);

  if (samples == 1) return;
  // else
  if (samples>MAX_SAMPLES) samples=MAX_SAMPLES;

  for (uint8_t i=0; i<samples-1; i++) // do the remaining samples-1 cases
  {
    a0+= analogRead (INPUT_A0);
    a1+= analogRead (INPUT_A1);
    a2+= analogRead (INPUT_A2);
  }
  a0/= samples;
  a1/= samples;
  a2/= samples;
}

// void sendCommand (uint8_t ledNumber, LED_State state)
// {
//   byte op = 0;
//   switch (state)
//   {
//     case OFF: op= 0; break;   // 00
//     case ON: op= 1; break;    // 01
//     case PTRN1: op= 2; break; // 10
//     case PTRN2: op= 3; break; // 11
//   }

//   digitalWrite(LATCH1, LOW);
//   shiftOut(DATA, CLK, MSBFIRST, ledNumber | (op << 5 ));
//   digitalWrite(LATCH1, HIGH);
// }


void sendJson()
{
  serializeJson(json, Serial);
  Serial.println("");
}

void invalidCommand()
{
  json.clear();
  json["ack"] = "invalid command";
  sendJson();
}

// value is between 
uint16_t dutyCycleToByte (uint16_t value)
{
  if (value > 100) value=100;
  return value*255/100;
}