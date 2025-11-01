CROSS_COMPILE:=aarch64-none-elf-
GDB=gdb-multiarch
include ../common/common.mk

# Tools 
QEMU	:= qemu-system-aarch64

# Qemu options 
RAM 	:= 3G
MACHINE	:= imx8mp-evk
VMLOG   := qemu.log
VMFLAGS := -serial stdio \
		   -d cpu,in_asm \
		   -display none \
		   -smp 1
VMDEBUG := -s -S 

# Build flags 
ASFLAGS := -mcpu=cortex-a53
CFLAGS 	:= -mcpu=cortex-a53 -Wall -Wextra
LDFLAGS  = -T $*.ld -nostdlib -ffreestanding -Xlinker --build-id=none

# TODO: Generate separate release/debug variants
ASFLAGS	+= -g
CFLAGS 	+= -g

APP:=test
APP_TARGETS:=$(APP) $(APP).bin $(APP).dis

.PHONY: all
all: $(APP_TARGETS)

$(APP): start.o

.PHONY: clean
clean:
	rm -rf *.o *.log .gdb_history
	rm -rf $(APP_TARGETS)

debug: $(APP).bin
	-pkill -f $(QEMU)  # Avoid creating idle qemu processes
	$(QEMU) -m $(RAM) -M $(MACHINE) $(VMFLAGS) -D $(VMLOG) $(VMDEBUG) -kernel $(APP).bin &
	$(GDB) -x $(APP)-qemu.gdb

# TODO: Add a target surrounded by an ifdef $(TERMUX) for simulating serial output on 
# a separate window. I use st (suckless simple terminal), but hardcoding this wouldn't be portable.

run: $(APP).bin
	$(QEMU) -m $(RAM) -M $(MACHINE) $(VMFLAGS) -D $(VMLOG) -kernel $<
