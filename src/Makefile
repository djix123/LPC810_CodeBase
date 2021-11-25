#
# gcc Makefile for LPC810
# Kamal Mostafa <kamal@whence.com>
#
# License: Public Domain
#

CROSS = arm-none-eabi-
CPU = -mthumb -mcpu=cortex-m0plus -MD
FPU = # -mfloat-abi=soft

FILENAME = blinky
LINKERSCRIPT = blinky.ld

BUILD_DIR = ../build

CFLAGS+= -g -Og --specs=nano.specs -ffunction-sections -fdata-sections -fno-builtin

CC = ${CROSS}gcc
LD = ${CROSS}ld
OBJCOPY = ${CROSS}objcopy
SIZE = ${CROSS}size

# use these on the $(LD) line, as needed:
LIBM = "${shell ${CC} ${CFLAGS} --print-file-name=libm.a}"
LIBC = "${shell ${CC} ${CFLAGS} --print-file-name=libc.a}"
LIBGCC = "${shell ${CC} ${CFLAGS} --print-libgcc-file-name}"

CFLAGS += $(CPU) $(FPU)
LDFLAGS += --gc-sections


INC += -I../cmsis
CFLAGS += $(INC) -D__USE_CMSIS # -DCLOCK_SETUP=1

BLINKY_OBJS = $(BUILD_DIR)/main.o \
              $(BUILD_DIR)/gpio.o \
              $(BUILD_DIR)/uart.o \
              $(BUILD_DIR)/mrt.o \
              $(BUILD_DIR)/printf.o \
              $(BUILD_DIR)/printf-retarget.o \
              $(BUILD_DIR)/system_LPC8xx.o \
              $(BUILD_DIR)/gcc_startup_lpc8xx.o

all: $(BUILD_DIR)/$(FILENAME).bin

$(BUILD_DIR)/blinky.elf: $(FILENAME).ld $(BLINKY_OBJS) Makefile | $(BUILD_DIR)
	@$(LD) -o $@ $(LDFLAGS) -T $(LINKERSCRIPT) $(BLINKY_OBJS) $(LIBGCC)
	-@echo ""
	@$(SIZE) $(BUILD_DIR)/$(FILENAME).elf

clean:
	@rm -f $(BUILD_DIR)/*.o $(BUILD_DIR)/*.d
	@rm -f $(BUILD_DIR)/$(FILENAME).elf $(BUILD_DIR)/$(FILENAME).hex $(BUILD_DIR)/$(FILENAME).bin
	@rmdir $(BUILD_DIR)

$(BUILD_DIR)/%.o : %.c  | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	-@echo ""
	-@echo "Generating $(FILENAME).hex (FlashMagic, etc.)"
	@$(OBJCOPY) --strip-unneeded -O ihex $(BUILD_DIR)/$(FILENAME).elf $(BUILD_DIR)/$(FILENAME).hex
	-@echo "Generating $(FILENAME).bin"
	@$(OBJCOPY) --strip-unneeded -O binary $(BUILD_DIR)/$(FILENAME).elf $(BUILD_DIR)/$(FILENAME).bin

$(BUILD_DIR):
	mkdir $@