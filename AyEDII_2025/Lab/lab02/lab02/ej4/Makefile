CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

MAIN = main
FILE_1 = cima
FILE_2 = cima_log

READER_1 = main

all:clean reader.output

%.output:	
		@echo "-------------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(MAIN).c
		$(CC) $(CFLAGS) -c $(FILE_1).c
		$(CC) $(CFLAGS) -c $(FILE_2).c
		$(CC) $(CFLAGS) $(FILE_1).o $(FILE_2).o $(MAIN).o -o $(READER_1)
		@echo "-------------------------------------------------------------------------\n\n"

run:
	@echo "------Archivo ejecutado\t --> \t[$(READER_1)]"
	./$(READER_1)

val:
		$(VAL) ./$(READER)

gdb_main: 
		$(GDB) ./$(READER_1)

clean:
		@rm -f main.o
		@rm -f $(FILE_1).o
		@rm -f $(FILE_2).o
		@rm -f $(READER_1)
		@rm -f *.output

help:
	@echo "Targets disponibles:"
	@echo "  make		     - Compila el proyecto"
	@echo "  make run_main   - Ejecuta el programa con main"
	@echo "  make run_test   - Ejecuta el programa tests"
	@echo "  make clean      - Borra archivos generados"
	@echo "  make help       - Muestra esta ayuda"

				