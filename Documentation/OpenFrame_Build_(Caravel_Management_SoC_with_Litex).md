# Replace the CPU in caravel_mgmt_soc_litex

Goal: Replace the management SoC CPU used by caravel_mgmt_soc_litex with a different core (for example Microwatt), keep the Litex-based peripheral/CSR setup, then harden the resulting management core with OpenLane and finalize using the existing scripts / Makefile.

## Prerequisites

- Working caravel + caravel_mgmt_soc_litex checkout.

- Python3 + Litex build deps.

- OpenLane / SkyWater PDK installed/configured for your environment.

- GHDL (or Dockerized build) if your CPU core is VHDL (Microwatt).

- Verilator (optional, for mixed sim), or a mixed VHDL/Verilog simulator.

- Familiarity with Makefiles, shell scripts, and basic RTL glue.

## 1. Repo / branch setup 

```bash
# create a workspace and branch
git clone https://github.com/caravel_mgmt_soc_litex.git

# create branches for your work
cd caravel_mgmt_soc_litex
git checkout -b feature/microwatt-mgmt
```

## 2. Edit litex/caravel.py to select the new CPU

Open litex/caravel.py (your litex entry script). There is a CPU selection area near the top of MGMTSoC.__init__ where cpu is chosen:

```python
# current in your file:
# cpu = 'picorv32'
# cpu = 'ibex'
cpu = 'vexriscv'
```

Change this to a new value and add a handling branch. Example: set cpu = 'microwatt' and add an elif cpu == 'microwatt': block. The new branch will not call SoCMini.__init__ with cpu_type="microwatt", because Litex has no built-in Microwatt support. Instead you should configure the SoC to treat the CPU as an external component and provide required memory map / bus wiring.

Below is a suggested patch snippet you can copy into litex/caravel.py (adjust paths, sizes and helper functions for your project):

```python
@@
-        # cpu = 'picorv32'
-        # cpu = 'ibex'
-        cpu = 'vexriscv'
+        # cpu = 'picorv32'
+        # cpu = 'ibex'
+        # cpu = 'vexriscv'
+        # new cpu option: microwatt (Microwatt OpenPOWER core)
+        cpu = 'microwatt'
@@
-        elif cpu == 'picorv32':
+        elif cpu == 'picorv32':
             self.mem_map = {
                 "dff": 0x00000000,
                 "sram": 0x01000000,
@@
-        else:
+        elif cpu == 'microwatt':
+            # NOTE: Microwatt is a VHDL OpenPOWER core. Litex doesn't
+            # provide a native "microwatt" cpu_type. Instead, we:
+            # 1) configure SoCMini with no internal CPU (use cpu_type=None),
+            # 2) set up memory-map and peripherals as usual,
+            # 3) instantiate the Microwatt core in a separate wrapper that
+            #    exports a memory interface compatible with the SoC,
+            # 4) ensure build scripts will package that wrapper as the
+            #    hardened mgmt_core macro.
+            self.mem_map = {
+                "dff": 0x00000000,
+                "sram": 0x01000000,
+                "flash": 0x10000000,
+                "mprj": 0x30000000,
+                "hk": 0x26000000,
+                "csr": 0x20000000,
+            }
+            # Initialize SoCMini without an integrated CPU; keep UART/timers
+            SoCMini.__init__(self, platform,
+                             clk_freq=sys_clk_freq,
+                             cpu_type=None,               # no native CPU
+                             csr_data_width=32,
+                             integrated_sram_size=0,
+                             integrated_rom_size=0,
+                             with_uart=True,
+                             uart_baudrate=9600,
+                             uart_name="serial",
+                             with_timer=True,
+                             **kwargs)
+
+            # Add any Litex-specific CPU placeholders (if needed).
+            # The Microwatt wrapper will provide the real instruction/data memory.
+            # You may add constants to indicate the core type to downstream scripts:
+            self.add_constant("MGMT_CPU_NAME", "MICROWATT")
+
+            # Important: the rest of the MGMTSoC code (GPIO, SPI, LA, etc.)
+            # can remain unchanged, but you must ensure the Microwatt wrapper
+            # is connected to the memory regions used above (flash/sram).
+
+        else:
             print("ERROR - cpu value not recognized")
             exit()
```
Explanation: this keeps Litex in control of peripherals and boot memory map, but removes the assumption that Litex will create/drive a RISC-V CPU core. The actual Microwatt core will be created and connected later using a wrapper/hardening flow.

## 3. Create the Microwatt wrapper

You must create a wrapper that:

Instantiates the Microwatt core (VHDL) and attaches its instruction and data memory ports to the SRAM macros that Litex expects (or to a memory bridge).

Implements a small glue layer exposing the minimal signals Caravel expects at the management macro boundary (power rails, clocks, reset, IO for UART / SPI / GPIO).

If the rest of your Caravel logic expects a Wishbone or LiteX bus master from the CPU, you must implement a bridge in the wrapper that converts Microwatt's memory accesses into the expected bus (or provide a memory region that Litex peripherals use).

## 4. Adjust litex build & packaging scripts

The current caravel_mgmt_soc_litex flow builds a management core artifact (a macro or wrapper) and then hardens it with OpenLane. You need to:

- Make make / build scripts call your wrapper build before harden stage.

- /build_mgmt_core_wrapper.sh 

- Produce LEF/GDS views of the hardened wrapper that the top-level Caravel assembly script will include.