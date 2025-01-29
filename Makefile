# Makefile

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2
ASAN_FLAGS = -fsanitize=address -g  # AddressSanitizer flags

# Source files
SRCS = main.c

# Target executable
TARGET = my_program
TARGET_ASAN = my_program_asan  # Separate ASan build

# Default target
all: $(TARGET)

# Build the normal target
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Build with AddressSanitizer
asan: $(SRCS)
	$(CC) $(CFLAGS) $(ASAN_FLAGS) -o $(TARGET_ASAN) $(SRCS)

# Run cppcheck
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS)

# Clean up
clean:
	rm -f $(TARGET) $(TARGET_ASAN)

.PHONY: all asan cppcheck clean
