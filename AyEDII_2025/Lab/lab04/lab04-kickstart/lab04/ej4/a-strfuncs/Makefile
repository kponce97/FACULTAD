CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

MAIN = main

FILE = strfuncs

READER_1 = main


all:clean reader.output

%.output:	
		@echo "-------------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(FILE).c $(MAIN).c
		$(CC) $(CFLAGS) $(FILE).o $(MAIN).o -o $(READER_1)
		@echo "-------------------------------------------------------------------------\n\n"

run:
	@echo "------Archivo ejecutado\t --> \t[$(READER_1)]"
	@echo "\n--------------------------------------\n[------------- Ejemplo 1 -------------]"
	./$(READER_1)

exe: clean all run

val:
		$(VAL) ./$(READER_1) ../input/example-easy.in
gdb: 
		$(GDB) ./$(READER_1)

clean:
		@rm -f $(MAIN).o
		@rm -f $(FILE).o
		@rm -f $(READER_1)
		@rm -f *.output

help:
	@echo "Targets disponibles:"
	@echo "  make		    \t- Compila el proyecto"
	@echo "  make run   	\t- Ejecuta el programa con main"
	@echo "  make clean     \t- Borra archivos generados"
	@echo "  make val      	\t- Chequea si existen memori leaks"
	@echo "  make exe       \t- Clean, Make y Run"
	@echo "  make help      \t- Muestra esta ayuda"

				