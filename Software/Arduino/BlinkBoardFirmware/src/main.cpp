#include <Arduino.h>

// Libs
#include "MsTimer2.h"
#include "ArduinoJson.h"

// Constants
#include "constants.hpp"

// Types
enum LED_State { ON, OFF, PTRN1, PTRN2 };

// Forward declarations
void initialize();
void blink();
void parse(const String &buffer);
void ack(const String &msg);
void sendJSON (const String &key, const String &val);
void sendCommand (uint8_t ledNumber, LED_State state);
void reset();

// Globals
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
  pinMode(LATCH1, OUTPUT);
  pinMode(LATCH2, OUTPUT);
  pinMode(LATCH3, OUTPUT);
  pinMode(DATA, OUTPUT);
  pinMode(CLK, OUTPUT);
  pinMode(RESET, OUTPUT);

  pinMode(OUTPUT_D0, OUTPUT);
  pinMode(OUTPUT_D1, OUTPUT);
  pinMode(PATTERN2, OUTPUT);

  Serial.begin(115200);
  sendJSON (F("status"), F("ready"));
}


void blink()
{
  static boolean output = HIGH;

  digitalWrite(PATTERN2, output);
  output = !output;
}

void reset()
{

}


void parse(const String &buffer)
{
  StaticJsonDocument<BUFFER_SIZE> json;
  DeserializationError error = deserializeJson(json, buffer);

  // Test if parsing succeeds.
  if (error)
  {
    ack(F("json parse fail"));
    return;
  }

  // Parse JSON
  // READY
  if (json["cmd"] == F("status"))
  {
    // do something
    sendJSON (F("status"), F("ready"));
  }
  // RESET
  else if (json["cmd"] == F("reset"))
  {
    // do something
    ack(F("reset"));
  }
  // SET
  else if (json["cmd"] == F("set"))
  {
    String pt= json["pattern"].as<String>();
    String type= json["type"].as<String>();
    long val= json["value"].as<long>();

    Serial.println(pt);
    Serial.println(type);
    Serial.println(val);
    
  }
  // ELSE
  else
  {
    ack(F("invalid command"));
  }
}


void ack(const String &msg)
{
  String result = "{\"ack\": \"" + msg + "\"}";
  Serial.println(result);
}

void sendJSON (const String &key, const String &val)
{
  String result = "{\"" + key + "\": \"" + val + "\"}";
  Serial.println(result);
}

void sendCommand (uint8_t ledNumber, LED_State state)
{
  byte op = 0;
  switch (state)
  {
    case OFF: op= 0; break;   // 00
    case ON: op= 1; break;    // 01
    case PTRN1: op= 2; break; // 10
    case PTRN2: op= 3; break; // 11
  }

  digitalWrite(LATCH1, LOW);
  shiftOut(DATA, CLK, MSBFIRST, ledNumber | (op << 5 ));
  digitalWrite(LATCH1, HIGH);
}


/*
  sendCommand (0, BLINK);
  sendCommand (1, BLINK);
  sendCommand (2, BLINK);
  sendCommand (3, OFF);
  sendCommand (4, OFF);
  sendCommand (5, ON);
  sendCommand (6, ON);
  sendCommand (7, BLINK2);
*/
