# Baseline Guide
### LiteX + Microwatt on Nexys-4 DDR ([Or any campatible FPGA board](https://github.com/litex-hub/litex-boards))
#### Step-by-step guide to build and run a bare-metal test

## Overview
This guide explains how to:
1. Install LiteX
2. Build a Microwatt-powered SoC for the Nexys-4 DDR board
3. Compile and load a bare‑metal application into the FPGA

---

##  Requirements
- Linux system (Ubuntu/Debian recommended)
- Xilinx Vivado installed (Artix‑7 support)
- Nexys-4 DDR FPGA board (Digilent)
- USB‑UART cable (built-in on board)

---

## 1. OS Setup
```bash
sudo apt update
sudo apt install -y git build-essential python3 python3-venv python3-pip     libffi-dev libusb-1.0-0-dev openocd python3-serial
```

---

## 2. Install LiteX
```bash
mkdir ~/litex-work && cd ~/litex-work
python3 -m venv venv
source venv/bin/activate

wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
chmod +x litex_setup.py
./litex_setup.py --init --install --user --config=standard
```

---

## 3. Clone Microwatt (Optional)
```bash
cd ~/litex-work
git clone https://github.com/antonblanchard/microwatt.git
```

---

## 4. Install PowerPC Cross‑Compiler
```bash
sudo apt install -y gcc-powerpc64le-linux-gnu binutils-powerpc64le-linux-gnu
powerpc64le-linux-gnu-gcc --version
```

---

## 5. Build LiteX for Nexys-4 DDR + Microwatt
Example command:
```bash
python3 -m litex_boards.targets.digilent_nexys4ddr     --cpu-type=microwatt     --build --load     --sys-clk-freq=75e6
```
This creates and loads the bitstream to your FPGA.

---

## 6. Bare‑Metal “Hello Microwatt” Program

Create `hello.c`:
```c
volatile unsigned int *uart = (unsigned int *)0xE0000000;
int putchar(int c) { *uart = c; return c; }
int main() {
    const char *s = "Hello Microwatt!\n";
    while (*s) putchar(*s++);
    while (1) {}
    return 0;
}
```

Compile:
```bash
TRIPLE=powerpc64le-linux-gnu
$TRIPLE-gcc -nostdlib -nodefaultlibs -march=powerpc64 -mabi=elfv2     -Ttext=0x40000000 -Wl,-N -o hello.elf hello.c
$TRIPLE-objcopy -O binary hello.elf hello.bin
```

✅ Ensure UART + RAM addresses match your LiteX `csr.csv`

---

## 7. Load & Run Program
```bash
litex_term /dev/ttyUSB0 --kernel hello.bin --speed 115200
```
OR from BIOS console:
```
bios> load hello.bin 0x40000000
bios> jump 0x40000000
```

---

## ✅ Success Output
You should see:
```
Hello Microwatt!
```

---

## Troubleshooting
| Issue | Fix |
|------|-----|
| No UART output | Check UART base address in `csr.csv` |
| Program crashes | Ensure RAM base in linker (`-Ttext=`) matches SoC |
| Build fails | Update LiteX: `./litex_setup.py --update` |
| No bitstream loaded | Remove `--load` then load with openFPGALoader or Vivado |

---

## Recommended Next Steps
- Try larger benchmarks or firmware
- Add LiteDRAM, Ethernet, or SD boot support
- Explore Microwatt Linux bring-up
