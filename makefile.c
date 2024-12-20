# Compiler and Flags
CC = gcc
CFLAGS = -Wall -Wextra -Werror

# Source and Object Files
SRC = src/main.c src/utils.c
OBJ = $(SRC:.c=.o)

# Output Executable
TARGET = my_program

# Default Rule: Build the Program
all: $(TARGET)

# Rule to Build the Target
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Rule to Compile Source Files into Object Files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean Build Files
clean:
	rm -f $(OBJ) $(TARGET)

# Phony Targets
.PHONY: all clean
