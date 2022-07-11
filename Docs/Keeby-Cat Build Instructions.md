# Keeby-Cat Build Instructions

The build order is critical to making a fully working Keeby Cat Macropad. Before soldering any parts together, check to make sure you have all components. Also ensure that the Blue Pill MCU is fully functional as it is not easy to replace once soldered in place. Some clone STM32's will function enough to output keypresses, but crash when trying to configure through VIAL.

## Steps

1. Determine layout (for LEDS)
2. Solder:
   1. LEDs
   2. Headers to *board*. The solder goes on the top of the board. The plastic part of the headers is on the underside (with the Keeby Cat logo).
   3. Encoder(s)
3. Install top plate
4. Install and solder
   1. Key switches: 3x spots over MCU must be done before soldering the MCU itself (SW3, SW6 and SW14).
   2. Potentiometers: most importantly POT2 must be done before the MCU.
   3. Solder MCU (Blue Pill) to the installed headers with the 
   4. OLED screen
