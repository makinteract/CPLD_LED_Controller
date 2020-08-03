#include <Arduino.h>

// Libs
#include <ArduinoJson.h>
#include <Adafruit_MCP4725.h>

// Constants
#include "constants.hpp"

// Types
enum class CmdLed { VCC_LED, GND_LED, A0_LED, A1_LED, A2_LED, D0_LED, D1_LED, D2_LED, STATUS_LED, ERROR_LED};


// Forward declarations
void initialize();
void reset();

void parse(const String &buffer);
void sendJson();
void invalidCommand();

uint32_t setVoltage(uint32_t mV);
void readAnalogSamples (uint16_t& a0, uint16_t& a1, uint16_t& a2, uint8_t samples);
uint16_t setBrigtness(uint16_t brightness);

bool sendLedCommand (uint8_t ledNumber, uint8_t chipNumber, String& state);
bool setLed (uint8_t led, String& state);
bool setCmdLed (CmdLed led, String& state);
bool setCmdLed (String& ledType, String& state);
void animateLed(uint8_t delayMs=ANIMATION_DELAYMS);
void allLedOff();
void setStatus(bool on);
void setErrorStatus(bool on);

uint16_t dutyCycleToByte (uint16_t value);
uint16_t analogReadingToVoltage (uint16_t val);


// Globals
Adafruit_MCP4725 dac;
StaticJsonDocument<BUFFER_SIZE> json;
String buffer = "";



// Main
void setup()
{
  initialize();
  reset();
  
  delay(1000);
  animateLed();
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

  // DAC
  dac.begin(MCP4725A0);

  // Default brightness
  setBrigtness (DEFAULT_BRIGHTNESS);
}



void reset()
{
  digitalWrite(RESET, LOW);
  setVoltage(MIN_VOLTAGE);
  digitalWrite (OUTPUT_D0, LOW);
  digitalWrite (OUTPUT_D1, LOW);

  // ready for input
  digitalWrite(RESET, HIGH);

  // Out voltage
  setVoltage (0);

  // all off
  allLedOff();

  // status and error
  setStatus(true);
  setErrorStatus(false);
}


void parse(const String &buffer)
{
  DeserializationError error = deserializeJson(json, buffer);

  // Reset for next instruction errors status led
  setErrorStatus(false);


  // Test if parsing succeeds.
  if (error)
  {
    setErrorStatus(true); 
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
  // Animate
  else if (json["cmd"] == F("animate"))
  {
    long val= json["value"].as<long>();
    if (val > 0) animateLed(val);
    else animateLed();
    
    json.clear();
    json["ack"] = "animate";
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
  else if (json["cmd"] == F("setHigh"))
  {
    String pin= json["pin"].as<String>();
    if (pin=="D0") digitalWrite(OUTPUT_D0, HIGH);
    else if (pin=="D1") digitalWrite(OUTPUT_D1, HIGH);
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "setHigh";
    json["pin"] = pin;
    sendJson();
  }
  // SET LOW
  else if (json["cmd"] == F("setLow"))
  {
    String pin= json["pin"].as<String>();
    if (pin=="D0") digitalWrite(OUTPUT_D0, LOW);
    else if (pin=="D1") digitalWrite(OUTPUT_D1, LOW);
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "setLow";
    json["pin"] = pin;
    sendJson();
  }
  // SET PWM
  else if (json["cmd"] == F("setPwm"))
  {
    String pin= json["pin"].as<String>();
    uint16_t duty= json["duty"].as<long>();
    if (duty>100) duty= 100;

    if (pin=="D0") analogWrite(OUTPUT_D0, dutyCycleToByte(duty));
    else if (pin=="D1") analogWrite(OUTPUT_D1, dutyCycleToByte(duty));
    else { invalidCommand(); return; }
    
    json.clear();
    json["ack"] = "setPwm";
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
  else if (json["cmd"] == F("setLed"))
  {
    long led= json["led"].as<long>();
    String ptrn= json["pattern"].as<String>();

    if (setLed (led, ptrn))
    {
      json.clear();
      json["ack"] = "setLed";
      sendJson();
    }else{
      invalidCommand();
    }
  }
  // SET LEDCMD
  else if (json["cmd"] == F("setCmdLed"))
  {
    String led= json["led"].as<String>();
    String ptrn= json["pattern"].as<String>();
  
    if (setCmdLed (led, ptrn))
    {
      json.clear();
      json["ack"] = "setCmdLed";
      sendJson();
    }else{
      invalidCommand();
    }
  }
  // SET LED BRIGHTNESS
  else if (json["cmd"] == F("setBrightness"))
  {
    long val= json["value"].as<long>();
    if (val>100) val =100;
    val = setBrigtness(val);
    
    json.clear();
    json["ack"] = "brightness";
    json["value"] = val;
    sendJson();
  }
  // ELSE
  else
  {
    invalidCommand();
  }
}


void sendJson()
{
  serializeJson(json, Serial);
  Serial.println("");
}

void invalidCommand()
{
  setErrorStatus(true); 
  json.clear();
  json["ack"] = "invalid command";
  sendJson();
}

uint32_t setVoltage(uint32_t mV)
{
  // clip
  if (mV> MAX_VOLTAGE) mV= MAX_VOLTAGE;

  uint32_t v = map (mV, 0, MAX_VOLTAGE, 0, 4095);
  dac.setVoltage(v, false); // to do the convertion
  return mV;
}

void readAnalogSamples (uint16_t& a0, uint16_t& a1, uint16_t& a2, uint8_t samples)
{
  a0= analogReadingToVoltage (analogRead (INPUT_A0));
  a1= analogReadingToVoltage (analogRead (INPUT_A1));
  a2= analogReadingToVoltage (analogRead (INPUT_A2));

  if (samples == 1) return;
  // else
  if (samples>MAX_SAMPLES) samples=MAX_SAMPLES;

  for (uint8_t i=0; i<samples-1; i++) // do the remaining samples-1 cases
  {
    a0+= analogReadingToVoltage (analogRead (INPUT_A0));
    a1+= analogReadingToVoltage (analogRead (INPUT_A1));
    a2+= analogReadingToVoltage (analogRead (INPUT_A2));
  }
  a0/= samples;
  a1/= samples;
  a2/= samples;
}

// LED number 0-19
// chipNumber: 1,2,3
// state: on, off, blink, blink2
bool sendLedCommand (uint8_t ledNumber, uint8_t chipNumber, String& state)
{
  if (ledNumber > 19) return false;
  
  uint8_t latch = 0;
  switch (chipNumber)
  {
    case 1: latch= LATCH1; break;  
    case 2: latch= LATCH2; break;  
    case 3: latch= LATCH3; break;  
    default: return false;
  }

  uint8_t op = 0; // off
  if (state==F("off")) op= 0;
  else if (state==F("on")) op= 1;
  else if (state==F("blink")) op= 2;
  else if (state==F("blink2")) op= 3;
  else return false;

  digitalWrite(latch, LOW);
  shiftOut(DATA, CLK, MSBFIRST, ledNumber | (op << 5 ));
  digitalWrite(latch, HIGH);
  return true;
}


bool setLed (uint8_t led, String& state)
{
  if (led < 1 || led > 50) return false;
  // Chip 1: rows 1-18 => pins 2 - 19
  bool result= false;
  if (led <= 18)
  {
    result= sendLedCommand (led+1, 1, state);
  }
  // Chip 2: rows 19 - 25 => pins 0 - 6
  else if (led  <= 25)
  {
    result= sendLedCommand (led-19, 2, state);
  }
  // Chip 3: rows 26 - 37   => pins 10 - 0
  else if (led <= 37)
  {
    result= sendLedCommand (37 - led, 3, state);
  }else{
    // Chip 2: rows 38 - 50 => pins 19 - 7
    result= sendLedCommand (38 - led + 19, 2, state);
  }

  return result;
}


bool setCmdLed (String& ledType, String& state)
{
  if (ledType == F("vcc"))sendLedCommand (0, 1, state);
  else if (ledType == F("gnd"))sendLedCommand (1, 1, state);
  else if (ledType == F("a0"))sendLedCommand (12, 3, state);
  else if (ledType == F("a1"))sendLedCommand (13, 3, state);
  else if (ledType == F("a2"))sendLedCommand (14, 3, state);
  else if (ledType == F("d0"))sendLedCommand (15, 3, state);
  else if (ledType == F("d1"))sendLedCommand (16, 3, state);
  else if (ledType == F("d2"))sendLedCommand (17, 3, state);
  else if (ledType == F("status1"))sendLedCommand (18, 3, state);
  else if (ledType == F("status2"))sendLedCommand (19, 3, state);
  else return false;

  return true;
}


bool setCmdLed (CmdLed led, String& state)
{
  switch (led)
  {
    case CmdLed::VCC_LED: sendLedCommand (0, 1, state); break;
    case CmdLed::GND_LED: sendLedCommand (1, 1, state); break;
    case CmdLed::A0_LED: sendLedCommand (12, 3, state); break;
    case CmdLed::A1_LED: sendLedCommand (13, 3, state); break;
    case CmdLed::A2_LED: sendLedCommand (14, 3, state); break;
    case CmdLed::D0_LED: sendLedCommand (15, 3, state); break;
    case CmdLed::D1_LED: sendLedCommand (16, 3, state); break;
    case CmdLed::D2_LED: sendLedCommand (17, 3, state); break;
    case CmdLed::STATUS_LED: sendLedCommand (18, 3, state); break;
    case CmdLed::ERROR_LED: sendLedCommand (19, 3, state); break;
    default: return false; // wrong option
  }
  return true;
}

// value is between 
uint16_t dutyCycleToByte (uint16_t value)
{
  if (value > 100) value=100;
  return value*255/100;
}

// brightness is 0-100
uint16_t setBrigtness(uint16_t brightness)
{
  if (brightness > 100) brightness=100;
  analogWrite(PWM_PIN, brightness*256/100);
  return brightness;
}


void animateLed (uint8_t delayMS)
{
  // left
  String on= "on";
  String off= "off";
  
  // down
  for (int i=1; i<=ROWS;i++)
  {
    setLed(i, on);
    setLed(i+ROWS, on);
    delay(delayMS);
  }

  for (int i=1; i<=ROWS;i++)
  {
    setLed(i, off);
    setLed(i+ROWS, off);
    delay(delayMS);
  }
}

void allLedOff()
{
  String off= "off";
  
  for (int i=0; i<=ROWS*2;i++)
  {
    setLed(i, off);
  }

  // Command lED
  setCmdLed (CmdLed::VCC_LED, off);
  setCmdLed (CmdLed::GND_LED, off);
  setCmdLed (CmdLed::A0_LED, off);
  setCmdLed (CmdLed::A1_LED, off);
  setCmdLed (CmdLed::A2_LED, off);
  setCmdLed (CmdLed::D0_LED, off);
  setCmdLed (CmdLed::D1_LED, off);
  setCmdLed (CmdLed::D2_LED, off);
  setCmdLed (CmdLed::STATUS_LED, off);
  setCmdLed (CmdLed::ERROR_LED, off);
}

void setStatus(bool on)
{
  String s1= F("on");
  String s2= F("off");
  if (on) setCmdLed (CmdLed::STATUS_LED, s1);
  else setCmdLed (CmdLed::STATUS_LED, s2);
}

void setErrorStatus(bool on)
{
  String s1= F("on");
  String s2= F("off");
  if (on) setCmdLed (CmdLed::ERROR_LED, s1);
  else setCmdLed (CmdLed::ERROR_LED, s2);
}

uint16_t analogReadingToVoltage (uint16_t val)
{
  return map (val, 0, 1025, 0, 5000);
}