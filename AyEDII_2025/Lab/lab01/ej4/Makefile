CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

FILE_1 = array_helpers
FILE_2 = sort
MAIN = main

READER = sorter
EJEMPLO_1 = ../input/example-unsorted.in
EJEMPLO_2 = ../input/unsorted-100.in

all:clean reader.output

%.output:	
		$(CC) $(CFLAGS) -c $(MAIN).c
		$(CC) $(CFLAGS) -c $(FILE_1).c
		$(CC) $(CFLAGS) -c $(FILE_2).c
		$(CC) $(CFLAGS) -no-pie $(FILE_1).o $(FILE_2).o sort_helpers.o $(MAIN).o -o $(READER)
val:
		$(VAL) ./$(READER)
gdb: 
		$(GDB) ./$(READER)

r:
	./$(READER) $(EJEMPLO_1)
r2:
	./$(READER) $(EJEMPLO_2)

clean:
		@rm -f main.o
		@rm -f $(FILE_1).o
		@rm -f $(FILE_2).o
		@rm -f $(MAIN).o
		@rm -f $(READER)
		@rm -f *.output
				