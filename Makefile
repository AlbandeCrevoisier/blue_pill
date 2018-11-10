AS = arm-none-eabi-as
ASFLAGS = -g -mcpu=cortex-m3

CC = arm-none-eabi-gcc
CFLAGS = -g -Os -mcpu=cortex-m3 -mthumb -Wall -Wextra -Werror -Wpedantic -std=c89

LD = arm-none-eabi-gcc
LDFLAGS = -T ld_ram.lds -nostdlib
LDLIBS = `arm-none-eabi-gcc -print-libgcc-file-name`

SRC = main.c
OBJS = crt0.o main.o

EXE = main

.PHONY: clean jl

$(EXE) : $(OBJS)

-include $(SRC:.c=.d)

%.d : %.c
	$(CC) $(CFLAGS) -MM -MF $@ -MP $<

jl :
	JLinkGDBServer -if swd -device "STM32F103C8" -LocalhostOnly

clean :
	rm -f $(OBJS)
	rm -f *.d
	rm -f $(EXE)
