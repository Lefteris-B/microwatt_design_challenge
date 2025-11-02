# LiteX Script and Step-by-Step Guide for MicroWatt-Based SoC

This Markdown document contains the modified Python script (microwatt_chipfoundry_soc.py) with added parameterization for MicroWatt's core.vhdl generics (e.g., enabling/disabling MMU, FPU, and small MUL/DIV). 
I've added command-line arguments to control these parameters, which are appended to the CPU variant string in a way compatible with LiteX's configuration system (based on common patterns in LiteX for other CPUs; note that not all may be fully supported in MicroWatt—verify during build).

The step-by-step guide has been updated to reflect these changes, including new usage examples.

```python
#!/usr/bin/env python3
"""
Simplified LiteX SoC with MicroWatt CPU, ChipFoundry SRAM, and ChipFoundry UART
Direct Verilog generation for Caravel integration
OPTIMIZED: Minimal/disabled instruction and data caches for reduced area
PARAMETERIZED: Added options for core.vhdl generics like MMU, FPU, small MUL/DIV
"""

import os
import argparse
from migen import *
from migen.genlib.record import Record

from litex.build.generic_platform import GenericPlatform, Pins, Subsignal
from litex.soc.integration.soc_core import *
from litex.soc.integration.soc import SoCRegion
from litex.soc.interconnect import wishbone
from litex.soc.integration.builder import *

# Custom Memory Region for ChipFoundry SRAM
class ChipFoundrySRAM(Module):
    """
    Wrapper for ChipFoundry CF_SRAM_1024x32_wb_wrapper
    - 1024 words x 32 bits = 4KB total
    - Native Wishbone interface
    - Uses wbs_* naming (Wishbone Slave standard)
    """
    def __init__(self):
        self.bus = wishbone.Interface(data_width=32, adr_width=10)  # 10 bits for 1024 words
        
        # Create instance of the ChipFoundry SRAM Wishbone Wrapper
        # IMPORTANT: Uses wbs_* prefix for data signals, wb_* for clock/reset
        self.specials += Instance("CF_SRAM_1024x32_wb_wrapper",
            # Clock and reset (wb_ prefix)
            i_wb_clk_i  = ClockSignal("sys"),
            i_wb_rst_i  = ResetSignal("sys"),
            
            # Wishbone slave interface (wbs_ prefix)
            i_wbs_adr_i  = self.bus.adr,
            i_wbs_dat_i  = self.bus.dat_w,
            o_wbs_dat_o  = self.bus.dat_r,
            i_wbs_sel_i  = self.bus.sel,
            i_wbs_we_i   = self.bus.we,
            i_wbs_cyc_i  = self.bus.cyc,
            i_wbs_stb_i  = self.bus.stb,
            o_wbs_ack_o  = self.bus.ack,
        )
        # Tie off err signal - wrapper doesn't provide it
        self.comb += self.bus.err.eq(0)

# Custom UART wrapper for ChipFoundry UART
class ChipFoundryUART(Module):
    """
    Wrapper for ChipFoundry CF_UART_WB (Wishbone wrapper)
    Wishbone-compatible UART peripheral
    """
    def __init__(self, pads, clk_freq=50e6, baudrate=115200):
        # Use 16-bit address width to access full register space
        self.bus = wishbone.Interface(data_width=32, adr_width=16)
        
        # Interrupt signal
        self.irq = Signal()
        
        # Create instance of ChipFoundry UART Wishbone Wrapper
        # Port names from CF_UART_WB (note: clk_i not wb_clk_i!)
        self.specials += Instance("CF_UART_WB",
            # Clock and reset
            i_clk_i     = ClockSignal("sys"),
            i_rst_i     = ResetSignal("sys"),
            
            # Wishbone interface
            i_adr_i     = self.bus.adr,
            i_dat_i     = self.bus.dat_w,
            o_dat_o     = self.bus.dat_r,
            i_sel_i     = self.bus.sel,
            i_we_i      = self.bus.we,
            i_cyc_i     = self.bus.cyc,
            i_stb_i     = self.bus.stb,
            o_ack_o     = self.bus.ack,
            
            # UART serial interface
            i_rx        = pads.rx,
            o_tx        = pads.tx,
            
            # Interrupt output
            o_IRQ       = self.irq,
        )
        # CF_UART_WB doesn't have err signal
        self.comb += self.bus.err.eq(0)

def main():
    parser = argparse.ArgumentParser(description="MicroWatt SoC Verilog Generator with Minimal Caches and Core Parameterization")
    parser.add_argument("--output-dir", default="build", help="Output directory")
    parser.add_argument("--sys-clk-freq", default=50e6, type=float, help="System clock frequency")
    parser.add_argument("--icache-size", default=0, type=int, 
                        help="I-Cache size in bytes (0=disable, min=512)")
    parser.add_argument("--dcache-size", default=0, type=int,
                        help="D-Cache size in bytes (0=disable, min=512)")
    # Added parameters for core.vhdl generics
    parser.add_argument("--has-fpu", action="store_true", default=False,
                        help="Enable FPU (HAS_FPU=true)")
    parser.add_argument("--has-mmu", action="store_true", default=True,
                        help="Enable MMU (HAS_MMU=true, default)")
    parser.add_argument("--no-mmu", dest="has_mmu", action="store_false",
                        help="Disable MMU (HAS_MMU=false)")
    parser.add_argument("--has-small-muldiv", action="store_true", default=True,
                        help="Enable small MUL/DIV (HAS_SMALL_MULDIV=true, default)")
    parser.add_argument("--no-small-muldiv", dest="has_small_muldiv", action="store_false",
                        help="Disable small MUL/DIV (use full MUL/DIV)")
    parser.add_argument("--log-length", default=48, type=int,
                        help="Set LOG_LENGTH generic (default=48)")
    
    args = parser.parse_args()
    
    # Create output directory
    os.makedirs(args.output_dir, exist_ok=True)
    os.makedirs(os.path.join(args.output_dir, "gateware"), exist_ok=True)
    
    # Prepare CPU variant string with cache configuration
    # MicroWatt cache parameters:
    # - icache_size: I-cache size (must be power of 2, min 512 bytes)
    # - dcache_size: D-cache size (must be power of 2, min 512 bytes)
    # Setting to 0 disables the cache
    
    cpu_variant_parts = ["standard", "ghdl"]
    
    # Add cache size parameters if non-zero
    if args.icache_size > 0:
        cpu_variant_parts.append(f"icache-{args.icache_size}")
    if args.dcache_size > 0:
        cpu_variant_parts.append(f"dcache-{args.dcache_size}")
    
    # Add core parameterization to variant
    if args.has_fpu:
        cpu_variant_parts.append("fpu")
    if not args.has_mmu:
        cpu_variant_parts.append("no-mmu")
    if not args.has_small_muldiv:
        cpu_variant_parts.append("full-muldiv")
    if args.log_length != 48:
        cpu_variant_parts.append(f"log-length-{args.log_length}")
    
    cpu_variant = "+".join(cpu_variant_parts)
    
    print(f"\nCPU Configuration:")
    print(f"  Variant: {cpu_variant}")
    print(f"  I-Cache: {'DISABLED' if args.icache_size == 0 else f'{args.icache_size} bytes'}")
    print(f"  D-Cache: {'DISABLED' if args.dcache_size == 0 else f'{args.dcache_size} bytes'}")
    print(f"  FPU: {'ENABLED' if args.has_fpu else 'DISABLED'}")
    print(f"  MMU: {'ENABLED' if args.has_mmu else 'DISABLED'}")
    print(f"  Small MUL/DIV: {'ENABLED' if args.has_small_muldiv else 'DISABLED'}")
    print(f"  LOG_LENGTH: {args.log_length}")
    
    # Create SoC with MicroWatt
    soc_kwargs = dict(
        platform           = platform,
        clk_freq           = int(args.sys_clk_freq),
        cpu_type           = "microwatt",
        cpu_variant        = cpu_variant,
        cpu_reset_address  = 0x00000000,
        integrated_sram_size = 0,  # Use external SRAM
        integrated_rom_size  = 0,  # No ROM; load via UART/debug
        uart_name          = "stub",  # Disable built-in UART
    )
    
    soc = SoCCore(**soc_kwargs)
    
    # Add ChipFoundry SRAM as main RAM
    cf_sram = ChipFoundrySRAM()
    soc.submodules.cf_sram = cf_sram
    sram_region = SoCRegion(origin=0x00000000, size=0x1000, cached=True)  # 4KB
    soc.bus.add_slave(name="main_ram", slave=cf_sram.bus, region=sram_region)
    
    # Add ChipFoundry UART
    uart_pads = platform.request("serial")
    cf_uart = ChipFoundryUART(uart_pads, clk_freq=args.sys_clk_freq, baudrate=115200)
    soc.submodules.cf_uart = cf_uart
    # Allocate 64KB region for full UART register space
    uart_region = SoCRegion(origin=0xc0000000, size=0x10000, cached=False)  # 64KB
    soc.bus.add_slave(name="uart", slave=cf_uart.bus, region=uart_region)
    
    # Finalize and export Verilog
    soc.finalize()
    
    from migen.fhdl.verilog import convert
    ios = {platform.request("clk"), platform.request("rst"), uart_pads.tx, uart_pads.rx}
    verilog_text = convert(soc, ios=ios, name="microwatt_soc")
    
    # Write Verilog file
    verilog_file = os.path.join(args.output_dir, "gateware", "microwatt_soc.v")
    with open(verilog_file, "w") as f:
        f.write(str(verilog_text))
    
    # Generate memory regions info
    mem_regions_file = os.path.join(args.output_dir, "mem_regions.txt")
    with open(mem_regions_file, "w") as f:
        f.write("Memory Regions:\n")
        for name, region in soc.bus.regions.items():
            f.write(f"{name}: 0x{region.origin:08x} - 0x{region.origin + region.size - 1:08x}\n")
    
    # Generate configuration summary
    config_file = os.path.join(args.output_dir, "soc_config.txt")
    with open(config_file, "w") as f:
        f.write("MicroWatt SoC Configuration\n")
        f.write("="*60 + "\n\n")
        f.write(f"CPU Type:           {soc_kwargs['cpu_type']}\n")
        f.write(f"CPU Variant:        {cpu_variant}\n")
        f.write(f"System Clock:       {args.sys_clk_freq/1e6:.1f} MHz\n")
        f.write(f"I-Cache Size:       {'DISABLED' if args.icache_size == 0 else f'{args.icache_size} bytes'}\n")
        f.write(f"D-Cache Size:       {'DISABLED' if args.dcache_size == 0 else f'{args.dcache_size} bytes'}\n")
        f.write(f"FPU:                {'ENABLED' if args.has_fpu else 'DISABLED'}\n")
        f.write(f"MMU:                {'ENABLED' if args.has_mmu else 'DISABLED'}\n")
        f.write(f"Small MUL/DIV:      {'ENABLED' if args.has_small_muldiv else 'DISABLED'}\n")
        f.write(f"LOG_LENGTH:         {args.log_length}\n")
        f.write(f"\nEstimated Area Savings with Disabled Caches:\n")
        f.write(f"  - Typical cache overhead: ~20-30% of CPU area\n")
        f.write(f"  - Direct memory access: All loads/stores via Wishbone bus\n")
        f.write(f"  - Trade-off: Lower performance, smaller area\n")
    
    # Print summary
    print("\n" + "="*60)
    print("SoC Generation Complete!")
    print("="*60)
    print(f"Output directory: {args.output_dir}/")
    print(f"Main Verilog:     {verilog_file}")
    print(f"Config file:      {config_file}")
    print(f"System Clock:     {args.sys_clk_freq/1e6:.1f} MHz")
    print("\nCache Configuration:")
    print(f"  I-Cache: {'DISABLED' if args.icache_size == 0 else f'{args.icache_size} bytes'}")
    print(f"  D-Cache: {'DISABLED' if args.dcache_size == 0 else f'{args.dcache_size} bytes'}")
    print("\nCore Parameters:")
    print(f"  FPU: {'ENABLED' if args.has_fpu else 'DISABLED'}")
    print(f"  MMU: {'ENABLED' if args.has_mmu else 'DISABLED'}")
    print(f"  Small MUL/DIV: {'ENABLED' if args.has_small_muldiv else 'DISABLED'}")
    print(f"  LOG_LENGTH: {args.log_length}")
    print("\nMemory Map:")
    print("-"*40)
    for name, region in soc.bus.regions.items():
        print(f"  {name:15} @ 0x{region.origin:08x} [{region.size:>8} bytes]")
    print("\nUsage Examples:")
    print("  # Disable both caches (minimum area):")
    print("  python3 microwatt_chipfoundry_soc_nocache.py")
    print("\n  # Enable minimal caches (512 bytes each):")
    print("  python3 microwatt_chipfoundry_soc_nocache.py --icache-size 512 --dcache-size 512")
    print("\n  # Enable only I-cache (1KB):")
    print("  python3 microwatt_chipfoundry_soc_nocache.py --icache-size 1024")
    print("\n  # Enable FPU and disable MMU:")
    print("  python3 microwatt_chipfoundry_soc_nocache.py --has-fpu --no-mmu")
    print("\n  # Set custom LOG_LENGTH and full MUL/DIV:")
    print("  python3 microwatt_chipfoundry_soc_nocache.py --log-length 32 --no-small-muldiv")
    print("\nNext Steps:")
    print("1. Install IPs: ipm install CF_SRAM_1024x32 && ipm install CF_UART && ipm install CF_IP_UTIL")
    print("2. Copy IP files to verilog/rtl/: cp ip/CF_SRAM_1024x32/hdl/bus_wrappers/*.v verilog/rtl/sram/")
    print("3. Integrate generated microwatt_soc.v into Caravel user project wrapper")
    print("4. Run OpenLane for hardening")
    print("\nIMPORTANT: CF_SRAM_1024x32_wb_wrapper uses 'wbs_*' port names!")
    print("NOTE: Disabled caches will reduce area but may impact performance significantly.")
    print("NOTE: Core parameters like FPU/MMU may require verification if supported in your MicroWatt version.")

if __name__ == "__main__":
    main()
```

Note on Parameterization: The added parameters map to MicroWatt's core.vhdl generics (e.g., HAS_FPU, HAS_MMU, HAS_SMALL_MULDIV, LOG_LENGTH). The variant string is extended (e.g., "+fpu", "+no-mmu") assuming LiteX's wrapper passes them as VHDL generics. If LiteX doesn't support a parameter, you may need to modify the LiteX CPU wrapper (in litex/soc/cores/cpu/microwatt/). Test the generated design to ensure compatibility.

## Step-by-Step Guide to Using the LiteX Script for MicroWatt-Based SoC Generation and Hardening

This guide walks you through using the provided Python script (microwatt_chipfoundry_soc.py) to generate a System-on-Chip (SoC) design based on the MicroWatt CPU (an open-source PowerPC-compatible processor).

 The script uses LiteX (a Python-based SoC builder) to create a minimal SoC with ChipFoundry SRAM (4KB) and UART peripherals, optimized for reduced area by disabling or minimizing instruction and data caches. Additional parameters allow customization of MicroWatt's core.vhdl generics (e.g., FPU, MMU). 
 
 The output is Verilog code suitable for integration into the Caravel user project (part of the efabless/SkyWater 130nm PDK ecosystem for ASIC prototyping).
The process involves setting up dependencies, installing required IP blocks, running the script to generate Verilog, integrating it into a Caravel wrapper, and hardening (synthesizing and place-and-route) the design using OpenLane (an open-source RTL-to-GDSII flow).

## Prerequisites

### Hardware/Software Requirements:

- A Linux-based system (Ubuntu or similar recommended for tool compatibility).
- Python 3.6+ installed.
- Git for cloning repositories.
- Basic knowledge of Verilog, SoC design, and ASIC flows.


### Tools and Environments:

- LiteX and Migen: For SoC generation.
- OpenLane: For hardening (requires Docker for easiest setup).
- Verilator or similar for simulation (optional, for verification).
- Access to the efabless Caravel framework (for integration into MPW shuttles).

##  1: Install Dependencies

### Set Up a Virtual Environment

```python
python3 -m venv litex_env
source litex_env/bin/activate
```
## 2. Install LiteX and Related Tools:
LiteX depends on Migen and other libraries. Install them via pip:
```
pip install litex migen
```

**or**

```
git clone https://github.com/enjoy-digital/litex.git
cd litex
python3 setup.py 
```

## 3. Install OpenLane:
OpenLane is used for hardening. Install it via Docker (easiest method):
textgit clone https://github.com/The-OpenROAD-Project/OpenLane.git
cd OpenLane
make openlane  # Pulls the Docker image

## 4. Test it: make test.
Ensure the Sky130 PDK is installed (OpenLane handles this via make pdk if needed).


## 5. Set Up Caravel Framework:
Caravel is the harness for user projects in efabless MPW shuttles.
```bash
git clone https://github.com/efabless/caravel_user_project.git
cd caravel_user_project
make setup  # Installs dependencies and PDK
```
This sets up the directory structure, including verilog/rtl/ for your custom RTL.

## 6. Install Required IP Blocks
The script uses ChipFoundry IPs (CF_SRAM_1024x32, CF_UART, and CF_IP_UTIL). These are third-party IP blocks for SRAM and UART with Wishbone wrappers, likely from an IP library compatible with Sky130.

- Use IP Manager (ipm):
Assuming ipm is the efabless or ChipFoundry IP manager tool (common in MPW ecosystems), install the IPs:
```bash
ipm install CF_SRAM_1024x32
ipm install CF_UART
ipm install CF_IP_UTIL
```
If ipm isn't installed, it might be part of the efabless tools. Install via `pip install efabless-ipm` or check chipfoundry's documentation.
IPs will download to an ip/ directory.


## 7. Copy IP Files to RTL Directory:
Move the Verilog files (including bus wrappers) to your project's RTL folder for integration:
```bash
mkdir -p verilog/rtl/sram
cp ip/CF_SRAM_1024x32/hdl/bus_wrappers/*.v verilog/rtl/sram/
cp ip/CF_UART/hdl/*.v verilog/rtl/  # Adjust path if needed for CF_UART_WB.v
cp ip/CF_IP_UTIL/hdl/*.v verilog/rtl/  # Utility IPs if required
```
Note: The SRAM wrapper uses wbs_* port names (Wishbone Slave standard), and the UART uses specific clock/reset naming (clk_i, rst_i).

## 8. Run the LiteX Script to Generate the MicroWatt SoC

Navigate to Your Working Directory:
```bash
 ~/projects/microwatt_soc
```

## 9. Run the Script:
The script generates Verilog for the SoC (microwatt_soc.v), memory regions info, and a config summary. Use command-line arguments to customize:

**--output-dir:** Where to save outputs (default: build).

**--sys-clk-freq:** System clock in Hz (default: 50e6, i.e., 50 MHz).

**--icache-size:** Instruction cache size in bytes (0 to disable, min 512 if enabled).

**--dcache-size:** Data cache size in bytes (0 to disable, min 512 if enabled).

**--has-fpu:** Enable FPU (default: False).

## 10. Verify Outputs:

Check build/gateware/microwatt_soc.v: The main Verilog file.
build/mem_regions.txt: Memory map (e.g., main_ram at 0x00000000, 4KB).
build/soc_config.txt: Configuration summary (CPU variant, cache sizes, core parameters).
Console output shows the memory map, cache config, and core parameters.

Notes:

- CPU variant is "standard+ghdl" .
- Disabling caches reduces area (~20-30% savings) but impacts performance (direct Wishbone bus access).
- Core parameters adjust VHDL generics; FPU/MMU may not be fully implemented in base MicroWatt—test thoroughly.
- The SoC uses external SRAM (4KB at 0x00000000) and UART (at 0xc0000000, 64KB region).



## 11. Integrate the Generated Verilog into Caravel User Project

- Copy Generated Files:
`cp build/gateware/microwatt_soc.v caravel_user_project/verilog/rtl/`
.Also copy any dependent Verilog from IPs if not already done.


- Modify Caravel User Wrapper:

Edit caravel_user_project/verilog/rtl/user_project_wrapper.v to instantiate microwatt_soc:

```verilog
//This is an example
module user_project_wrapper (
    // Caravel IOs
    inout wire [`MPRJ_IO_PADS-1:0] io_in,
    inout wire [`MPRJ_IO_PADS-1:0] io_out,
    inout wire [`MPRJ_IO_PADS-1:0] io_oeb,
    // Other signals...
);

// Instantiate your SoC
microwatt_soc u_microwatt_soc (
    .wb_clk_i(user_clock2),  // Map to Caravel clock
    .wb_rst_i(user_reset),   // Map to Caravel reset
    .io_out[0](io_out[0]),   // UART TX
    .io_in[1](io_in[1])      // UART RX
    // Map other signals as needed (e.g., interrupts if used)
);

// Tie off unused IOs
// ...
endmodule

```
- Update pin mappings: UART TX to io_out[0], RX to io_in[1] (as per script).
- Adjust clock/reset: Use Caravel's user_clock2 (50 MHz) and reset.

## 12.  Harden the Design with OpenLane

- Run OpenLane Flow:

From the Caravel user project directory:
textmake user_project_wrapper. 

This runs synthesis, place-and-route, and generates GDSII.
Monitor logs in openlane/user_project_wrapper/runs/ for errors (e.g., timing violations).


## 13. Check Results:

View reports: Area, timing, power in the run directory.
Use Magic VLSI or KLayout to view GDS: make magic or similar.
If caches or core features (e.g., FPU) are enabled, expect larger area; disabled features minimize it.

## 14. Troubleshooting

- Errors in Script Run: Ensure LiteX is installed; check cache sizes (must be power-of-2 >=512 if enabled); verify core parameters with MicroWatt docs.
- IP Installation: If ipm fails, manually download from efabless IP catalog or GitHub.
- OpenLane Issues: Ensure Docker is running; check PDK setup.
- Performance/Area Trade-offs: Disabled caches/features save area but may slow execution or limit functionality—test with software benchmarks.
- Core Parameter Support: If a parameter (e.g., FPU) causes build errors, it may not be implemented in MicroWatt; remove the flag or patch the core.
- Resources: LiteX docs (github.com/enjoy-digital/litex), OpenLane docs (github.com/The-OpenROAD-Project/OpenLane), Caravel docs (github.com/efabless/caravel), MicroWatt repo (github.com/antonblanchard/microwatt).


This process should yield a hardened, parameterized MicroWatt core ready for ASIC fabrication or FPGA emulation. If you encounter specific errors, provide details for further assistance!

