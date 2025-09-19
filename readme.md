# Microwatt + LiteX Parameterized SoC with Plug-in Hardware Accelerators

Project Proposal: The MicroWatt-LX SoC Platform
An Extensible, Open-Source SoC Framework for the Microwatt POWER CPU, enabling rapid accelerator integration on the SKY130 process.

![alt text](https://img.shields.io/badge/License-MIT-yellow.svg) 
![alt text](https://img.shields.io/badge/CPU-Microwatt%20POWER-blue)
![alt text](https://img.shields.io/badge/Framework-LiteX-orange)
![alt text](https://img.shields.io/badge/PDK-SKY130-green)
## 1. Project Summary
This project proposes the creation of MicroWatt-LX, a flexible and parameterizable System-on-Chip (SoC) platform built by integrating the Microwatt POWER CPU core into the powerful LiteX SoC builder framework.

The core innovation is a standardized "accelerator socket" on the SoC bus, allowing developers to easily plug-in custom hardware accelerators.

To prove the concept, this project will deliver a complete, open-source hardware/software implementation of a FIR filter accelerator.

As a stretch goal, a second, more advanced TinyML accelerator will be implemented, demonstrating the platform's power and flexibility. The entire project will target the SKY130 process node and be fully reproducible using an open-source toolchain (GHDL, Yosys, Verilator, OpenLane).

## 2. Core Idea & Value Proposition
The primary goal of this project is not just to create a single-purpose design, but to build a reusable and extensible platform that empowers the open-source hardware community. By combining Microwatt's robust, open-ISA VHDL core with LiteX's Python-based agility, we can create a powerful foundation for future projects.

The key value propositions are:

- **Flexibility**: Users can easily configure the SoC (add/remove peripherals, change memory maps) through simple Python scripts.
- **Extensibility**: The documented accelerator socket provides a clear path for anyone to add their own custom hardware, from simple DSP blocks to complex ML engines.
- **Reproducibility**: A fully open-source flow from RTL to GDSII ensures that anyone can replicate, verify, and build upon this work.
- **Lowering the Barrier to Entry**: Provides a verified starting point for complex Microwatt-based SoC designs, saving developers weeks of initial setup and integration effort.
## 3. Alignment with Hackathon Constraints

This project is designed from the ground up to meet and exceed all hackathon requirements:

- Must use the Microwatt CPU core: Microwatt is the central processing unit of the proposed SoC.
- Implementable on ChipFoundry OpenFrame: The design will be synthesized and placed-and-routed for a generic OpenFrame-compatible tile.
- Target SKY130 with an open-source flow: The entire flow will use GHDL (for VHDL support), Yosys, and OpenLane to target the SKY130 PDK.
- Deliverables: The project will produce all required deliverables, including RTL (VHDL), testbenches, LiteX build scripts, C drivers/demos, STA/SDF constraints (via OpenLane), comprehensive documentation, and a final video.
- AI Prompt Logs: All interactions with AI assistants for brainstorming and development will be logged and submitted.
## 4. Proposed Architecture

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

- CPU: The unmodified Microwatt VHDL core.
- SoC Framework: LiteX will be used to generate the SoC interconnect, memory controllers, and peripheral logic. Microwatt will be wrapped as a blackbox VHDL entity within the LiteX Migen Python environment.
- Accelerator Socket: A pre-defined memory-mapped region on the Wishbone bus with a simple protocol for control registers and data FIFOs. This creates the "plug-in" slot.
- Initial Accelerator: A parameterizable FIR filter that connects to the accelerator socket.
## 5. Project Plan & Deliverables
This project follows a structured, de-risked approach with a clear minimum viable product and high-impact stretch goals.
Core Deliverables (Guaranteed)

1. Microwatt-LiteX Integration: A stable, working integration of the Microwatt CPU into a LiteX SoC.
2. Generic Accelerator Socket: A well-documented hardware and software interface for adding new accelerators.
3. FIR Filter Accelerator:
  - VHDL RTL for the accelerator.
  - LiteX wrapper for integration.
  - C drivers and a demo application showing the filter processing a sample waveform.
4. Complete OpenLane Flow: Scripts and configurations to take the SoC from Verilog to GDSII on SKY130.
5. Documentation & Demo: A detailed README.md, architectural diagrams, and a video demonstrating the functioning SoC and the ease of integration.
### Stretch Goals (If time permits)
- TinyML Accelerator: Implementation of a second accelerator for a simple ML kernel (e.g., matrix-vector multiplication) using the same socket.
- Advanced Verification: Formal verification of the accelerator socket interface or co-simulation with a physical sensor model.
## Timeline
- Week 1: Foundation & Integration. Achieve "Hello, World!" from the Microwatt core running in a simulated LiteX SoC. This is the highest-risk task and is prioritized first.
- Week 2: Minimum Viable Product. Implement and integrate the FIR filter accelerator and the C demo application. At the end of this week, the project will be "complete" and submittable.
- Week 3: Stretch Goal or Polish. Go/No-Go decision. Begin the ML accelerator if progress is solid. Otherwise, focus on extensive testing, documentation, and starting the physical design flow early.
- Week 4: Finalization. Run the final design through the OpenLane flow, record the demo video, and finalize all documentation and deliverables.

## Project Vision & Impact
This project is founded on the principle that open, accessible technology is a catalyst for innovation and education. While its immediate goal is to deliver a robust technical solution for the hackathon, its long-term vision is to empower a new wave of open-silicon development.
### For the Hackathon: 
This proposal is meticulously designed to excel within the contest's framework. It represents a "sweet spot" of ambition and achievability, balancing three key areas:
- Technical Depth: The integration of a VHDL-based CPU into the LiteX framework and the creation of custom hardware accelerators showcases significant hardware and software engineering skill.
- Flawless Reproducibility: By committing to a 100% open-source toolchain (Microwatt, LiteX, OpenLane, SKY130), the project ensures that its results can be verified, trusted, and built upon by anyone.
- Compelling Demonstration: The platform-based approach, with a working FIR filter and a clear path for future expansion, provides a dynamic and forward-looking story that is far more impactful than a simple, single-purpose demo.
### For the Community: A Foundation for Future Innovation
This project's most valuable contribution is not a single GDSII file, but a reusable and extensible platform. The MicroWatt-LX SoC is designed to be a "launchpad" for the open-source hardware community, lowering the significant barrier to entry for creating custom silicon. By providing a verified, well-documented starting point, this work will save other developers countless hours of setup and integration, allowing them to focus on their unique innovations—be it in DSP, AI, security, or IoT. Our goal is to foster a collaborative ecosystem around the Microwatt core on modern, agile platforms.
#### For a Better World: Aligning with United Nations Sustainable Development Goals (SDGs)
Open-source hardware is a powerful force for democratizing technology, making it a key enabler for tackling global challenges. This project directly contributes to an environment where the following United Nations 

Sustainable Development Goals can be advanced:

- **SDG 4**: Quality Education: By providing a completely free, open, and powerful SoC platform, this project gives students, educators, and researchers worldwide a tangible tool for learning state-of-the-art digital design and computer architecture without the cost of commercial licenses or proprietary hardware.
- **SDG 9**: Industry, Innovation, and Infrastructure: We foster innovation by enabling startups, small businesses, and researchers in emerging economies to design their own custom chips. This builds resilient infrastructure and supports sovereign technological capability, freeing innovators from dependence on restrictive and expensive foreign IP.
- **SDG 17**: Partnerships for the Goals: The very nature of this open-source project is an act of global partnership. It invites collaboration from a diverse community of engineers and scientists, creating a shared resource that transcends corporate and national boundaries to advance technology for all.

In summary, the MicroWatt-LX platform is more than an entry for a contest; it is a deliberate step towards a more open, equitable, and innovative technological future.