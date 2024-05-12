CC = gcc
CFLAGS += -m32 –Wall –g –o2 –W
AS = nasm
ASMFLAGS += -g –f elf32

all: integral

func.o: func.asm
    $(AS) $(ASMFLAGS) $< -o $@

integral: integral.c integral.h func.o
    $(CC) $(CFLAGS) $^ -lm –o $@

.PHONY: clean

clean:
    rm –rf *.o

test:
     $(AS) $(ASMFLAGS) func.asm -o func.o
     $(CC) -DTEST $(CFLAGS) integral.c –lm integral.h func.o –o integral
