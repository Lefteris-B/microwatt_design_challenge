PACKAGES=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata bios
PACKAGE_DIRS=/home/iamme/asic_tools/litex/litex/soc/software/libc /home/iamme/asic_tools/litex/litex/soc/software/libcompiler_rt /home/iamme/asic_tools/litex/litex/soc/software/libbase /home/iamme/asic_tools/litex/litex/soc/software/libfatfs /home/iamme/asic_tools/litex/litex/soc/software/liblitespi /home/iamme/asic_tools/litex/litex/soc/software/liblitedram /home/iamme/asic_tools/litex/litex/soc/software/libliteeth /home/iamme/asic_tools/litex/litex/soc/software/liblitesdcard /home/iamme/asic_tools/litex/litex/soc/software/liblitesata /home/iamme/asic_tools/litex/litex/soc/software/bios
LIBS=libc libcompiler_rt libbase libfatfs liblitespi liblitedram libliteeth liblitesdcard liblitesata
TRIPLE=powerpc64le-linux-gnu
CPU=microwatt
CPUFAMILY=ppc64
CPUFLAGS=-m64 -mabi=elfv2 -msoft-float -mno-string -mno-multiple -mno-vsx -mno-altivec -mlittle-endian -mstrict-align -fno-stack-protector -D__microwatt__ 
CPUENDIANNESS=little
CLANG=0
CPU_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/cores/cpu/microwatt
SOC_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc
PICOLIBC_DIRECTORY=/home/iamme/asic_tools/pythondata-software-picolibc/pythondata_software_picolibc/data
PICOLIBC_FORMAT=integer
COMPILER_RT_DIRECTORY=/home/iamme/asic_tools/pythondata-software-compiler_rt/pythondata_software_compiler_rt/data
export BUILDINC_DIRECTORY
BUILDINC_DIRECTORY=/home/iamme/asic_tools/caravel_mgmt_soc_litex/litex/build/caravel_platform/software/include
LIBC_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/libc
LIBCOMPILER_RT_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/libcompiler_rt
LIBBASE_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/libbase
LIBFATFS_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/libfatfs
LIBLITESPI_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/liblitespi
LIBLITEDRAM_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/liblitedram
LIBLITEETH_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/libliteeth
LIBLITESDCARD_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/liblitesdcard
LIBLITESATA_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/liblitesata
BIOS_DIRECTORY=/home/iamme/asic_tools/litex/litex/soc/software/bios
LTO=0
BIOS_CONSOLE_FULL=1