# Commands

## Check status

Ready status upon request or at startup
```js
{"cmd": "status"}    // request
{"status": "ready"}  // answer
```

---
## Reset

Reset LED and outputs
```js
{"cmd": "reset"}
{"ack": "reset"}
```

---
## Get Input

Read A0, A1, A2 using specific number of samples (default 1 max 50);

```js
{"cmd": "analogRead"}                       // request (default samples = 1)
{"cmd": "analogRead", "samples": "5"}       // request

{"ack":"analogRead", "A0":343, "A1":371, "A2":364}  // example answer
```

---
## Set output

Set voltage between 0V and 4.5V on **D2**. The input value and the return voltage are clipped between 0 and 4.5V.
```js
{"cmd": "setv", "value" : "4000"}     // request
{"ack": "voltage", "value": 4000}     // answer

//clipping example
{"cmd": "setv", "value" : "5000"}     // request
{"ack": "voltage", "value": 4500}     // answer
```

**D1** and **D2** can be set HIGH/LOW or PWM.

```js
{"cmd": "setHigh", "pin": "D0"}       // request
{"cmd": "setLow", "pin": "D0"}        // request

{"ack": "setHigh", "pin": "D0"}       // answer
{"ack": "setLow", "pin": "D0"}        // answer
```

For PWM the input duty and the return voltage are clipped between 0 and 100. Pin can be "D0" or "D1".
```js
{"cmd": "setPwm", "pin": "D0", "duty" : "90"}       // request
{"ack": "setPwm", "pin": "D0", "duty" : 90}         // answer

// clipping example
{"cmd": "setPwm", "pin": "D0", "duty" : "120"}     // request
{"ack": "setPwm", "pin": "D0", "duty" : 100}       // answer
```

---
## LEDs

LEDs are placed in this config

1   --  26
2   --  27
3   --  28
4   --  29
.   --  .
.   --  .
.   --  .
23  --  48
24  --  49
25  --  50


Patterns 
* off
* on = steady on
* blink
* blink2 = 1/2 of blink

```js
{"cmd": "setLed", "led": "1", "pattern": "off"} 
{"cmd": "setLed", "led": "1", "pattern": "on"} 
{"cmd": "setLed", "led": "1", "pattern": "blink"} 
{"cmd": "setLed", "led": "1", "pattern": "blink2"} 

{"ack": "setLed", "led": "1", "pattern": "off"} 
{"ack": "setLed", "led": "1", "pattern": "on"} 
{"ack": "setLed", "led": "1", "pattern": "blink"} 
{"ack": "setLed", "led": "1", "pattern": "blink2"} 
```

---
# Set LedCmd
```js
{"cmd": "setCmdLed", "led": "vcc", "pattern": "on"}
{"cmd": "setCmdLed", "led": "gnd", "pattern": "on"}
{"cmd": "setCmdLed", "led": "a0", "pattern": "on"}
{"cmd": "setCmdLed", "led": "a1", "pattern": "on"}
{"cmd": "setCmdLed", "led": "a2", "pattern": "on"}
{"cmd": "setCmdLed", "led": "d0", "pattern": "on"}
{"cmd": "setCmdLed", "led": "d1", "pattern": "on"}
{"cmd": "setCmdLed", "led": "d2", "pattern": "on"}
{"cmd": "setCmdLed", "led": "status1", "pattern": "on"}
{"cmd": "setCmdLed", "led": "status2", "pattern": "on"}
```


---
# Brightness

Values of brightness between 0 and 99
```js
{"cmd": "setBrightness", "value": "1"} 
{"ack": "brightness", "value": "1"} 

// clipping example
{"cmd": "setBrightness", "value": "120"} 
{"ack": "brightness", "value": "100"} 
```

---
# Animate LED

Draw all LEDs 1-50 and vice-versa

```js
{"cmd": "animate"}
{"ack": "animate"} 

// optionally put time in ms
{"cmd": "animate", value:"100"}
{"ack": "animate"} 
```

---
## Others

Other errors
```js
{"ack":"json parse fail"}   // not valid JSON input
{"ack":"invalid command"}   // not valid command
```


