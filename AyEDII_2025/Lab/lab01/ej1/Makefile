CC = gcc
CFLAGS = -Wall -Wextra -pedantic -std=c99 -g
#CFLAGS = -Wall -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

READER = reader
EJ = ../input/example-unsorted.in

all:clean reader.output

%.output:	
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
				