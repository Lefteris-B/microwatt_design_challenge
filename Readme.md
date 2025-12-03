# MicroWatt-LX SoC Generator: An Open-Source, Python-Driven POWER ASIC Platform

## Final Submission for ChipFoundry Microwatt Hackathon

[![License](https://img.shields.io/badge/License-APACHE2.0-yellow.svg)](https://github.com/Lefteris-B/microwatt_design_challenge/blob/main/license.md) 
[![CPU](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)](https://git.openpower.foundation/cores/microwatt)
[![Framework](https://img.shields.io/badge/Framework-LiteX-orange)](https://github.com/enjoy-digital/litex)
[![PDK](https://img.shields.io/badge/PDK-SKY130-green)](https://skywater-pdk.readthedocs.io/en/main/index.html)
[![CI - Smoke](https://img.shields.io/badge/CI-SMOKE%20TEST-green)](https://github.com/Lefteris-B/microwatt_design_challenge/actions/workflows/ci-smoke.yml)

<div align="center">
<img src="Documentation/images/gen_img.jpeg" alt="MicroWatt-LX" width="430" /></div>

## 1. Project Summary

This final submission presents **MicroWatt-LX**, an extensible, open-source framework for generating parameterizable SoCs based on the [Microwatt](https://git.openpower.foundation/cores/microwatt) POWER CPU and [LiteX](https://github.com/enjoy-digital/litex) ecosystem, targeted at the [SKY130 PDK ](https://skywater-pdk.readthedocs.io/) using [ChipFoundry's Caravel User Project and OpenFrame](https://chipfoundry.io/soc_platforms). The project delivers a Python-driven pipeline that transforms simple configurations into *tapeout-ready ASICs*, complete with tested peripherals and a documented flow.

Full project [here](https://github.com/Lefteris-B/caravel_user_project_microwatt_hackathon).

## 2. Achievements & Value Proposition

### From Proposal to Implementation

The original proposal outlined a **reusable SoC generator** to bridge the gap in open POWER ASICs. This submission realizes that vision by:
- Integrating Microwatt into LiteX for seamless Python-based configuration.
- Providing ASIC-verified peripherals, including ChipFoundry's SRAM and UART.
- Demonstrating end-to-end flows: simulation, FPGA emulation, and OpenLane PnR for SKY130.
- Enabling community contributions through modular designs and CI pipelines.

```mermaid
mindmap
  root((Microwatt<br/>CF-SRAM<br/>SoC))
    CPU
      Microwatt Core
        64-bit POWER ISA
        standard+ghdl variant
        FPU & MMU
      Reset Address
        0x00000000
    Memory
      CF SRAM
        4KB Total
        1024 words × 32 bits
        Word Addressing
        ChipFoundry Macro
      Address Range
        0x00000000-0x00000FFF
        Cached Region
    Clock
      Frequency
        50 MHz default
        Conservative target
      CRG
        Clock Reset Generator
        sys clock domain
    Interconnect
      Wishbone Bus
        32-bit data
        LiteX-managed
        Arbiter + Decoder
      Masters
        Microwatt CPU
        Management Interface
        UART Bridge optional
      Slaves
        CF SRAM
        UART CSRs
        Timer CSRs
    Peripherals
      UART
        115200 baud 8N1
        TX/RX
        Console I/O
        CSR Interface
      Timer0
        Programmable Timer
        CSR Interface
    External
      Caravel Interface
        Management WB
        30-bit address
        32-bit data
      Serial Port
        UART TX/RX pins
        Program Loading
        Debug Output
```

### Key Deliverables
- **Reusable Generator**: Python scripts in both repos generate SoCs with configurable memory, peripherals, and extensions.

- **Profiles Implemented**:
  - **(A) Baseline**: Microwatt + 32KB SRAM + UART. Fully PnR'd, precheck-validated, boots and runs bare-metal scripts via UART in simulation.
  - **(B) Caravel User Project (PoC)**: Configured for ChipFoundry OpenFrame (padframe + power straps). Compliant with shuttle requirements.
  - **(C) OpenFrame Build (Caravel Management SoC with Litex)**: Developed a script to seamlessly replace the VexRiscv core with Microwatt. Adapted the overall workflow to support the new CPU core, ensuring compatibility and optimized integration.


- **Verification**:  Conducted Verilator simulations, back-annotated timing analysis, and achieved clean DRC/LVS reports. Implemented smoke CI tests (currently in beta). Leveraged Vivado and LiteX to generate bitstreams, validating the overall flow and CPU code. Developed and successfully loaded binaries to the core, demonstrating functionalities such as:
  -  A C "hello world" application,
  -   A C program displaying animated ASCII art, 
  -   A hw control program that renders user-input numbers on FPGA LEDs.

      - Binaries are located: [/microwatt_caravel_user_project/bin_demos/](/microwatt_caravel_user_project/bin_demos/).
      - Header files and linker scripts are located : [/microwatt_caravel_user_project/C_headers_for_binaries/](/microwatt_caravel_user_project/C_headers_for_binaries/).
      - Litex Generator is located at [/microwatt_mgmt_soc_litex/litex/](/microwatt_mgmt_soc_litex/litex/).



- **Documentation**: Step-by-step guides for reproduction, including tool versions and artifacts inside the [documentation](/Documentation/) folder:
  - [**(A) Baseline**](/Documentation/Baseline_guide.md)
  - [**(B) Caravel User Project (PoC)**](/Documentation/Caravel_User_Project_(PoC).md)
  - [**(C) OpenFrame Build (Caravel Management SoC with Litex)**](/Documentation/OpenFrame_Build_(Caravel_Management_SoC_with_Litex).md)

## Video Demonstrations

I have included demonstration videos that verify my design’s ability to build a microwatt core, generate the bitstream required to simulate FPGA digital functionality, and execute binary code and memory tests . Confirming the full functional verification of my work for the hackathon

- [Verilog generation and FPGA bitstream upload (Digilent Nexys 4 100T-xc7a100t)](https://www.youtube.com/watch?v=KdZCAlcoooA)
- [Core simulation running LiteX BIOS and UART connection](https://www.youtube.com/watch?v=4e1k-80p-Ws)

- [Full presentation with FPGA board](https://www.youtube.com/watch?v=lMUG94aeTvE)
  - Here you can see the above presentation with a view of the [FPGA with Microwatt cpu core running baremetal binary demos](https://youtu.be/S7pRFUOgxYI)
### Value Proposition
- **Python-to-Silicon Simplicity**: Users configure SoCs in Python, focusing on innovations like accelerators instead of low-level integration.
- **ASIC-Ready Library**: Open collection of POWER-compatible peripherals for SKY130, using ChipFoundry macros for reliability.
- **Community Impact**: OpenFrame compatibility fosters OpenPOWER ASIC collaboration, education, and research.

## 3. Implemented Architecture

The MicroWatt-LX SoC uses a Wishbone bus managed by LiteX, with Microwatt as the core CPU.
###  Architecture Overview

```mermaid
graph TB
    subgraph External["🌐 External Interfaces"]
        CLK[Clock<br/>50MHz]
        RST[Reset]
        SERIAL[Serial UART<br/>TX/RX<br/>115200 baud]
        MGMT[Caravel Management<br/>Wishbone Interface<br/>30-bit addr / 32-bit data]
    end
    
    subgraph SoC["Microwatt CF-SRAM SoC"]
        CRG[Clock Reset<br/>Generator]
        
        subgraph CPU_BLOCK["CPU Block"]
            MICROWATT[Microwatt CPU<br/>64-bit POWER ISA<br/>standard+ghdl variant]
        end
        
        subgraph BUS["LiteX Wishbone Bus"]
            WB_ARBITER[Wishbone Arbiter<br/>& Interconnect]
        end
        
        subgraph MEMORY["Memory Subsystem"]
            SRAM_WRAP[CF_SRAM_1024x32<br/>Wishbone Wrapper]
            SRAM[ChipFoundry SRAM<br/>4KB<br/>1024 words × 32 bits<br/>@ 0x00000000]
        end
        
        subgraph PERIPHERALS["Peripherals"]
            UART_CORE[UART<br/>Console I/O<br/>CSR Interface]
            TIMER[Timer0<br/>CSR Interface]
            CSR[CSR Bus<br/>Control/Status Regs]
        end
        
        subgraph BRIDGES["Bus Bridges"]
            MGMT_BR[Management<br/>WB Bridge]
            UART_BR[UART WB Bridge<br/>optional]
        end
    end
    
    CLK --> CRG
    RST --> CRG
    CRG --> MICROWATT
    CRG --> WB_ARBITER
    
    MICROWATT <-->|Master| WB_ARBITER
    MGMT -->|External Master| MGMT_BR
    MGMT_BR -->|Master| WB_ARBITER
    SERIAL <--> UART_BR
    UART_BR -->|Master<br/>Program Loading| WB_ARBITER
    
    WB_ARBITER <-->|Slave| SRAM_WRAP
    SRAM_WRAP <--> SRAM
    WB_ARBITER <-->|Slave| CSR
    CSR --> UART_CORE
    CSR --> TIMER
    SERIAL <--> UART_CORE
    
    style MICROWATT fill:#e1f5ff
    style SRAM fill:#ffe1e1
    style WB_ARBITER fill:#fff4e1
    style UART_CORE fill:#e1ffe1
    style TIMER fill:#e1ffe1
    style MGMT_BR fill:#f0e1ff
    style UART_BR fill:#ffe1f0
```


### Placememt
<div align="center">
<img src="Documentation/images/caravel_layout.png" alt="MicroWatt-LX" width="600" /></div>

Macros grouped for routing efficiency; power straps every 50-200µm.
### Caravel Integration flow
```mermaid
graph TB
    subgraph CARAVEL["🏛️ Caravel SoC"]
        MGMT_CORE[Management Core<br/>PicoRV32]
        MGMT_BUS[Management<br/>Wishbone Bus]
    end
    
    subgraph USER_PROJECT["User Project Area"]
        subgraph MICROWATT_SOC["Microwatt SoC"]
            CPU[Microwatt<br/>POWER CPU]
            RAM[CF SRAM<br/>4KB]
            UART[UART]
            TIMER[Timer]
            SOC_BUS[LiteX Wishbone Bus]
        end
        
        MGMT_IF[Management<br/>WB Interface<br/>30-bit addr<br/>32-bit data]
    end
    
    subgraph IO_PADS["I/O Pads"]
        UART_PADS[UART TX/RX]
        CLK_PAD[Clock]
        RST_PAD[Reset]
    end
    
    MGMT_CORE --> MGMT_BUS
    MGMT_BUS -->|Program Loading<br/>Debug Access| MGMT_IF
    MGMT_IF -->|Master| SOC_BUS
    
    CPU -->|Master| SOC_BUS
    SOC_BUS --> RAM
    SOC_BUS --> UART
    SOC_BUS --> TIMER
    
    UART <--> UART_PADS
    CLK_PAD --> CPU
    RST_PAD --> CPU
    
    style MGMT_CORE fill:#fff4e1
    style CPU fill:#e1f5ff
    style RAM fill:#ffe1e1
    style UART fill:#e1ffe1
    style TIMER fill:#e1ffe1
    style MGMT_IF fill:#f0e1ff
```

### System Components

| Component | Specification | Implementation | Benefits |
|-----------|---------------|----------------|----------|
| CPU Core | 64-bit POWER ISA | Unmodified Microwatt VHDL | FPGA-proven, MMU/FPU support |
| Memory System | 32KB-1MB SRAM | ChipFoundry CF_SRAM_1024x32 macros | Production-grade, characterized |
| Interconnect | Wishbone Bus | LiteX-generated, ASIC-optimized | Mature, documented |
| Peripherals | UART, SPI, GPIO, Timers | ChipFoundry CF_UART + LiteX IP | ASIC-verified drivers |
| Extension | Custom slot | Documented Wishbone interface | For other peripherals |

- **Target Specs**: 50 clock, <100mW power @ 50MHz.


## 4. Implementation & Timeline Recap

Followed the proposed timeline with adjustments:
- **Weeks 1-2**: RTL integration (Microwatt into LiteX/Caravel), simulation, CI setup.
- **Weeks 3-4**: PnR iterations, timing closure, OpenFrame mapping.
- **Weeks 5-6**: DRC/LVS fixes, emulation demos, documentation.

All milestones achieved: Baseline RTL/sim, ASIC flow

## 5. Technical Challenges & Resolutions

- **VHDL-Verilog Interop**: Resolved using GHDL-Yosys; strict separation in flows.
- **Timing Closure**: Achieved 50MHz with buffering and conservative SDC.
- **Memory Integration**: Used CF_SRAM_1024x32; fallback to smaller configs for area.
- **Verification**: Incremental tests; clean DRC/LVS via iterative OpenLane runs.
- **Software**: GCC cross-toolchain; bare-metal hello, Linux in FPGA.

Success probability was high due to proven blocks; fallbacks ensured progress.

## 6. Setup & Reproduction

### Requirements
- Python 3
- [LiteX](https://github.com/enjoy-digital/litex),
- [Caravel](https://github.com/chipfoundry/caravel_user_project)
- [OpenLane (SKY130)](https://github.com/The-OpenROAD-Project/OpenLane),
- [Verilator](https://github.com/verilator)
- [Yosys with GHDL plugin](https://github.com/YosysHQ/yosys)

Parameterizing MicroWatt + LiteX to Generate Custom PowerPC SoCs

This project demonstrates how the MicroWatt core can be fully parameterized using the LiteX SoC generator, allowing the designer to create different MicroWatt CPU variants (area-optimized, performance-oriented, FPU-enabled, MMU-less, etc.) while integrating ChipFoundry IP blocks (SRAM + UART) into a Caravel-compatible ASIC design.

###  MicroWatt Feature Parameter Mapping
You can parameterize the Microwatt core by changing these VHDL generics in **core.vhdl**:


CLI Flag | VHDL Generic | Effect
---------|-------------|-------
no-fpu | HAS_FPU=false | Disable hardware FPU
no-btc | HAS_BTC=false | Remove MMU for major area savings
log-length <n> | LOG_LENGTH=n | Change debug trace depth
icache-size <bytes> | Config via LiteX wrapper | ICACHE enable/size
dcache-size <bytes> | Config via LiteX wrapper | DCACHE enable/size

You can also shorten the multiplication tree depth from 3 -> 1 to save on ASIC space.

📝 *Cache sizes must be power-of-two ≥ 512 bytes when enabled.*

These selections are automatically encoded into the LiteX **CPU variant string** (e.g. `standard+ghdl`), which the LiteX MicroWatt wrapper maps into MicroWatt generics.

### LiteX SoC Configuration API

| Python Parameter | Value Type | Default | Description | Example Usage |
|------------------|------------|---------|-------------|---------------|
| `cpu_type` | string | `"microwatt"` | CPU core type | `cpu_type="microwatt"` |
| `cpu_variant` | string | `"standard+ghdl"` | CPU feature set | `cpu_variant="standard+ghdl+icache-512+dcache-512"` |
| `clk_freq` | integer | `50000000` | System clock frequency (Hz) | `clk_freq=50000000` |
| `cpu_reset_address` | integer | `0x00000000` | CPU reset vector address | `cpu_reset_address=0x00000000` |
| `uart_name` | string | `"stub"` | UART peripheral type | `uart_name="stub"` |


### Memory Region Configuration

| Method | Parameters | Description |
|--------|------------|-------------|
| `SoCRegion()` | `origin`, `size`, `cached` | Define memory region properties |
| `bus.add_slave()` | `name`, `slave`, `region` | Connect peripheral to bus with memory mapping |

#### How to Load Binaries

The on-chip SRAM is connected to the Wishbone bus, allowing the Caravel management SoC to preload program data before the CPU starts running. To load a binary:
1. the management core writes the program image into SRAM over Wishbone, ensuring the entry point is placed at address 0x000000.
2.  After loading is complete, asserting a CPU reset causes execution to begin directly from this base address.
3.   This enables a straightforward development flow where new firmware can be injected into SRAM without requiring external memory or re-synthesis of the design.
We provide:

- ✅ A modified LiteX Python [script](/microwatt_caravel_user_project/microwatt_chipfoundry_soc.py)
- ✅ Command-line CPU configuration parameters
- ✅ [Step-by-step](/Documentation/Caravel_User_Project_(PoC).md) ASIC flow (LiteX ➜ Caravel ➜ OpenLane hardening)


### **Full guides in [Documentation folder](/Documentation/).**

## 7. Verification & CI

- **Tests**: Bare-metal hello, memtest, back-annotated sims.
- **Metrics**: Timing reports, power estimates, DRC/LVS clean.

## 8. Full project GitHub Links:
To achieve the above, I developed **two complementary repositories**:
- **[Caravel User Project (PoC)](https://github.com/Lefteris-B/caravel_user_project_microwatt_hackathon)**: A flexible LiteX-based SoC generator framework. As a proof-of-concept (PoC), it integrates ChipFoundry's proprietary SRAM macro [](https://github.com/chipfoundry/CF_UART), enabling arbitrary SoC configurations.
- **[OpenFrame Build (Caravel Management SoC with Litex](https://github.com/chipfoundry/caravel_mgmt_soc_litex)**: Replaced the original VexRISC CPU with Microwatt while retaining the existing memory and peripherals. This provides a drop-in upgrade for POWER-based designs in the Caravel harness.

Both repositories include simulation, synthesis, and PnR flows, with demonstrations of bare-metal booting via UART. This submission aligns with the proposal's profiles: (A) Baseline, (B) Caravel User Project (PoC), and partial (C) OpenFrame Build (Caravel Management SoC with Litex)


## 9. Project Vision & Impact
MicroWatt-LX is more than a contest submission, it's a reusable POWER ASIC starter kit that:

-  Lowers barriers for education, startups, and research
-  Advances OpenPOWER by enabling custom chip designs
-  Provides reproducibility through comprehensive documentation
-  Enables future projects as a proven foundation

Our vision is to turn one contest submission into a platform that accelerates many future POWER ASIC projects.