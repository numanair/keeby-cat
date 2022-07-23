# Keeby Cat

This is the hardware repository for the Keeby Cat macropad. Developement is ongoing.

## Intro

Keeby Cat is a highly configurable macropad with multiple fader and knob layouts. The "standard" build features 3x4 keys with a rotary encoder and an 128x32 pixel OLED display. A full keyswitch build is 3x5 keys with the top row offset vertically by 0.25u. Up to five rotary encoders can be used in specified locations. One to three faders (linear potentiometers) can be used in place of the lower key columns.

## Firmware

Vial is the standard firmware for Keeby Cat as it allows key and encoder reassignment without recompiling firmware.
Firmware source is located here: [github.com/numanair/vial-qmk](https://github.com/numanair/vial-qmk/tree/vial/keyboards/returntoparadise/keeby_cat)  
**Note:** Firmware has not yet been completed for all variations. As such not all variants have been tested yet. However, the groundwork is there and it should not be too complicated to create these firmware variations.

## Layouts and Configurations

The default configuration is 3x4 keys with a single knob and an OLED screen.

The maximum keyswitch layout is 3x5.

### Rotary Encoder Knobs

Nine special key locations can accept encoder knobs, however only five knobs can be wired up at once.

Potential knob locations are:  
The left and right columns of the lower 4 keys, but with only one from each *row* being installed.
The top left corner.

### OLED Screen

An optional display can show layer information, key-states, and graphics. It replaces the top right pair of keyswitches.
