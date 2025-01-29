# Compiler and flags
CC = gcc
CXX = g++
CFLAGS = -Wall -Wextra -O2 -fsanitize=address -fno-omit-frame-pointer
CXXFLAGS = -Wall -Wextra -O2 -std=c++11 -fsanitize=address -fno-omit-frame-pointer

# Source files
SRCS = main.c
TEST_SRCS = test_main.cpp

# Target executable
TARGET = my_program
TEST_TARGET = my_program_test

# Default target
all: $(TARGET)

# Build the main program
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Build the test program
$(TEST_TARGET): $(SRCS) $(TEST_SRCS)
	$(CXX) $(CXXFLAGS) -o build/test/$(TEST_TARGET) $(SRCS) $(TEST_SRCS)

# Run cppcheck
cppcheck:
	cppcheck --enable=all --inconclusive --std=c99 $(SRCS) $(TEST_SRCS)

# Run AddressSanitizer on the program
asan: $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET)_asan $(SRCS)
	./$(TARGET)_asan

# Clean up
clean:
	rm -f $(TARGET) build/test/$(TEST_TARGET) $(TARGET)_asan

.PHONY: all cppcheck clean asan
