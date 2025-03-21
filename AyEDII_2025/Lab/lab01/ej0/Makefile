CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full
FILE = fixstring
READER = reader

all:clean reader.output

%.output:	
		$(CC) $(CFLAGS) -c main.c
		$(CC) $(CFLAGS) -c $(FILE).c
		$(CC) $(CFLAGS) main.o $(FILE).o -o $(READER)
val:
		$(VAL) ./$(READER)
gdb: 
		$(GDB) ./$(READER)

run:
	./$(READER)

clean:
		@rm -f main.o
		@rm -f $(FILE).o
		@rm -f $(READER)
		@rm -f *.output
				