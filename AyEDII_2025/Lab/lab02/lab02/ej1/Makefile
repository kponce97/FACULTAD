CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

MAIN = main
FILE_1 = k_esimo

READER = main

all:clean reader.output

%.output:	
		@echo "-------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(MAIN).c
		$(CC) $(CFLAGS) -c $(FILE_1).c
		$(CC) $(CFLAGS) $(FILE_1).o $(MAIN).o -o $(READER)
		@echo "-------------------------------------------------------------------\n\n"
run:
	@echo "------Archivo ejecutado------"
	./$(READER)

val:
		$(VAL) ./$(READER)
gdb: 
		$(GDB) ./$(READER)

clean:
		@rm -f main.o
		@rm -f $(FILE_1).o
		@rm -f $(MAIN).o
		@rm -f $(READER)
		@rm -f *.output
				