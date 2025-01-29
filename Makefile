# Makefile

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2

# Source files
SRCS = main.c

# Target executable
TARGET = my_program

# Default target
all: $(TARGET)

# Build the target
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Run cppcheck
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS)

# Clean up
clean:
	rm -f $(TARGET)

.PHONY: all cppcheck clean
