CFLAGS=-O2 -g
CFLAGS+=-std=gnu99
CFLAGS+=-Wall -Werror -Wformat-security -Wignored-qualifiers -Winit-self
CFLAGS+=-Wswitch-default -Wpointer-arith -Wtype-limits -Wempty-body
CFLAGS+=-Wstrict-prototypes -Wold-style-declaration -Wold-style-definition
CFLAGS+=-Wmissing-parameter-type -Wmissing-field-initializers -Wnested-externs
CFLAGS+=-Wstack-usage=4096 -Wmissing-prototypes -Wfloat-equal -Wabsolute-value
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
	./$< -R 1:3:-0.5:0.5:0.00001:-0.20333
	./$< -R 2:3:0.0:1.0:0.00001:0.18741
	./$< -R 1:2:1.5:2.5:0.00001:1.95615
	./$< -I 1:0.0:2.0:0.00001:4.71239
	./$< -I 2:-0.5:1.0:0.00001:1.22474
	./$< -I 3:-1.0:2.0:0.00001:2.58295

clean:
	rm -rf *.o integral