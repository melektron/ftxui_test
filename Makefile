SRC_DIR = src
OBJ_DIR = obj
RUN_DIR = run

CC = g++
CFLAGS = -g -I$(SRC_DIR)
LIBS = -g

SOURCES = $(shell find $(SRC_DIR) -name '*.cpp')
OBJECTS_TEMP = $(patsubst %.cpp,%.o,$(SOURCES))
OBJECTS = $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(OBJECTS_TEMP))
EXECUTABLE = $(RUN_DIR)/main

all: $(SOURCES) $(EXECUTABLE)

start: $(EXECUTABLE)
	${EXECUTABLE}

# create executable file from all object files
$(EXECUTABLE): $(OBJECTS)
	mkdir -p $(RUN_DIR)
	$(CC) $(OBJECTS) -o $@ $(LIBS)

# create object file for every source file
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# remove all subfolders and files of the object dir and the executable
clean:
	rm -rf $(EXECUTABLE) $(OBJ_DIR)/*