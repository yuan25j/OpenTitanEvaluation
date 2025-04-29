# OpenPiton Security Verification

A fully automated pipeline for hardware‐level security verification of the OpenPiton manycore processor. This repository integrates:

- **sv2v** for SystemVerilog → Verilog conversion  
- **Cadence JasperGold** for formal‐property checking and VCD export  
- **vcdparse** for reset‐state extraction  
- **Sylvia** for piecewise symbolic execution on Verilog RTL  
- Utility scripts to glue everything together

## Features

- Converts OpenPiton’s SystemVerilog RTL to synthesizable Verilog  
- Translates Hack@DAC 2021 SVA properties into Verilog `assert`s  
- Automates extraction of concrete reset‐state vectors via JasperGold → VCD → Python dict  
- Executes Sylvia’s symbolic engine with hardcoded reset states  
- Logs and compares assertion violations against the known property suite

## Repository Layout

