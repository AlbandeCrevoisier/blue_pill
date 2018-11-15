AS = arm-none-eabi-as
ASFLAGS = -g -mcpu=cortex-m3

CC = arm-none-eabi-gcc
CFLAGS = -g -Os -mcpu=cortex-m3 -mthumb -Wall -Wextra -Werror -Wpedantic -std=c89 -ffreestanding

LD = arm-none-eabi-gcc
LDFLAGS = -T ld_ram.lds -nostdlib
LDLIBS = `arm-none-eabi-gcc -print-libgcc-file-name`

SRC = main.c
OBJS = init.o crt0.o main.o

EXE = main

.PHONY: clean stlink

$(EXE) : $(OBJS)

-include $(SRC:.c=.d)

%.d : %.c
	$(CC) $(CFLAGS) -MM -MF $@ -MP $<

stlink :
	sudo openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg

clean :
	rm -f $(OBJS)
	rm -f *.d
	rm -f $(EXE)
