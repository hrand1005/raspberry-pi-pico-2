CC = riscv32-unknown-elf-gcc
AS = riscv32-unknown-elf-as
LD = riscv32-unknown-elf-ld
GDB = riscv32-unknown-elf-gdb

TARGET = bootstrap.elf
SRCS = startup.S
OBJS = $(SRCS:.S=.o)
MEMMAP = memmap.ld

CFLAGS = -mabi=ilp32 -misa-spec=20191213 -mpriv-spec=1.12 \
		 -march=rv32ima_zicsr_zifencei_zba_zbb_zbkb_zbs -g
ASFLAGS = $(CFLAGS)
LDFLAGS = -T $(MEMMAP)

.DEFAULT_GOAL := build

all: build

run: $(TARGET)
	$(GDB) $(TARGET) -x init.gdb

console:
	openocd -s tcl \
		-f interface/cmsis-dap.cfg \
		-f target/rp2350-riscv.cfg \
		-c "adapter speed 5000"

check: $(TARGET)
	@echo Using openocd to flash and verify $(TARGET)...
	openocd -s tcl -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
		-c "adapter speed 5000" -c "program $(TARGET) verify reset exit"

build: $(TARGET)

$(TARGET): $(OBJS) $(MEMMAP)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJS)

%.o: %.S
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all run check build clean
