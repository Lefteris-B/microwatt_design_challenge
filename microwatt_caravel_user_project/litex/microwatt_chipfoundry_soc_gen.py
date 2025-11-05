#!/usr/bin/env python3

"""
LiteX SoC for Microwatt Core with ChipFoundry SRAM (1024x32) and UART
Designed for Caravel User Project ASIC fabrication
"""

import os
import argparse

from migen import *
from migen import Instance  # Explicitly import Instance for later use

from litex.soc.cores.clock import *
from litex.soc.integration.soc import SoCRegion
from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from litex.soc.interconnect import wishbone
from litex.soc.cores.cpu.microwatt import Microwatt
from litex.soc.cores.uart import UART, UARTWishboneBridge
from litex.soc.cores import uart

from litex.build.generic_platform import *
from litex.build.sim import SimPlatform
from litex.build.sim.config import SimConfig

# Custom SRAM Module for CF_SRAM_1024x32
class CF_SRAM_1024x32_Module(Module):
    def __init__(self, platform):
        # Create Wishbone interface
        self.bus = wishbone.Interface(data_width=32, adr_width=10)  # 10-bit word address for 1024 words
        
        # Instance parameters
        self.specials += Instance("CF_SRAM_1024x32_wb_wrapper",
            # Parameters
            p_WIDTH = 12,  # Address width parameter from wrapper
            
            # Wishbone interface
            i_wb_clk_i   = ClockSignal("sys"),
            i_wb_rst_i   = ResetSignal("sys"),
            i_wbs_stb_i  = self.bus.stb,
            i_wbs_cyc_i  = self.bus.cyc,
            i_wbs_we_i   = self.bus.we,
            i_wbs_sel_i  = self.bus.sel,
            i_wbs_dat_i  = self.bus.dat_w,
            i_wbs_adr_i  = Cat(Signal(2), self.bus.adr),  # Convert word to byte address
            o_wbs_ack_o  = self.bus.ack,
            o_wbs_dat_o  = self.bus.dat_r,
        )

# Platform definition (minimal for ASIC)
class CaravelPlatform(GenericPlatform):
    def __init__(self):
        _io = [
            # Clock and reset
            ("sys_clk", 0, Pins(1)),
            ("sys_rst", 0, Pins(1)),
            
            # UART pins for serial communication
            ("serial", 0,
                Subsignal("tx", Pins(1)),
                Subsignal("rx", Pins(1))
            ),
            
            # Caravel management wishbone interface
            ("mgmt_wb", 0,
                Subsignal("cyc", Pins(1)),
                Subsignal("stb", Pins(1)),
                Subsignal("we", Pins(1)),
                Subsignal("adr", Pins(30)),
                Subsignal("dat_w", Pins(32)),
                Subsignal("dat_r", Pins(32)),
                Subsignal("sel", Pins(4)),
                Subsignal("ack", Pins(1)),
                Subsignal("err", Pins(1)),
            ),
        ]
        GenericPlatform.__init__(self, "", _io)
    
    def build(self, fragment, **kwargs):
        # For ASIC, we generate Verilog files using the default flow
        print("Generating Verilog for ASIC integration...")
        
        # Import the verilog conversion tools
        from migen.fhdl import verilog
        import os
        
        build_dir = kwargs.get("build_dir", "build/gateware")
        build_name = kwargs.get("build_name", "top") 
        
        # Create build directory
        os.makedirs(build_dir, exist_ok=True)
        
        # Collect all IO signals for proper port declaration
        ios = set()
        signals = [
            self.lookup_request("sys_clk"),
            self.lookup_request("sys_rst"),
            self.lookup_request("serial").tx,
            self.lookup_request("serial").rx,
            self.lookup_request("mgmt_wb").cyc,
            self.lookup_request("mgmt_wb").stb,
            self.lookup_request("mgmt_wb").we,
            self.lookup_request("mgmt_wb").adr,
            self.lookup_request("mgmt_wb").dat_w,
            self.lookup_request("mgmt_wb").dat_r,
            self.lookup_request("mgmt_wb").sel,
            self.lookup_request("mgmt_wb").ack,
            self.lookup_request("mgmt_wb").err,
        ]
        for sig in signals:
            if sig is not None:
                ios.add(sig)
        
        # Convert to Verilog - let it create clock domains
        conv_output = verilog.convert(
            fragment,
            ios=ios,
            name=build_name,
            create_clock_domains=True
        )
        
        # Extract the verilog text from the conversion output
        if hasattr(conv_output, 'main_source'):
            verilog_text = conv_output.main_source
        elif isinstance(conv_output, tuple):
            verilog_text = conv_output[0]
        else:
            verilog_text = str(conv_output)
        
        # Write main Verilog file  
        verilog_file = os.path.join(build_dir, f"{build_name}.v")
        with open(verilog_file, "w") as f:
            f.write(verilog_text)
        
        print(f"Generated: {verilog_file}")
        
        # Also write out the Microwatt CPU files list
        cpu_files_list = os.path.join(build_dir, "cpu_files.txt")
        with open(cpu_files_list, "w") as f:
            f.write("# Microwatt CPU Verilog files required:\n")
            f.write("# These files should be obtained from the Microwatt repository\n")
            f.write("# after synthesis with GHDL/Yosys\n")
            f.write("microwatt.v\n")
        
        print(f"Generated: {cpu_files_list}")
        
        # Create a file list for all required Verilog files
        all_files_list = os.path.join(build_dir, "all_files.txt")
        with open(all_files_list, "w") as f:
            f.write("# All Verilog files required for this design:\n")
            f.write(f"{build_name}.v\n")
            f.write("CF_SRAM_1024x32_wb_wrapper.v\n")
            f.write("ram_controller_wb.v\n")
            f.write("microwatt.v\n")
        
        print(f"Generated: {all_files_list}")
        
        return None
    
    def do_finalize(self, fragment):
        # Add any platform-specific finalization here
        pass

# Main SoC
class MicrowattCFSRAMSoC(SoCCore):
    def __init__(self, platform, sys_clk_freq=int(50e6), 
                 uart_name="serial", uart_baudrate=115200, 
                 with_timer=True, **kwargs):
        # Disable integrated ROM/SRAM since we're using external SRAM
        kwargs["integrated_rom_size"] = 0
        kwargs["integrated_sram_size"] = 0
        kwargs["integrated_main_ram_size"] = 0
        
        # CPU configuration - Microwatt
        kwargs["cpu_type"] = "microwatt"
        kwargs["cpu_variant"] = "standard+ghdl"  # Use GHDL synthesis variant
        kwargs["cpu_reset_address"] = 0x00000000  # Start at beginning of SRAM
        
        # UART configuration
        kwargs["uart_name"] = uart_name
        kwargs["uart_baudrate"] = uart_baudrate
        
        # Handle serial_bridge case
        if uart_name == "serial_bridge":
            kwargs["with_uart"] = False  # Prevent default UART addition
        
        # Timer configuration - disable default timer if we're adding our own
        if with_timer:
            kwargs["with_timer"] = False  # Disable SoCCore's default timer
        
        # Add CRG for clock domain
        self.submodules.crg = CRG(platform.request("sys_clk"), platform.request("sys_rst"))
        
        # Create clock constraint if not already present
        if not hasattr(platform, "_clocks"):
            platform.add_period_constraint(self.crg.cd_sys.clk, 1e9/sys_clk_freq)
        
        # SoCCore initialization
        SoCCore.__init__(self, platform, sys_clk_freq,
            ident = "Microwatt CF-SRAM SoC with UART for Caravel",
            **kwargs)
        
        # Add CF SRAM at base address 0x00000000
        # 1024 words x 32 bits = 4KB
        self.submodules.cf_sram = CF_SRAM_1024x32_Module(platform)
        self.bus.add_slave("main_ram", self.cf_sram.bus, 
                          SoCRegion(origin=0x00000000, size=0x1000, cached=True))  # 4KB
        
        # Add UART bridge for loading programs via serial (optional alternative to mgmt bus)
        # This creates a debug bridge that can also be used for program loading
        if uart_name == "serial_bridge":
            self.submodules.uart_bridge = UARTWishboneBridge(
                platform.request("serial"),
                sys_clk_freq,
                baudrate=uart_baudrate
            )
            self.bus.add_master("uart_bridge", self.uart_bridge.wishbone)
        
        # Add management interface bridge (for Caravel to access SRAM)
        self.mgmt_wb = wishbone.Interface(data_width=32, adr_width=30)
        
        # Connect the external mgmt_wb signals to the interface
        mgmt_wb_pads = platform.request("mgmt_wb")
        self.comb += [
            self.mgmt_wb.cyc.eq(mgmt_wb_pads.cyc),
            self.mgmt_wb.stb.eq(mgmt_wb_pads.stb),
            self.mgmt_wb.we.eq(mgmt_wb_pads.we),
            self.mgmt_wb.sel.eq(mgmt_wb_pads.sel),
            self.mgmt_wb.adr.eq(mgmt_wb_pads.adr),
            self.mgmt_wb.dat_w.eq(mgmt_wb_pads.dat_w),
            mgmt_wb_pads.dat_r.eq(self.mgmt_wb.dat_r),
            mgmt_wb_pads.ack.eq(self.mgmt_wb.ack),
            mgmt_wb_pads.err.eq(self.mgmt_wb.err),
        ]
        
        # Connect management wishbone to the bus as a master
        self.bus.add_master("mgmt", self.mgmt_wb)
        
        # Manually add a timer if requested (avoiding duplicate)
        if with_timer:
            from litex.soc.cores.timer import Timer
            self.submodules.timer0 = Timer()
            self.add_csr("timer0")

    def do_finalize(self):
        super().do_finalize()
        # Ensure the SRAM wrapper Verilog file is included
        self.platform.add_source("CF_SRAM_1024x32_wb_wrapper.v")
        # You'll also need to add the ram_controller_wb.v and point to the SRAM GDS/LEF

# Build function
def main():
    parser = argparse.ArgumentParser(description="LiteX SoC for Microwatt with CF SRAM and UART")
    parser.add_argument("--build", action="store_true", help="Generate Verilog")
    parser.add_argument("--sys-clk-freq", default=50e6, help="System clock frequency (default=50MHz)")
    parser.add_argument("--uart-name", default="serial", help="UART type: 'serial' for console, 'serial_bridge' for loading")
    parser.add_argument("--uart-baudrate", default=115200, help="UART baudrate (default=115200)")
    parser.add_argument("--output-dir", default="build", help="Output directory for generated files")
    
    args = parser.parse_args()
    
    platform = CaravelPlatform()
    soc = MicrowattCFSRAMSoC(
        platform,
        sys_clk_freq = int(float(args.sys_clk_freq)),
        uart_name = args.uart_name,
        uart_baudrate = int(args.uart_baudrate),
    )
    
    # Build the SoC to generate all the files
    builder = Builder(soc, output_dir=args.output_dir, compile_software=False)
    
    # Generate the build files, run gateware build if --build
    builder.build(build_name="microwatt_cf_sram_soc", run=args.build)
    
    print(f"\nGenerated files in {args.output_dir}:")
    
    # Check what files were generated
    gateware_dir = os.path.join(args.output_dir, "gateware")
    if os.path.exists(gateware_dir):
        files = os.listdir(gateware_dir)
        print(f"  - Verilog files in {gateware_dir}:")
        for f in files:
            if f.endswith('.v'):
                print(f"      {f}")
    
    # Check for CSR files
    csr_csv = os.path.join(args.output_dir, "csr.csv")
    if os.path.exists(csr_csv):
        print(f"  - CSR definitions: {csr_csv}")
    
    # Generate memory initialization file format info
    print("\n" + "="*80)
    print("SRAM Memory Map:")
    print("  Base Address: 0x00000000")
    print("  Size: 4KB (1024 words x 32 bits)")
    print("  Addressing: WORD addressing (each address increment = 4 bytes)")
    print("\nPeripheral Memory Map:")
    print("  CSR Base: Check build/csr.csv for exact addresses")
    print("  UART and Timer CSRs will be mapped in the CSR region")
    print("\nUART Configuration:")
    print(f"  Type: {args.uart_name}")
    print(f"  Baudrate: {args.uart_baudrate}")
    print("  TX Pin: serial_tx")
    print("  RX Pin: serial_rx")
    print("\nLoading Instructions:")
    print("  Option 1: Use Caravel management core to write binary to SRAM via mgmt_wb interface")
    print("  Option 2: Use UART bridge mode (--uart-name=serial_bridge) for serial loading")
    print("  After loading:")
    print("    1. Assert Microwatt reset")
    print("    2. Release reset to start execution from 0x00000000")
    print("\nConsole I/O:")
    print("  The UART CSRs can be used for console output (printf, etc.)")
    print("  Configure your terminal for {} 8N1".format(args.uart_baudrate))
    print("\nRequired Files for Integration:")
    print("  1. CF_SRAM_1024x32_wb_wrapper.v (provided)")
    print("  2. ram_controller_wb.v (needs to be obtained)")
    print("  3. CF_SRAM_1024x32.gds (from ChipFoundry)")
    print("  4. Microwatt CPU Verilog files")
    print("  5. Generated Verilog from this script")
    print("\nIntegration Steps:")
    print("  1. Run with --build flag to generate Verilog")
    print("  2. Collect all Verilog files in build/gateware/")
    print("  3. Add CF_SRAM_1024x32_wb_wrapper.v to the file list")
    print("  4. Integrate with Caravel user project wrapper")
    print("="*80 + "\n")

if __name__ == "__main__":
    main()
