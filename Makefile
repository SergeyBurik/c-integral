CFLAGS=-O2 -g
CFLAGS+=-std=gnu99
CFLAGS+=-Wall -Werror -Wformat-security -Wignored-qualifiers -Winit-self
CFLAGS+=-Wswitch-default -Wpointer-arith -Wtype-limits -Wempty-body
CFLAGS+=-Wstrict-prototypes -Wold-style-declaration -Wold-style-definition
CFLAGS+=-Wmissing-parameter-type -Wmissing-field-initializers -Wnested-externs
CFLAGS+=-Wstack-usage=4096 -Wfloat-equal -Wabsolute-value
CFLAGS+=-fsanitize=undefined -fsanitize-undefined-trap-on-error
CC+=-m32 -no-pie -fno-pie
LDLIBS=-lm
all: integral


integral: func.o integral.o
	$(CC) $(CFLAGS) -o integral func.o integral.o $(LDLIBS)


integral.o: main.c
	$(CC) -c $(CFLAGS) $< -o $@ -lm


func.o: func.asm
	nasm -f elf32 -o $@ $^

test: integral
	./$< -R 1:3:2.0:2.5:0.0001:2.382660
	./$< -R 2:3:2.0:3.0:0.0001:2.460120
	./$< -R 1:2:5.0:6.0:0.0001:5.44152
	./$< -I 1:-1.0:3.0:0.001:10.8
	./$< -I 2:-2.0:3.0:0.001:5
	./$< -I 3:4.0:5.0:0.001:137.46

clean:
	rm -rf *.o integral