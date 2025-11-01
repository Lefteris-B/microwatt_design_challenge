#!/usr/bin/env python3
"""
Simplified LiteX SoC with MicroWatt CPU, ChipFoundry SRAM, and ChipFoundry UART
Direct Verilog generation for Caravel integration
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
    """
    def __init__(self):
        self.bus = wishbone.Interface(data_width=32, adr_width=10)  # 10 bits for 1024 words
        
        # Create instance of the ChipFoundry SRAM Wishbone Wrapper
        self.specials += Instance("CF_SRAM_1024x32_wb_wrapper",
            # Wishbone interface signals
            i_wb_clk_i  = ClockSignal("sys"),
            i_wb_rst_i  = ResetSignal("sys"),
            
            i_wb_adr_i  = self.bus.adr,
            i_wb_dat_i  = self.bus.dat_w,
            o_wb_dat_o  = self.bus.dat_r,
            i_wb_sel_i  = self.bus.sel,
            i_wb_we_i   = self.bus.we,
            i_wb_cyc_i  = self.bus.cyc,
            i_wb_stb_i  = self.bus.stb,
            o_wb_ack_o  = self.bus.ack,
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
        # Use narrow address width - upper bits will be ignored by decoder
        # We only need to decode to register 0xff10, but use 8 bits for simplicity
        # This gives us 256 word addresses = 1KB region (efficient for ASIC)
        self.bus = wishbone.Interface(data_width=32, adr_width=8)
        
        # Interrupt signal
        self.irq = Signal()
        
        # Create instance of ChipFoundry UART Wishbone Wrapper
        # Port names from CF_UART_WB (note: clk_i not wb_clk_i!)
        self.specials += Instance("CF_UART_WB",
            # Clock and reset
            i_clk_i     = ClockSignal("sys"),
            i_rst_i     = ResetSignal("sys"),
            
            # Wishbone interface
            # Note: CF_UART_WB expects 16-bit address internally
            # We pass 8 bits, and it will only decode what it needs
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
    parser = argparse.ArgumentParser(description="MicroWatt SoC Verilog Generator")
    parser.add_argument("--output-dir", default="build", help="Output directory")
    parser.add_argument("--sys-clk-freq", default=50e6, type=float, help="System clock frequency")
    
    args = parser.parse_args()
    
    # Create output directory
    os.makedirs(args.output_dir, exist_ok=True)
    os.makedirs(os.path.join(args.output_dir, "gateware"), exist_ok=True)
    
    # Create minimal platform for Verilog generation (matches Caravel pins)
    platform = GenericPlatform("sky130", [
        ("clk", 0, Pins("wb_clk_i")),
        ("rst", 0, Pins("wb_rst_i")),
        ("serial", 0,
            Subsignal("tx", Pins("io_out[0]")),  # Caravel IO mapping
            Subsignal("rx", Pins("io_in[1]")),
        ),
    ])
    
    # Create SoC with MicroWatt
    soc_kwargs = dict(
        platform           = platform,
        clk_freq           = int(args.sys_clk_freq),
        cpu_type           = "microwatt",
        cpu_variant        = "standard+ghdl",
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
    # Allocate 1KB region (256 x 32-bit words) - much more ASIC-friendly
    # This covers all UART registers with partial address decoding
    uart_region = SoCRegion(origin=0xc0000000, size=0x400, cached=False)  # 1KB
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
    print("1. Install IPs: ipm install CF_SRAM_1024x32 && ipm install CF_UART")
    print("2. Ensure wrapper files are in verilog/rtl/")
    print("3. Integrate generated microwatt_soc.v into Caravel user project wrapper")
    print("4. Run OpenLane for hardening")

if __name__ == "__main__":
    main()