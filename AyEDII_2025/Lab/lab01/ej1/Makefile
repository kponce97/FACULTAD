CC = gcc
CFLAGS =-Wall -Werror -Wextra -pedantic -std=c99 -c array_helpers.c 

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

READER = reader
EJ = ../input/example-unsorted.in

all:clean reader.output

%.output:	
		@echo "--> Archivos Compilados..."
		$(CC) $(CFLAGS) -c main.c
		$(CC) $(CFLAGS) -c *.c
		$(CC) $(CFLAGS) *.o -o $(READER)
val:
		$(VAL) ./$(READER)
gdb: 
		$(GDB) ./$(READER)

run:
	./$(READER) $(EJ)

clean:
		@echo "--> Archivos Eliminados..."
		@rm -f main.o
		@rm -f *.o
		@rm -f $(READER)
		@rm -f *.output
				