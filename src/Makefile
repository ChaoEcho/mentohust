# Simple Makefile for MentoHUST
# This will be called by OpenWrt build system with proper cross-compilation settings

.PHONY: all clean

all: mentohust

# Source files
SOURCES = byte_order.c checkV4.c dlfunc.c md5.c mentohust.c mycheck.c myconfig.c myfunc.c myini.c mystate.c rjmd5.c rjripemd128.c rjsha1.c rjtiger.c rjtiger_sbox.c rjwhirlpool.c rjwhirlpool_sbox.c

# Object files
OBJECTS = $(SOURCES:.c=.o)

# Compilation rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link rule
mentohust: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)

# Clean rule
clean:
	rm -f mentohust $(OBJECTS)
