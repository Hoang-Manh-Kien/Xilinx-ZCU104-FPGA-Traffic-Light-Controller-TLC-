# Traffic Light Controller (TLC) FPGA Project
## Overview
This project implements a Traffic Light Controller (TLC) on the Xilinx ZCU104 FPGA development board using Verilog HDL. The controller cycles through RED, GREEN, and YELLOW lights with configurable timing and includes a dynamic countdown timer displayed on a seven-segment LED. Additional features include blinking lights during the last few seconds of RED and GREEN states for better visual alerts.

## Features
- Finite State Machine (FSM) design controlling traffic light sequencing
- A countdown timer is displayed on a seven-segment LED
- Blinking effects for RED and GREEN lights during the final countdown seconds
- Modular Verilog code including FSM, timer, blinking logic, and display decoder
- Synthesizable and deployable on ZCU104 FPGA hardware

## Hardware Requirements
- Xilinx ZCU104 FPGA development board
- Seven-segment display and LEDs connected as per design
- Vivado Design Suite for synthesis and implementation

## Usage
Clone the repository:

```bash
git clone <repository-url of this github>
cd traffic-light-controller-fpga
Open the Vivado project
Launch Vivado and open the provided project files.
```

## Synthesize and implement
Run synthesis, implementation, and generate the bitstream.

## Program the FPGA
- Load the bitstream onto the ZCU104 board.

## Observe operation
The traffic lights will cycle through RED (9s), GREEN (6s), and YELLOW (3s) with countdown and blinking effects.

## Notes and Known Issues
- The default clock divider parameter (CLKDIV1S) is set for simulation speed and results in very fast timer ticks (~8µs). To observe a human-visible countdown on hardware, adjust this parameter to scale timer ticks to 1 second (e.g., 125,000,000 - 1 for a 125 MHz clock).
- Ensure pin assignments and constraints (XDC file) match your hardware setup.
- Input debouncing may be required for physical switches (start, reset).

## Resource Utilization and Performance
- LUTs used: 38 (0.02%)
- Flip-Flops used: 28 (0.01%)
- IO Pins used: 21 (5.83%)
- Global Clock Buffers used: 1 (0.18%)
=> Timing reports confirm the design meets setup and hold constraints with high maximum frequency capability, well beyond operational requirements.

## Project Structure
```src/``` — Verilog source files (FSM controller, timer, blinking, display decoder)
```testbench/``` — Testbench files for simulation
```constraints/``` — XDC constraint files for pin assignments
