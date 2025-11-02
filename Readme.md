# MicroWatt-LX SoC Generator: An Open-Source, Python-Driven POWER ASIC Platform

## Final Submission for ChipFoundry Microwatt Hackathon

[![License](https://img.shields.io/badge/License-APACHE2.0-yellow.svg)](https://github.com/Lefteris-B/microwatt_design_challenge/blob/main/license.md) 
[![CPU](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)](https://git.openpower.foundation/cores/microwatt)
[![Framework](https://img.shields.io/badge/Framework-LiteX-orange)](https://github.com/enjoy-digital/litex)
[![PDK](https://img.shields.io/badge/PDK-SKY130-green)](https://skywater-pdk.readthedocs.io/en/main/index.html)
[![CI - Smoke](https://img.shields.io/badge/CI-SMOKE%20TEST-green)](https://github.com/Lefteris-B/microwatt_design_challenge/actions/workflows/ci-smoke.yml)

## 1. Project Summary

This final submission presents **MicroWatt-LX**, an extensible, open-source framework for generating parameterizable SoCs based on the [Microwatt](https://git.openpower.foundation/cores/microwatt) POWER CPU and [LiteX](https://github.com/enjoy-digital/litex) ecosystem, targeted at the [SKY130 PDK ](https://skywater-pdk.readthedocs.io/) using [ChipFoundry's Caravel User Project and OpenFrame](https://chipfoundry.io/soc_platforms). The project delivers a Python-driven pipeline that transforms simple configurations into *tapeout-ready ASICs*, complete with tested peripherals and a documented flow.

To achieve this, I developed **two complementary repositories**:
- **[chipfoundry/caravel_mgmt_soc_litex (forked and modified)](https://github.com/chipfoundry/caravel_mgmt_soc_litex)**: Replaced the original VexRISC CPU with Microwatt while retaining the existing memory and peripherals. This provides a drop-in upgrade for POWER-based designs in the Caravel harness.
- **[Lefteris-B/microwatt_design_challenge](https://github.com/Lefteris-B/microwatt_design_challenge)**: A flexible LiteX-based SoC generator framework. As a proof-of-concept (PoC), it integrates ChipFoundry's proprietary SRAM macro [](https://github.com/chipfoundry/CF_UART), enabling arbitrary SoC configurations.

Both repositories include simulation, synthesis, and PnR flows, with demonstrations of bare-metal booting via UART. This submission aligns with the proposal's profiles: (A) Baseline, (B) Caravel User Project (PoC), and partial (C) OpenFrame Build (Caravel Management SoC with Litex)

## Video Demonstrations

- [Verilog generation and FPGA bitstream upload (Digilent Nexys 4 100T-xc7a100t)](https://www.youtube.com/watch?v=KdZCAlcoooA)
- [Core simulation running LiteX BIOS and UART connection](https://www.youtube.com/watch?v=4e1k-80p-Ws)
- [Binary demos on the core]()
- [Full presentation with FPGA board]()

## 2. Achievements & Value Proposition

### From Proposal to Implementation

The original proposal outlined a reusable SoC generator to bridge the gap in open POWER ASICs. This submission realizes that vision by:
- Integrating Microwatt into LiteX for seamless Python-based configuration.
- Providing ASIC-verified peripherals, including ChipFoundry's SRAM and UART.
- Demonstrating end-to-end flows: simulation, FPGA emulation, and OpenLane PnR for SKY130.
- Enabling community contributions through modular designs and CI pipelines.

### Key Deliverables
- **Reusable Generator**: Python scripts in both repos generate SoCs with configurable memory, peripherals, and extensions.
- **Profiles Implemented**:
  - **(A) Baseline**: Microwatt + 32KB SRAM + UART. Fully PnR'd, precheck-validated, boots "hello world" bare-metal via UART.
  - **(B) Caravel User Project (PoC)**: Configured for ChipFoundry OpenFrame (padframe + power straps). Compliant with shuttle requirements.
  - **(C) OpenFrame Build (Caravel Management SoC with Litex)**: Developed a script to seamlessly replace the VexRiscv core with Microwatt. Adapted the overall workflow to support the new CPU core, ensuring compatibility and optimized integration.
- **Verification**:  Conducted Verilator simulations, back-annotated timing analysis, and achieved clean DRC/LVS reports. Implemented smoke CI tests (currently in beta). Leveraged Vivado and LiteX to generate bitstreams, validating the overall flow and CPU code. Developed and successfully loaded binaries to the core, demonstrating functionalities such as
  -  a C "hello world" application,
  -   a C program displaying animated ASCII art, 
  -   and an LED control program that renders user-input numbers on FPGA LEDs.
- **Documentation**: Step-by-step guides for reproduction, including tool versions and artifacts.

### Value Proposition
- **Python-to-Silicon Simplicity**: Users configure SoCs in Python, focusing on innovations like accelerators instead of low-level integration.
- **ASIC-Ready Library**: Open collection of POWER-compatible peripherals for SKY130, using ChipFoundry macros for reliability.
- **Community Impact**: OpenFrame compatibility fosters OpenPOWER ASIC collaboration, education, and research.

## 3. Implemented Architecture

The MicroWatt-LX SoC uses a Wishbone bus managed by LiteX, with Microwatt as the core CPU.
```
Top metal / service area
+---------------------------------------------------------------+
| IO Pad Ring (pads for VDDIO, GND, SPI, UART pins, CLK pads)   |
|  [IO TOP PADS]                                                |
+---------------------------------------------------------------+
|                           Padframe                            |
|  +---------------------------------------------------------+  |
|  |  IO Left  |  Core & Std Cells    |  SRAM Macro Region   |  |
|  |  Pads     |  (Microwatt + AXI/   |  (grouped macros,    |  |
|  |           |   LiteX interconnect)|  mirrored rows)      |  |
|  |           |                      |                      |  |
|  |           |                      |  [SRAM block A]      |  |
|  |           |     CPU Cluster      |  [SRAM block B]      |  |
|  |           |  (Microwatt + L2)    |  [SRAM block C]      |  |
|  |  Power    |  +--Cache/Periph--+  |  [SRAM block D]      |  |
|  |  straps   |  | UART, SPI, ETH |  |                      |  |
|  |  & PDN    |  +-----------------+  +---------------------+  |
|  +---------------------------------------------------------+  |
|  [IO BTM PADS]                                                |
+---------------------------------------------------------------+
Bottom metal / service area
```
Macros grouped for routing efficiency; power straps every 50-200µm.


### System Components

| Component | Specification | Implementation | Benefits |
|-----------|---------------|----------------|----------|
| CPU Core | 64-bit POWER ISA | Unmodified Microwatt VHDL | FPGA-proven, MMU/FPU support |
| Memory System | 32KB-1MB SRAM | ChipFoundry CF_SRAM_1024x32 macros | Production-grade, characterized |
| Interconnect | Wishbone Bus | LiteX-generated, ASIC-optimized | Mature, documented |
| Peripherals | UART, SPI, GPIO, Timers | ChipFoundry CF_UART + LiteX IP | ASIC-verified drivers |
| Extension | Custom slot | Documented Wishbone interface | For accelerators |

- **Target Specs**: 50-100MHz clock, <100mW power @ 50MHz.
- **Fallback**: Used SPI external RAM in emulation for larger memory needs.

### Floorplan Sketch
A compact floorplan for SKY130 with on-chip SRAM and IO pads:
```
Top metal / service area
+---------------------------------------------------------------+
| IO Pad Ring (pads for VDDIO, GND, SPI, UART pins, CLK pads)   |
|  [IO TOP PADS]                                                |
+---------------------------------------------------------------+
|                           Padframe                            |
|  +---------------------------------------------------------+  |
|  |  IO Left  |  Core & Std Cells    |  SRAM Macro Region   |  |
|  |  Pads     |  (Microwatt + AXI/   |  (grouped macros,    |  |
|  |           |   LiteX interconnect)|  mirrored rows)      |  |
|  |           |                      |                      |  |
|  |           |                      |  [SRAM block A]      |  |
|  |           |     CPU Cluster      |  [SRAM block B]      |  |
|  |           |  (Microwatt + L2)    |  [SRAM block C]      |  |
|  |  Power    |  +--Cache/Periph--+  |  [SRAM block D]      |  |
|  |  straps   |  | UART, SPI, ETH |  |                      |  |
|  |  & PDN    |  +-----------------+  +---------------------+  |
|  +---------------------------------------------------------+  |
|  [IO BTM PADS]                                                |
+---------------------------------------------------------------+
Bottom metal / service area
```


- Macros grouped for routing efficiency; power straps every 50-200µm.

## 4. Implementation & Timeline Recap

Followed the proposed timeline with adjustments:
- **Weeks 1-2**: RTL integration (Microwatt into LiteX/Caravel), simulation, CI setup.
- **Weeks 3-4**: PnR iterations, timing closure, OpenFrame mapping.
- **Weeks 5-6**: DRC/LVS fixes, emulation demos, documentation.

All milestones achieved: Baseline RTL/sim, ASIC flow, OpenFrame compliance.

## 5. Technical Challenges & Resolutions

- **VHDL-Verilog Interop**: Resolved using GHDL-Yosys; strict separation in flows.
- **Timing Closure**: Achieved 50MHz with buffering and conservative SDC.
- **Memory Integration**: Used CF_SRAM_1024x32; fallback to smaller configs for area.
- **Verification**: Incremental tests; clean DRC/LVS via iterative OpenLane runs.
- **Software**: GCC cross-toolchain; bare-metal hello, U-Boot port; Linux in QEMU/FPGA.

Success probability was high due to proven blocks; fallbacks ensured progress.

## 6. Setup & Reproduction

### Requirements
- Python 3, LiteX, OpenLane (SKY130), Verilator/GHDL.
- Clone repos: [caravel_mgmt_soc_litex](https://github.com/chipfoundry/caravel_mgmt_soc_litex) and [microwatt_design_challenge](https://github.com/Lefteris-B/microwatt_design_challenge).

### Quick Start (Baseline)
1. `python soc_generator.py --config minimal` (generates RTL).
2. Run simulation: `verilator -cc top.v`.
3. PnR: `openlane config.tcl`.
4. Build firmware: `make hello.elf` (cross-compile).
5. CI: Check GitHub Actions for smoke tests.

Full guides in each repo's README.

## 7. Verification & CI

- **CI Flow**: .
- **Tests**: Bare-metal hello, memtest, back-annotated sims.
- **Metrics**: Timing reports, power estimates, DRC/LVS clean.

## 8. Project Vision & Impact

MicroWatt-LX lowers barriers for POWER ASICs, enabling custom chips for education and research. Deliverables are reproducible, fostering OpenPOWER growth. Future: Full Linux on ASIC, more peripherals.


