CROSS_COMPILE:=aarch64-none-elf-
GDB=gdb-multiarch
include ../common/common.mk

# Tools 
QEMU	:= qemu-system-aarch64

# Qemu options 
RAM 	:= 128M
MACHINE	:= imx8mp-evk
VMLOG   := qemu.log
VMFLAGS := -serial stdio \
		   -d cpu,in_asm \
		   -display none \
		   -smp 1
VMDEBUG := -s -S 

# Build flags 
ASFLAGS := -mcpu=cortex-a53
CFLAGS 	:= -mcpu=cortex-a53 -Wall -Wextra -O0					      # For debugging ld script
LDFLAGS  = -T $*.ld -nostdlib -ffreestanding -Xlinker --build-id=none # -Xlinker --print-map -Xlinker --verbose

# TODO: Generate separate release/debug variants
# TODO: Create object build directory
ASFLAGS	+= -g
CFLAGS 	+= -g

# Targets
OBJS:= functions.o \
	   start.o
APP:=test
APP_TARGETS:=$(APP) $(APP).bin $(APP).dis

.PHONY: all, clean, debug, run
all: $(APP_TARGETS)

$(APP): $(OBJS)

clean:
	rm -rf *.o *.log .gdb_history
	rm -rf $(APP_TARGETS)

debug: $(APP).bin
	-pkill -f $(QEMU)  # Avoid creating idle qemu processes
	setsid $(QEMU) -m $(RAM) -M $(MACHINE) $(VMFLAGS) -D $(VMLOG) $(VMDEBUG) -kernel $(APP).bin & 
	$(GDB) -x $(APP)-qemu.gdb

# TODO: Add a target surrounded by an ifdef $(TERMUX) for simulating serial output on 
# a separate window. I use st (suckless simple terminal), but hardcoding this wouldn't be portable.

run: $(APP).bin
	$(QEMU) -m $(RAM) -M $(MACHINE) $(VMFLAGS) -D $(VMLOG) -kernel $<
