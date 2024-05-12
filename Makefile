CC = gcc
CFLAGS += –Wall –g –o2 –W
AS = nasm
ASMFLAGS += -g –f elf32

all: integral

integral: func.o integral.o
	$(CC) $(CFLAGS) -o integral func.o integral.o $(LDLIBS)

integral.o: integral.c
	$(CC) $(CFLAGS) $< -o $@

func.o: func.asm
	nasm -f elf32 -o $@ $^

test: integral
	./$< -R 1:2:0.0:1.0:0.00001:0.448178
	./$< -R 1:3:-1.9:-1.27:0.00001:-1.82114
	./$< -R 2:3:-0.5:0:0.00001:-0.15287
	./$< -I 1:-6.0:6.0:0.00001:82.8
	./$< -I 2:0.0:2.0:0.00001:8.0
	./$< -I 3:0.0:1.0:0.00001:0.405465

clean:
	rm -rf *.o integral