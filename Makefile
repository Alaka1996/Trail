# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -O2

# Directories
GTEST_DIR = /usr/local/include/gtest
BUILD_DIR = build

# Source files
SRCS = main.c test_main.cpp

# Target executables
TARGET = my_program
TEST_TARGET = my_program_test

# GoogleTest flags
GTEST_LIBS = -lgtest -lgtest_main -pthread

# AddressSanitizer flags
ASAN_FLAGS = -fsanitize=address -fno-omit-frame-pointer

# Default target
all: $(TARGET) $(TEST_TARGET)

# Build the target (main program)
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Build the test target (GoogleTest)
$(TEST_TARGET): $(SRCS) test_main.cpp
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/$(TEST_TARGET) $(SRCS) test_main.cpp $(GTEST_LIBS)

# Build with AddressSanitizer
asan: CFLAGS += $(ASAN_FLAGS)
asan: $(TARGET)

# Run cppcheck (static analysis)
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS)

# Clean up
clean:
	rm -f $(TARGET) $(BUILD_DIR)/$(TEST_TARGET)

.PHONY: all cppcheck clean asan
