# The MicroWatt-LX SoC Generator: An Open-Source, Python-Driven POWER ASIC Platform
## Complete Open-Source [Microwatt](https://git.openpower.foundation/cores/microwatt) + [LiteX](https://github.com/enjoy-digital/litex) Parameterized SoC Implementation for ChipFoundry OpenFrame


### **Project Proposal:**
#### **The MicroWatt-LX SoC Generator**

An extensible, open-source framework built on Microwatt and LiteX to create parameterizable SoCs on SKY130, with a library of already-tested peripherals and a documented ASIC flow.

[![alt text](https://img.shields.io/badge/License-APACHE2.0-yellow.svg)](https://github.com/Lefteris-B/microwatt_design_challenge/blob/main/license.md) 
[![alt text](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)](https://git.openpower.foundation/cores/microwatt)
[![alt text](https://img.shields.io/badge/Framework-LiteX-orange)](https://github.com/enjoy-digital/litex)
[![alt text](https://img.shields.io/badge/PDK-SKY130-green)](https://skywater-pdk.readthedocs.io/en/main/index.html)
[![CI - Smoke](https://img.shields.io/badge/CI-SMOKE%20TEST-green)](https://github.com/Lefteris-B/microwatt_design_challenge/actions/workflows/ci-smoke.yml)

## 1. Project Summary
This project delivers MicroWatt-LX: a fully-documented, parameterizable SoC generator that transforms a Python configuration into a tapeout-ready POWER ASIC on SKY130, built on Microwatt and LiteX.

## 2. Core Idea & Value Proposition

### From CPU Integration → Reusable SoC Generator

Microwatt provides an open POWER CPU, but building a full ASIC SoC remains challenging due to manual integration, memory wiring, and flow debugging. Proprietary POWER options are costly and closed, while RISC-V thrives with generators like Chipyard. MicroWatt-LX bridges this gap by transforming Microwatt + LiteX into a reusable, Python-configurable ASIC platform with tested peripherals and OpenFrame compatibility.

### Key Values:

- **Python-to-Silicon Pipeline:** LiteX enables rapid SoC configuration, letting users focus on innovations like custom accelerators rather than bus or memory details.
- **ASIC-Verified Peripherals**: First library of production-ready IP for POWER SoCs, using LiteX blocks and ChipFoundry SRAM macros.
- **Community Enablement:** OpenFrame-ready template for shuttles, education, and research, fostering OpenPOWER ASIC collaboration.
### Targeted Generator Templates 
To fit contest constraints and time, we propose **three profiles from the same generator**:

### (A) Baseline
- Microwatt + 32KB ChipFoundry SRAM macro + UART  
- Fully PnR’d and precheck-validated 
- Boots baremetal “hello” via UART  

### (B) OpenFrame Build
- Same RTL configured for ChipFoundry OpenFrame user area (padframe + power straps)  
- Demonstrates OpenFrame compliance  
- Minimal extra PnR work (reuse baseline floorplan where possible)  

### (C) OpenFrame + External RAM (Linux Candidate)
- Adds LiteX external RAM controller (QSPI/PSRAM/SD)  
- U-Boot + Linux boot path demonstrated in emulation/FPGA with external RAM  
- Shows Linux capability without requiring impractically large on-chip SRAM  
## 3. Proposed Architecture

The MicroWatt-LX SoC will be constructed around a central Wishbone bus, managed by LiteX.
```code
┌───────────────────────────────────────────────────────────────────┐
│                    MicroWatt-LX ASIC Starter Kit                  │
│                                                                   │ 
│  ┌─────────────┐      ┌────────────────────────────────────────┐  │
│  │  Microwatt  │      │         LiteX SoC Framework            │  │
│  │ (POWER CPU) │◄────►│        (ASIC-Optimized Bus)            │  │
│  └─────────────┘      └─────────────┬──────────────────────────┘  │
│                                     │                             │
│  ┌─────────────┬─────────────┬──────┴─────┬─────────────────────┐ │
│  │ChipFoundry  │   Memory    │  Standard  │     Extension       │ │
│  │SRAM Macros  │ Controller  │Peripherals │   Interface (e.g.,  │ │
│  │ (32-256 KB) │             │(UART/SPI/  │   Accelerators)     │ │
│  │             │             │ GPIO/Timer)|                     │ │
│  └─────────────┴─────────────┴────────────┴─────────────────────┘ │
└───────────────────────────────────────────────────────────────────┘
```
### **System Component Specifications**

| Component | Specification | Implementation | Benefits |
|-----------|---------------|----------------|----------|
| CPU Core | 64-bit POWER ISA | Unmodified Microwatt VHDL | FPGA Proven |
| Memory System | 32KB-1MB SRAM | ChipFoundry professional macros | Production-grade, characterized |
| Interconnect | Wishbone Bus | LiteX-generated, ASIC-optimized | Mature, well-documented |
| Peripherals | UART, SPI, GPIO, Timers | LiteX standard IP blocks | Production-ready drivers | 
Extension|Custom accelerator slot|Documented interface|Future innovation

- **CPU Core:** Unmodified Microwatt VHDL (64-bit POWER ISA with FPU and MMU)
- **Memory System:** ChipFoundry professional SRAM macros with optimized controllers
- **SoC Framework:** LiteX-generated interconnect optimized for ASIC implementation
- **Peripheral Set:** Production-ready UART, SPI, GPIO, and timer modules
- **Extension Framework:** Documented interface for future accelerator integration

### Target Specifications:

- **Clock Frequency**: 50-100MHz (conservatively designed for first-pass success)
- **Memory Configuration:** 32KB - 1MB SRAM SRAM (configurable based on application)
- **Power Budget:** <100mW estimated @ 50MHz

#### Fallback Memory Plan:
 If large SRAM sizes exceed area budgets, the design will default to 32KB internal + external memory interface stubs, ensuring progress.
 We can also use a SPI external RAM. 

## 4. Implementation Timeline

### Critical Milestones

| # | Milestone | Success Criteria | Decision Point |
|------|-----------|------------------|----------------|
| 1 | Baseline RTL + Simulation | Microwatt + LiteX + 32KB SRAM boots baremetal hello over UART in simulation | Move to ASIC flow |
| 2 | Baseline ASIC Flow | OpenLane synthesis + place & route complete, clean precheck for Profile A (Quarantined Minimal) | Freeze baseline for tapeout |
| 3 | OpenFrame & External RAM | Map baseline to OpenFrame padframe; add external RAM controller; show U-Boot/Linux boot log in emulation | Stretch goals validated |
| 4 | Documentation & Submission | All artifacts (CI logs, testbenches, PnR reports, video) ready | Final contest submission |

---

### Weekly Breakdown
| Week           | Focus                                  | Objectives                                                             | Key Activities                                                                                                                 | Deliverables                                                                         |
| -------------- | -------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| **Week 1**     | Baseline RTL & Simulation              | Confirm SRAM macro; bootstrap repo & CI; smoke synth + baremetal hello | Confirm macro/license; repo + LICENSE; pin tool versions; GHDL→Yosys smoke; build `hello.elf`; basic Verilator run             | SRAM confirmation note; CI scaffold; smoke synth logs; `hello.elf`; Verilator logs   |
| **Week 2**     | ASIC flow prep (floorplan & PDN)       | Prepare floorplan/PDN; generate synthesis/netlist                      | Create floorplan + PDN notes; prepare SDC; run synthesis; triage VHDL/interop issues                                           | Floorplan image; PDN notes; SDC file; synthesis report; issue list                   |
| **Week 3**     | First-pass P\&R & verification         | Run P\&R iteration; expand test coverage; start U-Boot scaffold        | First-pass P\&R; timing report; add testbenches; conservative clock/CTS; U-Boot repo skeleton                                  | P\&R results + timing; expanded test suite; CTS plan; U-Boot skeleton                |
| **Week 4**     | Back-annotated sim & OpenFrame mapping | SDF sims for baseline; finalize padframe/pinout                        | Extract SDF; run back-annotated sims; finalize padframe pin mapping; update floorplan                                          | SDF sim logs + wave snippets; padframe mapping file; updated floorplan               |
| **Week 5**     | DRC/LVS & Linux emulation              | Clear DRC/LVS issues; demo U-Boot/Linux in emulation (stretch)         | Run DRC/LVS/antenna/IR checks; iterate fixes; prepare precheck artifacts; run Linux in QEMU/FPGA                               | DRC/LVS reports; precheck bundle; OpenLane logs; Linux boot log (emul.)              |
| **Week 6**     | Packaging & submission prep            | Package artifacts; produce demo video; verify reproduction steps       | Produce demo video/screenshots; finalize README + reproducible steps; re-run CI; create submission bundle; dry-run judge steps | Final repo + artifacts; demo video; zipped submission bundle; reproduction checklist |
| **Submission** | Final milestone                        | Upload to contest portal; confirm receipt                              | Upload bundle; capture confirmation; tag release                                                                               | Submission confirmation screenshot; GitHub release tag                               |


## 5. Technical Difficulties & Risk Mitigation

While MicroWatt-LX builds on proven technologies, turning them into a cohesive, parameterizable SoC generator suitable for ASIC requires navigating several technical challenges. Careful planning and fallback options are essential to ensure success.

### 5.1 Success Metrics

**Minimum Success:** The chip powers on, boots a simple firmware via UART, and can toggle GPIOs. We achieve a conservative 50MHz frequency.

**Target Success:** For the contest baseline we will target baremetal/U-Boot boot to UART from internal SRAM.

**Stretch Success:** The SoC generator is robust, supports multiple configurations, and is packaged for easy use on future ChipFoundry shuttles using OpenFrame. 
Linux boot is a stretch goal that requires ≥8 MB of RAM or an external DRAM interface.

## 5.2 Generator & Framework Challenges
### 5.2.1. **Parameterization Complexity**

LiteX already supports modular SoC generation, but packaging Microwatt with a broad set of tested peripherals into a reliable, user-facing generator introduces complexity. Python makes configuration easier, but coordinating multiple design options while keeping the ASIC flow stable can lead to corner-case failures.

#### **Mitigation Strategy**:

- Start with a minimal but tested configuration (Microwatt + UART + SRAM) as the baseline
- Incrementally add peripherals and verify each configuration in simulation before ASIC flow
- Provide reference “profiles” (minimal, Linux-capable, extended) to reduce user misconfigurations
### 5.2.2. VHDL–Verilog Coordination

Microwatt’s VHDL implementation must coexist smoothly within LiteX’s largely Verilog-based ecosystem, which can cause build flow complications for ASIC synthesis.

#### Mitigation Strategy:
- Use GHDL-Yosys front-end for VHDL synthesis.
- Use the maintained pythondata-cpu-microwatt repositories for VHDL wrapping.
- Maintain strict separation between VHDL and Verilog components in the build flow.
- Run comprehensive simulation before handing designs to OpenLane.

### 5.2.3.  ASIC Implementation Challenges
- **Timing Closure on SKY130**

Achieving timing closure on SKY130 is non-trivial, particularly for larger SoC configurations. Setup/hold issues, fanout, and clock distribution can all require iterative optimization.

**Mitigation Strategy:**

- Conservative first-pass target of 50 MHz to allow margin
- Incremental timing analysis and optimization (cell sizing, buffering, fanout management)
- Hierarchical timing closure for complex blocks

### 5.2.4. Memory Macro Integration

Integrating SRAM macros into SKY130 adds DRC and LVS complexity, especially with optical proximity and memory-specific design rules.

**Mitigation Strategy:**
- Use ChipFoundry-provided (proprietary) SRAM macros.
- Macros will be floorplanned adjacent to Microwatt, with explicit power tap and keepout regions. 
- We will attach early LVS/DRC runs to the CI for iteration tracking.
- Begin with 1 x 32 KB macros known to be compatible for ultra-minimal demos (e.g., blink + UART). 
- Use ChipFoundry-provided SRAM for reliability
- Run thorough DRC/LVS checks with Magic and KLayout
- Maintain fallback to smaller internal SRAM + external memory stubs

Below is a small, practical floorplan for a single-core MicroWatt-LX in SKY130 with on-chip SRAM macros and an IO/pad ring. The sketch is intentionally compact.

```Top metal / service area
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
- Group macros together in a compact rectangular block to reduce global routing and enable sharing of local word/bitline routing resources. Place the macro block on the same side of the CPU cluster as the main master bus (Wishbone/LiteX fabric) to shorten addresses and data buses.

- Mirror macros in alternating rows (standard macro-mirror practice) to ease bitline routing and reduce metal congestion.

- Leave a routing corridor between the CPU cluster and the macro block for the high-fanout address / data buses (metal1/metal2). Keep the corridor free of macro keepout layers.

  
### 5.2.5. Physical Design & Verification

DRC/LVS compliance in OpenLane can be challenging due to antenna effects, PDN design, and corner-case rule interactions.

**Mitigation Strategy**:

- Reuse proven OpenLane configurations from past SKY130 tapeouts
- Stage verification (DRC, LVS, antenna) at each checkpoint
- Allocate dedicated time for iterative fixes in physical verification
- PDN : Global M3/M4 rails; metal1/2 straps every 50–200 µm; at least 4 via columns per macro VDD pad as starting point; run IR drop.

## 5.3 System-Level Challenges
### 5.3.1 Power & Performance Balance

Keeping power <100 mW while maintaining Linux-capable performance requires careful synthesis, clock gating, and optimization.

#### Mitigation Strategy:

- Conservative power budgeting with margin
- Power-aware synthesis and PnR
- Clock gating where beneficial
- Early power estimation to guide optimization

### 5.3.2 Peripheral Integration & Verification

Multiple peripherals (UART, SPI, GPIO, timers) must interoperate reliably on the LiteX Wishbone bus. Bus arbitration and driver correctness require extensive testing.

#### Mitigation Strategy:

- Use standard LiteX peripheral IP with known software drivers
- Incremental integration (core + memory first, then add peripherals)
- Hardware/software co-verification using test programs

### Software

- Cross toolchain: gcc-powerpc64le-linux-gnu
- Baseline: baremetal hello + memtest
- Next: U-Boot port (board/microwatt_lx), defconfig, build with CROSS_COMPILE
- Stretch: U-Boot netboot to Microwatt Linux (mainline supports Microwatt)
### 5.4 Success Probability Assessment

Despite these risks, MicroWatt-LX has a high likelihood of success because:

- **Proven Building Blocks:** Microwatt, LiteX, and SKY130 have successful prior tapeouts
- **Conservative Targets:** 50 MHz operation ensures generous timing slack
- **Incremental Validation:** Each SoC profile is tested before advancing to ASIC flow
- **Community Backing:** Active open-source ecosystems for all major components
- **Fallback Options:** Smaller configurations and external memory interfaces ensure progress

By planning for conservative success and leaving room for stretch goals, this project minimizes risk while maximizing its impact as an ASIC-ready SoC generator.

## 6. Continuous Integration (CI) & Verification flow

 The repository includes a reproducible smoke CI (.github/workflows/ci-smoke.yml) that demonstrates the end-to-end minimal flow:
 - Builds a cross-compiled baremetal hello.elf (if sw/hello.c is present),
 - runs GHDL analysis and a GHDL→Yosys smoke synthesis pass on rtl/*.vhd,
 - attempts a Verilator simulation step (placeholder for a project-specific testbench). 
 
 CI uploads build artifacts (build/hello.elf) and exposes logs so reviewers can confirm synthesis, simulation and software build results directly from the GitHub Actions run.

## 7. Project Vision & Impact

MicroWatt-LX is a reusable POWER ASIC starter kit, lowering barriers for education, startups, and research. It advances OpenPOWER by enabling custom chips, with deliverables (RTL, testbenches, docs) ensuring reproducibility. Our vision is to turn one contest submission into a reusable foundation that accelerates many future projects.

MicroWatt-LX will deliver a verified, reproducible baseline SoC (Microwatt + LiteX) that boots baremetal/U-Boot from internal SRAM with UART I/O.  The repo will include smoke synthesis, simulation, software tests and SRAM/floorplan artifacts so judges can reproduce and validate the baseline.