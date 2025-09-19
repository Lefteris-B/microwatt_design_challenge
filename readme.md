# MicroWatt-LX ASIC Starter Kit
## Complete Open-Source [Microwatt](https://git.openpower.foundation/cores/microwatt) + [LiteX](https://github.com/enjoy-digital/litex) Parameterized SoC Implementation for ChipFoundry OpenFrame


Project Proposal: The MicroWatt-LX SoC Platform
An Extensible, Open-Source SoC Framework for the Microwatt POWER CPU, enabling rapid accelerator integration on the SKY130 process.

![alt text](https://img.shields.io/badge/License-APACHE2.0-yellow.svg) 
![alt text](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)
![alt text](https://img.shields.io/badge/Framework-LiteX-orange)
![alt text](https://img.shields.io/badge/PDK-SKY130-green)
## 1. Project Summary
This project proposes the creation of MicroWatt-LX, a flexible and parameterizable System-on-Chip (SoC) platform built by integrating the Microwatt POWER CPU core into the powerful LiteX SoC builder framework.

**Primary Innovation:** A fully-documented, reproducible pathway from concept to GDSII for POWER-based ASICs, eliminating months of integration complexity for future developers.

**Core Deliverable:** Complete starter kit with working Linux-capable SoC, comprehensive documentation, and automated toolchain setup.

**Stretch Goal:** If development proceeds ahead of schedule, expand into an OpenFrame Caravel alternative, providing a standardized POWER-based template for community shuttle submissions.

## 2. Core Idea & Value Proposition

### Primary Innovation: Complete ASIC Starter Kit
The open-source hardware community lacks a comprehensive, beginner-friendly pathway to ASIC implementation. This project eliminates that barrier by providing:

- Professional SRAM Integration: Leverages ChipFoundry's production-ready SRAM macros for real-world memory systems
- Complete ASIC Flow: End-to-end methodology from LiteX configuration to SKY130 GDSII
- POWER Architecture: First open-source ASIC starter kit for POWER ISA
- Production Capability: Linux-bootable SoC with MB-scale memory systems

The key value propositions are:

- **Flexibility**: Users can easily configure the SoC (add/remove peripherals, change memory maps) through simple Python scripts.
- **Extensibility**: The documented ASIC starter kit provides a clear path for anyone to add their own custom hardware, from simple DSP blocks to complex ML engines.
- **Reproducibility**: A fully open-source flow from RTL to GDSII ensures that anyone can replicate, verify, and build upon this work.
- **Lowering the Barrier to Entry**: Provides a verified starting point for complex Microwatt-based SoC designs, saving developers weeks of initial setup and integration effort.

## 3. Proposed Architecture

The MicroWatt-LX SoC will be constructed around a central Wishbone bus, managed by LiteX.
```code
┌─────────────────────────────────────────────────────────────────┐
│                    MicroWatt-LX ASIC Starter Kit                │
│                                                                 │
│  ┌─────────────┐      ┌────────────────────────────────────────┐ │
│  │  Microwatt  │      │         LiteX SoC Framework           │ │
│  │ (POWER CPU) │◄────►│        (ASIC-Optimized Bus)           │ │
│  └─────────────┘      └─────────────┬──────────────────────────┘ │
│                                     │                            │
│  ┌─────────────┬─────────────┬──────┴─────┬─────────────────────┐ │
│  │ChipFoundry  │   Memory    │  Standard  │     Extension       │ │
│  │SRAM Macros  │ Controller  │Peripherals │   Socket (Future    │ │
│  │ (1-16MB)    │             │(UART/SPI/  │   Accelerators)     │ │
│  │             │             │ GPIO)      │                     │ │
│  └─────────────┴─────────────┴────────────┴─────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```
### **System Component Specifications**

| Component | Specification | Implementation | Benefits |
|-----------|---------------|----------------|----------|
| CPU Core | 64-bit POWER ISA | Unmodified Microwatt VHDL | Proven, Linux-capable, FPU+MMU |
| Memory System | 1-16MB SRAM | ChipFoundry professional macros | Production-grade, characterized |
| Interconnect | Wishbone Bus | LiteX-generated, ASIC-optimized | Mature, well-documented |
| Peripherals | UART, SPI, GPIO, Timers | LiteX standard IP blocks | Production-ready drivers |

- **CPU Core:** Unmodified Microwatt VHDL (64-bit POWER ISA with FPU and MMU)
- **Memory System:** ChipFoundry professional SRAM macros with optimized controllers
- **SoC Framework:** LiteX-generated interconnect optimized for ASIC implementation
- **Peripheral Set:** Production-ready UART, SPI, GPIO, and timer modules
- **Extension Framework:** Documented interface for future accelerator integration

### Target Specifications:

- **Clock Frequency**: 50-100MHz (conservatively designed for first-pass success)
- **Memory Configuration:** 1MB to 16MB SRAM (configurable based on application)
- **Linux Capability**
- **Power Budget:** <100mW estimated @ 50MHz

## 4. Implementation Timeline

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

### **Critical Milestones & Decision Points**

| Milestone | Week | Criteria | Go/No-Go Decision |
|-----------|------|----------|-------------------|
| Foundation Complete | 1 | SoC simulation working | Continue to implementation |
| System Integration | 2 | Linux boots successfully | Proceed with ASIC flow |
| ASIC Validation | 3 | Clean DRC/LVS results | Evaluate stretch goals |
| Platform Decision | 3 | Schedule assessment | OpenFrame platform or polish |

### **Resource Allocation & Focus Areas**

| Focus Area | Time Allocation | Priority Level | Success Metrics |
|------------|----------------|----------------|-----------------|
| Core Integration | 40% (Weeks 1-2) | Critical | Working SoC simulation |
| ASIC Implementation | 35% (Weeks 2-3) | Critical | Clean GDSII output |
| Documentation | 15% (Week 3) | High | Complete tutorials |
| Platform Extension | 10% (Week 4) | Optional | Community framework |

## 5. Project Vision & Impact

### For the Hackathon:
This project is strategically designed to excel within the hackathon framework:
#### Technical Requirements:

✅ Microwatt CPU Core: Unmodified POWER core as the central processing unit

✅ ChipFoundry OpenFrame: Optimized design targeting OpenFrame platform specifications

✅ SKY130 + Open-Source Flow: Complete OpenLane toolchain from RTL to GDSII

✅ Complete Deliverables: RTL, testbenches, constraints, documentation, and demonstration video

##### Innovation & Impact:

- Technical Depth: First comprehensive POWER ASIC starter kit with professional SRAM integration
- Reproducibility: 100% open-source toolchain ensuring verifiable results
- Community Value: Infrastructure building that enables dozens of future projects
- Educational Impact: Comprehensive tutorials lowering ASIC barriers for newcomers

##### Risk Management:

- Proven Components: Leverages established Microwatt, LiteX, and SKY130 technologies
- Phased Approach: Guaranteed valuable deliverables with ambitious stretch goals
- Conservative Targets: 50MHz timing goals ensure first-pass success
- Professional Memory: ChipFoundry SRAM macros eliminate major integration risk 

### For the Community: A Foundation for Future Innovation
This project's most valuable contribution is not a single GDSII file, but a reusable and extensible platform. The MicroWatt-LX SoC is designed to be a "launchpad" for the open-source hardware community, lowering the significant barrier to entry for creating custom silicon. By providing a verified, well-documented starting point, this work will save other developers countless hours of setup and integration, allowing them to focus on their unique innovations—be it in DSP, AI, security, or IoT. Our goal is to foster a collaborative ecosystem around the Microwatt core on modern, agile platforms.
### For a Better World: Aligning with United Nations Sustainable Development Goals (SDGs)
Open-source hardware is a powerful force for democratizing technology, making it a key enabler for tackling global challenges. This project directly contributes to an environment where the following United Nations 

Sustainable Development Goals can be advanced:

- **SDG 4**: Quality Education: By providing a completely free, open, and powerful SoC platform, this project gives students, educators, and researchers worldwide a tangible tool for learning state-of-the-art digital design and computer architecture without the cost of commercial licenses or proprietary hardware.
- **SDG 9**: Industry, Innovation, and Infrastructure: We foster innovation by enabling startups, small businesses, and researchers in emerging economies to design their own custom chips. This builds resilient infrastructure and supports sovereign technological capability, freeing innovators from dependence on restrictive and expensive foreign IP.
- **SDG 17**: Partnerships for the Goals: The very nature of this open-source project is an act of global partnership. It invites collaboration from a diverse community of engineers and scientists, creating a shared resource that transcends corporate and national boundaries to advance technology for all.

In summary, the MicroWatt-LX platform is more than an entry for a contest; it is a deliberate step towards a more open, equitable, and innovative technological future.