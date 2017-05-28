# Instructions

`"rpi": true` is the default setting. 

**If not on a raspberry pi**, set this to `false`.

*Otherwise things will not work. App will crash :P*

### Pins/Directions

There is already a standard config for 1 pin.

Pin 17 with a default value of `false` (off) and a power direction of `"out"`.

This server uses the [pi_piper](https://github.com/jwhitehorn/pi_piper) gem, so if you want to learn more, go check it out!

All pins must have default state and direction!!!

### Example of adding another pin

```json
{
  "pins": {
    "17": false,
    "27": false
  },
  "directions": {
    "17": "out",
    "27": "out"
  },
  "rpi": true
}
```
