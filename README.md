# Fuzzy Logic Washing Machine Controller

## Project Overview
This project implements a fuzzy logic system to determine the optimal washing machine cycle time based on two inputs: the dirt level of the clothes and the load size. It is built using the MATLAB Fuzzy Logic Toolbox.

## System Design
The system uses a Mamdani fuzzy inference system with the following parameters:

### Inputs
1. **Dirt Level** (Range: 0 - 100)
   * Fuzzy Sets: Low, Medium, High
2. **Load Size** (Range: 0 - 10 kg)
   * Fuzzy Sets: Small, Medium, Large

### Output
1. **Cycle Time** (Range: 0 - 60 minutes)
   * Fuzzy Sets: Short, Medium, Long

### Fuzzy Rule Base
The system is governed by a 3x3 matrix resulting in 9 rules (exceeding the minimum requirement of 6):
1. IF Dirt is Low AND Load is Small THEN Cycle is Short
2. IF Dirt is Low AND Load is Medium THEN Cycle is Short
3. IF Dirt is Low AND Load is Large THEN Cycle is Medium
4. IF Dirt is Medium AND Load is Small THEN Cycle is Short
5. IF Dirt is Medium AND Load is Medium THEN Cycle is Medium
6. IF Dirt is Medium AND Load is Large THEN Cycle is Medium
7. IF Dirt is High AND Load is Small THEN Cycle is Medium
8. IF Dirt is High AND Load is Medium THEN Cycle is Long
9. IF Dirt is High AND Load is Large THEN Cycle is Long

## Requirements
* MATLAB R2019a or newer
* Fuzzy Logic Toolbox

## How to Run
1. Clone this repository to your local machine.
2. Open MATLAB and navigate to the project directory.
3. Run the `washing_machine_controller.m` script.
4. The script will automatically generate the `.fis` file, print sample test cases to the console, and open the Membership Function plots and the interactive Rule Viewer.
