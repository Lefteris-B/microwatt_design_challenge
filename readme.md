# The MicroWatt-LX SoC Generator: An Open-Source, Python-Driven POWER ASIC Platform
## Complete Open-Source [Microwatt](https://git.openpower.foundation/cores/microwatt) + [LiteX](https://github.com/enjoy-digital/litex) Parameterized SoC Implementation for ChipFoundry OpenFrame


### **Project Proposal:**
#### **The MicroWatt-LX SoC Generator**

An extensible, open-source framework built on Microwatt and LiteX to create parameterizable SoCs on SKY130, with a library of already-tested peripherals and a documented ASIC flow.

![alt text](https://img.shields.io/badge/License-APACHE2.0-yellow.svg) 
![alt text](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)
![alt text](https://img.shields.io/badge/Framework-LiteX-orange)
![alt text](https://img.shields.io/badge/PDK-SKY130-green)
## 1. Project Summary
This project builds on the existing integration of Microwatt into LiteX to deliver MicroWatt-LX: a fully-documented, ASIC-ready SoC generator.

## 2. Core Idea & Value Proposition

### From CPU Integration → Reusable SoC Generator

Microwatt provides an open POWER CPU, but building a full ASIC SoC remains challenging due to manual integration, memory wiring, and flow debugging. Proprietary POWER options are costly and closed, while RISC-V thrives with generators like Chipyard. MicroWatt-LX bridges this gap by transforming Microwatt + LiteX into a reusable, Python-configurable ASIC platform with tested peripherals and OpenFrame compatibility.

### Key Values:

- **Python-to-Silicon Pipeline:** LiteX enables rapid SoC configuration, letting users focus on innovations like custom accelerators rather than bus or memory details.
- **ASIC-Verified Peripherals**: First library of production-ready IP for POWER SoCs, using LiteX blocks and ChipFoundry SRAM macros.
- **Community Enablement:** OpenFrame-ready template for shuttles, education, and research, fostering OpenPOWER ASIC collaboration.
- **Hackathon Fit:** Demonstrates Microwatt's potential in open computing, with extensions for useful integrations (e.g., sensor interfaces).
### OpenFrame-Ready POWER Platform (Stretch Goal)

As a stretch goal, we package MicroWatt-LX as the first OpenFrame-ready POWER template, enabling:

- Reusable POWER shuttle submissions
- Standardized platform for research and education
- Shared community infrastructure for future POWER designs

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
│  │ (128KB-1MB) │             │(UART/SPI/  │   Accelerators)     │ │
│  │             │             │ GPIO/Timer)|                     │ │
│  └─────────────┴─────────────┴────────────┴─────────────────────┘ │
└───────────────────────────────────────────────────────────────────┘
```
### **System Component Specifications**

| Component | Specification | Implementation | Benefits |
|-----------|---------------|----------------|----------|
| CPU Core | 64-bit POWER ISA | Unmodified Microwatt VHDL | Proven, Linux-capable, FPU+MMU |
| Memory System | 128k-1MB SRAM | ChipFoundry professional macros | Production-grade, characterized |
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
- **Memory Configuration:** 32-256 KB SRAM SRAM (configurable based on application)
- **Linux Capability**
- **Power Budget:** <100mW estimated @ 50MHz

#### Fallback Memory Plan:
 If large SRAM sizes exceed area budgets, the design will default to 1MB internal + external memory interface stubs, ensuring progress.
 We can also use a SPI extenal RAM. 

## 4. Implementation Timeline

### **Critical Milestones & Decision Points**

| Milestone | Week | Criteria | Go/No-Go Decision |
|-----------|------|----------|-------------------|
| Foundation Complete | 1 | SoC simulation working | Continue to implementation |
| System Integration | 2 | Linux boots successfully | Proceed with ASIC flow |
| ASIC Validation | 3 | Clean DRC/LVS results | Evaluate stretch goals |
| Platform Decision | 3 | Schedule assessment | OpenFrame platform or polish |
### **Detailed Weekly Breakdown**

| Week | Phase | Days | Objectives | Key Activities | Deliverables |
|------|-------|------|------------|----------------|--------------|
| 1 | Foundation | 1-3 | Establish core integration | Microwatt-LiteX setup<br>SRAM macro integration<br>Basic simulation | Working SoC simulation |
|  |  | 4-5 | Peripheral integration | UART, GPIO, SPI setup<br>Driver development<br>Testing framework | Basic I/O functionality |
|  |  | 6-7 | ASIC flow setup | OpenLane configuration<br>Initial synthesis<br>Constraint development | Synthesis validation |
| 2 | Implementation   | 8 -12 | System integration | Full system testing<br>Performance tuning<br>Bug fixes | Complete working system |
|  |  | 13-14 | ASIC optimization | Timing closure work<br>Power optimization<br>Multiple configs | Optimized ASIC design |
| 3 | Production | 15-17 | GDSII generation | Complete PnR flow<br>DRC/LVS validation<br>Final verification | Production GDSII |
|  |  | 18-19 | Characterization | Performance benchmarks<br>Resource analysis<br>Comparison studies | Technical metrics |
|  |  | 20-21 | Documentation | Tutorial creation<br>API documentation<br>User guides | Complete docs |
| 4 | Platform (Stretch) | 22-24 | Framework dev | User project area<br>Template creation<br>Integration tools | Platform framework |
|  |  | 25-26 | OpenFrame integration | Shuttle optimization<br>Community tools<br>Testing | Community platform |
|  |  | 27-28 | Release prep | Final validation<br>Video creation<br>Community release | Public release |

## 5. Technical Difficulties & Risk Mitigation

While MicroWatt-LX builds on proven technologies, turning them into a cohesive, parameterizable SoC generator suitable for ASIC requires navigating several technical challenges. Careful planning and fallback options are essential to ensure success.

### 5.1 Success Metrics

**Minimum Success:** The chip powers on, boots a simple firmware via UART, and can toggle GPIOs. We achieve a conservative 50MHz frequency.

**Target Success:** The chip boots Linux from SRAM to a userspace prompt. We achieve >50MHz operation.

**Stretch Success:** The SoC generator is robust, supports multiple configurations, and is packaged for easy use on future ChipFoundry shuttles.

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

- Begin with 128k SRAM macros known to be compatible
- Use ChipFoundry-provided SRAM for reliability
- Run thorough DRC/LVS checks with Magic and KLayout
- Maintain fallback to smaller internal SRAM + external memory stubs

### 5.2.5. Physical Design & Verification

DRC/LVS compliance in OpenLane can be challenging due to antenna effects, PDN design, and corner-case rule interactions.

**Mitigation Strategy**:

- Reuse proven OpenLane configurations from past SKY130 tapeouts
- Stage verification (DRC, LVS, antenna) at each checkpoint
- Allocate dedicated time for iterative fixes in physical verification

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

### 5.4 Success Probability Assessment

Despite these risks, MicroWatt-LX has a high likelihood of success because:

- **Proven Building Blocks:** Microwatt, LiteX, and SKY130 have successful prior tapeouts
- **Conservative Targets:** 50 MHz operation ensures generous timing slack
- **Incremental Validation:** Each SoC profile is tested before advancing to ASIC flow
- **Community Backing:** Active open-source ecosystems for all major components
- **Fallback Options:** Smaller configurations and external memory interfaces ensure progress

By planning for conservative success and leaving room for stretch goals, this project minimizes risk while maximizing its impact as an ASIC-ready SoC generator.

## 6. Project Vision & Impact

MicroWatt-LX is a reusable POWER ASIC starter kit, lowering barriers for education, startups, and research. It advances OpenPOWER by enabling custom chips, with deliverables (RTL, testbenches, docs) ensuring reproducibility per contest rules. Our vision is to turn one contest submission into a reusable foundation that accelerates many future projects.