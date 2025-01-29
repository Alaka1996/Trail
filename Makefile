# Compiler and flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -O2 -g
CXXFLAGS = -Wall -Wextra -O2 -g -std=c++11

# Directories
BUILD_DIR = build
TEST_DIR = $(BUILD_DIR)/test

# Source files
SRCS = main.c

# Target executables
TARGET = my_program

# AddressSanitizer flags
ASAN_FLAGS = -fsanitize=address -fno-omit-frame-pointer

# Create the build directory
$(shell mkdir -p $(BUILD_DIR)/test)

# Default target
all: $(TARGET) $(TEST_TARGET)

# Build the target (main program)
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Build with AddressSanitizer
asan: CFLAGS += $(ASAN_FLAGS)
asan: $(TARGET)

# Run cppcheck (static analysis)
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS)

# Clean up
clean:
	rm -f $(TARGET) $(TEST_TARGET)

.PHONY: all cppcheck clean asan test
