# Microwatt + LiteX Parameterized SoC with Plug-in Hardware Accelerators

Project Proposal: The MicroWatt-LX SoC Platform
An Extensible, Open-Source SoC Framework for the Microwatt POWER CPU, enabling rapid accelerator integration on the SKY130 process.

![alt text](https://img.shields.io/badge/License-MIT-yellow.svg) 
![alt text](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)
![alt text](https://img.shields.io/badge/Framework-LiteX-orange)
![alt text](https://img.shields.io/badge/PDK-SKY130-green)
1. Project Summary
This project proposes the creation of MicroWatt-LX, a flexible and parameterizable System-on-Chip (SoC) platform built by integrating the Microwatt POWER CPU core into the powerful LiteX SoC builder framework.
The core innovation is a standardized "accelerator socket" on the SoC bus, allowing developers to easily plug-in custom hardware accelerators. To prove the concept, this project will deliver a complete, open-source hardware/software implementation of a FIR filter accelerator.
As a stretch goal, a second, more advanced TinyML accelerator will be implemented, demonstrating the platform's power and flexibility. The entire project will target the SKY130 process node and be fully reproducible using an open-source toolchain (GHDL, Yosys, Verilator, OpenLane).
2. Core Idea & Value Proposition
The primary goal of this project is not just to create a single-purpose design, but to build a reusable and extensible platform that empowers the open-source hardware community. By combining Microwatt's robust, open-ISA VHDL core with LiteX's Python-based agility, we can create a powerful foundation for future projects.
The key value propositions are:
Flexibility: Users can easily configure the SoC (add/remove peripherals, change memory maps) through simple Python scripts.
Extensibility: The documented accelerator socket provides a clear path for anyone to add their own custom hardware, from simple DSP blocks to complex ML engines.
Reproducibility: A fully open-source flow from RTL to GDSII ensures that anyone can replicate, verify, and build upon this work.
Lowering the Barrier to Entry: Provides a verified starting point for complex Microwatt-based SoC designs, saving developers weeks of initial setup and integration effort.
3. Alignment with Hackathon Constraints
This project is designed from the ground up to meet and exceed all hackathon requirements:
Must use the Microwatt CPU core: Microwatt is the central processing unit of the proposed SoC.
Implementable on ChipFoundry OpenFrame: The design will be synthesized and placed-and-routed for a generic OpenFrame-compatible tile.
Target SKY130 with an open-source flow: The entire flow will use GHDL (for VHDL support), Yosys, and OpenLane to target the SKY130 PDK.
Deliverables: The project will produce all required deliverables, including RTL (VHDL), testbenches, LiteX build scripts, C drivers/demos, STA/SDF constraints (via OpenLane), comprehensive documentation, and a final video.
AI Prompt Logs: All interactions with AI assistants for brainstorming and development will be logged and submitted.
4. Proposed Architecture
The MicroWatt-LX SoC will be constructed around a central Wishbone bus, managed by LiteX.
```code

+-----------------------------------------------------------------+
|                         MicroWatt-LX SoC                        |
|                                                                 |
| +----------------------+      +------------------------------+  |
| |      Microwatt       |      |         SoC Bus              |  |
| | (VHDL POWER CPU Core)|<---->|       (LiteX Wishbone)       |  |
| +----------------------+      +--------------+---------------+  |
|                                              |                  |
|       +--------------------------------------|                  |
|       |                                      |                  |
| +-----v------+    +-----------+    +---------v--------+    +----v-------------+
| | Main RAM   |<-->| LiteX DMA |<-->|   Peripherals    |    | Accelerator      |
| | Controller |    +-----------+    | (UART, SPI, etc) |    | Socket           |
| +------------+                     +------------------+    +--+---------------+
|                                                               |
|                                             +-----------------v----------------+
|                                             | FIR Filter / ML Accelerator    |
|                                             +--------------------------------+
+-----------------------------------------------------------------+
```

CPU: The unmodified Microwatt VHDL core.
SoC Framework: LiteX will be used to generate the SoC interconnect, memory controllers, and peripheral logic. Microwatt will be wrapped as a blackbox VHDL entity within the LiteX Migen Python environment.
Accelerator Socket: A pre-defined memory-mapped region on the Wishbone bus with a simple protocol for control registers and data FIFOs. This creates the "plug-in" slot.
Initial Accelerator: A parameterizable FIR filter that connects to the accelerator socket.
5. Project Plan & Deliverables
This project follows a structured, de-risked approach with a clear minimum viable product and high-impact stretch goals.
Core Deliverables (Guaranteed)
Microwatt-LiteX Integration: A stable, working integration of the Microwatt CPU into a LiteX SoC.
Generic Accelerator Socket: A well-documented hardware and software interface for adding new accelerators.
FIR Filter Accelerator:
VHDL RTL for the accelerator.
LiteX wrapper for integration.
C drivers and a demo application showing the filter processing a sample waveform.
Complete OpenLane Flow: Scripts and configurations to take the SoC from Verilog to GDSII on SKY130.
Documentation & Demo: A detailed README.md, architectural diagrams, and a video demonstrating the functioning SoC and the ease of integration.
Stretch Goals (If time permits)
TinyML Accelerator: Implementation of a second accelerator for a simple ML kernel (e.g., matrix-vector multiplication) using the same socket.
Advanced Verification: Formal verification of the accelerator socket interface or co-simulation with a physical sensor model.
Timeline
Week 1: Foundation & Integration. Achieve "Hello, World!" from the Microwatt core running in a simulated LiteX SoC. This is the highest-risk task and is prioritized first.
Week 2: Minimum Viable Product. Implement and integrate the FIR filter accelerator and the C demo application. At the end of this week, the project will be "complete" and submittable.
Week 3: Stretch Goal or Polish. Go/No-Go decision. Begin the ML accelerator if progress is solid. Otherwise, focus on extensive testing, documentation, and starting the physical design flow early.
Week 4: Finalization. Run the final design through the OpenLane flow, record the demo video, and finalize all documentation and deliverables.
6. Why This Project?
This project offers the best balance of technical merit, reproducibility, and demo appeal for a one-month hackathon. It demonstrates skills in CPU integration, hardware/software co-design, and modern SoC construction methodologies. More importantly, the platform-oriented approach creates a valuable contribution to the open-source hardware community that can live on and be extended long after the hackathon is over.