# Compiler and flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -O2 -g
CXXFLAGS = -Wall -Wextra -O2 -g -std=c++11

# Directories
GTEST_DIR = $(PWD)/googletest/googletest
BUILD_DIR = build

# Source files
SRCS = main.c
TEST_SRCS = test_main.cpp

# Target executables
TARGET = my_program
TEST_TARGET = my_program_test

# GoogleTest flags
GTEST_INCLUDE = $(GTEST_DIR)/include
GTEST_LIBS = -lgtest -lgtest_main -pthread

# AddressSanitizer flags
ASAN_FLAGS = -fsanitize=address -fno-omit-frame-pointer

# Default target
all: $(TARGET) $(TEST_TARGET)

# Build the target (main program)
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Build with AddressSanitizer
asan: CFLAGS += $(ASAN_FLAGS)
asan: $(TARGET)

# Build the test target (GoogleTest)
$(TEST_TARGET): $(SRCS) $(TEST_SRCS)
	$(CXX) $(CXXFLAGS) -I$(GTEST_INCLUDE) -o $(BUILD_DIR)/$(TEST_TARGET) $(SRCS) $(TEST_SRCS) $(GTEST_DIR)/src/gtest_main.cc $(GTEST_DIR)/src/gtest.cc $(GTEST_LIBS)

# Run cppcheck (static analysis)
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS)

# Clean up
clean:
	rm -f $(TARGET) $(BUILD_DIR)/$(TEST_TARGET)

# Run unit tests (GoogleTest)
test: $(BUILD_DIR)/$(TEST_TARGET)
	./$(BUILD_DIR)/$(TEST_TARGET)

.PHONY: all cppcheck clean asan test
