#!/usr/bin/env python3
"""
Simplified LiteX SoC with MicroWatt CPU, ChipFoundry SRAM, and ChipFoundry UART
Direct Verilog generation for Caravel integration
"""

import os
import sys
import argparse
from migen import *
from migen.genlib.record import Record
from migen.fhdl import verilog

from litex.gen import *
from litex.build.generic_platform import GenericPlatform, Pins, Subsignal
from litex.soc.integration.soc_core import *
from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.builder import *
from litex.soc.interconnect import wishbone
from litex.soc.interconnect.csr import *

# Custom Memory Region for ChipFoundry SRAM
class ChipFoundrySRAM(Module):
    """
    Wrapper for ChipFoundry SRAM_1024x32 macro
    - 1024 words x 32 bits = 4KB total
    - Native Wishbone interface
    """
    def __init__(self):
        self.bus = wishbone.Interface(data_width=32, adr_width=10)  # 10 bits for 1024 words
        
        # Create instance of the ChipFoundry SRAM
        # The macro expects: clk, reset, wishbone signals
        self.specials += Instance("SRAM_1024x32",
            # Clock and Reset
            i_wb_clk_i  = ClockSignal("sys"),
            i_wb_rst_i  = ResetSignal("sys"),
            
            # Wishbone slave interface
            i_wb_adr_i  = self.bus.adr,
            i_wb_dat_i  = self.bus.dat_w,
            o_wb_dat_o  = self.bus.dat_r,
            i_wb_sel_i  = self.bus.sel,
            i_wb_we_i   = self.bus.we,
            i_wb_cyc_i  = self.bus.cyc,
            i_wb_stb_i  = self.bus.stb,
            o_wb_ack_o  = self.bus.ack,
            o_wb_err_o  = Signal(),  # Create a signal for err
        )

# Custom UART wrapper for ChipFoundry UART
class ChipFoundryUART(Module):
    """
    Wrapper for ChipFoundry CF_UART macro
    Wishbone-compatible UART peripheral
    """
    def __init__(self, pads, clk_freq=50e6, baudrate=115200):
        self.bus = wishbone.Interface(data_width=32, adr_width=3)  # Typically 8 registers max
        
        # Calculate baudrate divisor
        divisor = int(clk_freq / (baudrate * 16))
        
        # Create instance of ChipFoundry UART
        self.specials += Instance("CF_UART",
            # Clock and Reset
            i_wb_clk_i  = ClockSignal("sys"),
            i_wb_rst_i  = ResetSignal("sys"),
            
            # Wishbone slave interface
            i_wb_adr_i  = self.bus.adr,
            i_wb_dat_i  = self.bus.dat_w,
            o_wb_dat_o  = self.bus.dat_r,
            i_wb_sel_i  = self.bus.sel,
            i_wb_we_i   = self.bus.we,
            i_wb_cyc_i  = self.bus.cyc,
            i_wb_stb_i  = self.bus.stb,
            o_wb_ack_o  = self.bus.ack,
            
            # UART external signals
            i_rx        = pads.rx,
            o_tx        = pads.tx,
            
            # Configuration parameter
            p_DIVISOR   = divisor,
        )

def main():
    parser = argparse.ArgumentParser(description="MicroWatt SoC Verilog Generator")
    parser.add_argument("--output-dir", default="build", help="Output directory")
    parser.add_argument("--sys-clk-freq", default=50e6, type=float, help="System clock frequency")
    
    args = parser.parse_args()
    
    # Create output directory
    os.makedirs(args.output_dir, exist_ok=True)
    os.makedirs(os.path.join(args.output_dir, "gateware"), exist_ok=True)
    
    # Create minimal platform
    from litex.build import tools
    from litex.build.generic_platform import GenericPlatform
    
    platform = GenericPlatform("sky130", [
        ("clk", 0, Pins("wb_clk_i")),
        ("rst", 0, Pins("wb_rst_i")),
        ("serial", 0,
            Subsignal("tx", Pins("io_out_0")),
            Subsignal("rx", Pins("io_in_1")),
        ),
    ])
    
    # Create SoC with MicroWatt
    soc_kwargs = dict(
        platform           = platform,
        clk_freq           = int(args.sys_clk_freq),  # Changed from sys_clk_freq
        cpu_type           = "microwatt",
        cpu_variant        = "standard",
        cpu_reset_address  = 0x00000000,
        integrated_sram_size = 0,
        integrated_rom_size  = 0,
        uart_name           = "stub",
    )
    
    soc = SoCCore(**soc_kwargs)
    
    # Add ChipFoundry SRAM
    cf_sram = ChipFoundrySRAM()
    soc.submodules.cf_sram = cf_sram
    sram_region = SoCRegion(origin=0x00000000, size=0x1000, cached=True)
    soc.bus.add_slave(name="main_ram", slave=cf_sram.bus, region=sram_region)
    
    # Add ChipFoundry UART
    # Create dummy pads for now
    uart_pads = Record([("tx", 1), ("rx", 1)])
    cf_uart = ChipFoundryUART(uart_pads, clk_freq=args.sys_clk_freq, baudrate=115200)
    soc.submodules.cf_uart = cf_uart
    uart_region = SoCRegion(origin=0xc0000000, size=0x20, cached=False)
    soc.bus.add_slave(name="uart", slave=cf_uart.bus, region=uart_region)
    
    # Export Verilog
    # Build the SoC to generate Verilog
    from litex.build.tools import write_to_file
    from migen.fhdl.verilog import convert
    
    # Finalize the SoC
    soc.finalize()
    
    # Convert to Verilog
    verilog_text = convert(soc, ios=set(), name="microwatt_soc").main_source
    
    # Write Verilog file
    verilog_file = os.path.join(args.output_dir, "gateware", "microwatt_soc.v")
    with open(verilog_file, "w") as f:
        f.write(verilog_text)
    
    # Generate memory regions info
    mem_regions_file = os.path.join(args.output_dir, "mem_regions.txt")
    with open(mem_regions_file, "w") as f:
        f.write("Memory Regions:\n")
        for name, region in soc.bus.regions.items():
            f.write(f"{name}: 0x{region.origin:08x} - 0x{region.origin + region.size - 1:08x}\n")
    
    # Print summary
    print("\n" + "="*60)
    print("SoC Generation Complete!")
    print("="*60)
    print(f"Output directory: {args.output_dir}/")
    print(f"Main Verilog:     {verilog_file}")
    print(f"System Clock:     {args.sys_clk_freq/1e6:.1f} MHz")
    print("\nMemory Map:")
    print("-"*40)
    for name, region in soc.bus.regions.items():
        print(f"  {name:15} @ 0x{region.origin:08x} [{region.size:>8} bytes]")
    print("\nNext Steps:")
    print("1. Copy ChipFoundry SRAM and UART Verilog files")
    print("2. Create top-level wrapper for Caravel")
    print("3. Run synthesis with OpenLane")

if __name__ == "__main__":
    main()
