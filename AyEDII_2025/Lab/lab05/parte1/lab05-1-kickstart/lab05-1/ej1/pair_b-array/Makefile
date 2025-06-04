# Variables de compilación
CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g
GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

#Archivos
MAIN = main
FILE = pair
READER_1 = pair

# Códigos de color ANSI
GREEN    := \033[0;32m
YELLOW   := \033[1;33m
RED      := \033[0;31m
BLUE 	 := \033[0;34m	
RESET    := \033[0m

all: reader.output

%.output:	
		@echo "$(GREEN)-------------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(FILE).c $(MAIN).c
		$(CC) $(CFLAGS) $(FILE).o $(MAIN).o -o $(READER_1)
		@echo "$(GREEN)-------------------------------------------------------------------------$(RESET)\n\n"

run:
	@echo "$(YELLOW)\n----------------Archivo ejecutado----------------"
	./$(READER_1)


val:
		$(VAL) ./$(READER_1) 
gdb: 
		$(GDB) ./$(READER_1)

clean:
	@echo "$(RED)------------------ Limpiando archivos ------------------"
	@rm -v -f $(MAIN).o || true
	@rm -v -f $(FILE).o || true
	@rm -v -f $(READER_1) || true
	@rm -v -f *.output || true

help:
	@echo "$(BLUE)Targets disponibles:"
	@echo "  make		    \t- Compila el proyecto"
	@echo "  make run   	\t- Ejecuta el programa con main"
	@echo "  make clean     \t- Borra archivos generados"
	@echo "  make val      	- Chequea si existen memori leaks"
	@echo "  make help      \t- Muestra esta ayuda"

				