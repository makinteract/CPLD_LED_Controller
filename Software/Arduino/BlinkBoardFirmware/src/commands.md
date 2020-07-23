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
{"cmd": "setv", "value" : "4000"}       // request
{"ack": "voltage", "value": 4000}     // answer

//clipping example
{"cmd": "setv", "value" : "5000"}       // request
{"ack": "voltage", "value": 4500}     // answer
```

**D1** and **D2** can be set HIGH/LOW or PWM.

```js
{"cmd": "sethigh", "pin": "D0"}       // request
{"cmd": "setlow", "pin": "D0"}        // request

{"ack": "sethigh", "pin": "D0"}                    // answer
{"ack": "setlow", "pin": "D0"}                    // answer
```

For PWM the input duty and the return voltage are clipped between 0 and 100. Pin can be "D0" or "D1".
```js
{"cmd": "setpwm", "pin": "D0", "duty" : "90"}       // request
{"ack": "setpwm", "pin": "D0", "duty" : 90}       // answer

// clipping example
{"cmd": "setpwm", "pin": "D0", "duty" : "120"}       // request
{"ack": "setpwm", "pin": "D0", "duty" : 100}       // answer
```

---
## LEDs


```js
{"cmd": "setled", "led": "0", "pattern": "on"} 
{"cmd": "setled", "led": "0", "pattern": "off"} 
{"cmd": "setled", "led": "0", "pattern": "ptrn1"} 
{"cmd": "setled", "led": "0", "pattern": "ptrn2"} 

{"ack": "setled", "led": "0", "pattern": "on"} 
{"ack": "setled", "led": "0", "pattern": "off"} 
{"ack": "setled", "led": "0", "pattern": "ptrn1"} 
{"ack": "setled", "led": "0", "pattern": "ptrn2"} 

```

- set breadboard led

- set iindicator led
- set input led

{"cmd": "setled", "pattern": "on|off|p1|p2", "type": "row|v|out", "value":"number"} 
{"cmd": "setled", "pattern": "on", "type": "row", "value":"15"} 


---
## Others

Other errors
```js
{"ack":"json parse fail"}   // not valid JSON input
{"ack":"invalid command"}   // not valid command
```

