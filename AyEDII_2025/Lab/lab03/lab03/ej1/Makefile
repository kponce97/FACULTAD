CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

MAIN = main
WEATHER_TABLE = weather_table
WEATHER = weather
WEATHER_UTILS = weather_utils

READER_1 = weather


all:clean reader.output

%.output:	
		@echo "-------------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(WEATHER_TABLE).c $(WEATHER).c $(WEATHER_UTILS).c $(MAIN).c
		$(CC) $(CFLAGS) $(WEATHER).o $(WEATHER_TABLE).o $(WEATHER_UTILS).o $(MAIN).o -o $(READER_1)
		@echo "-------------------------------------------------------------------------\n\n"

run:
	@echo "------Archivo ejecutado\t --> \t[$(READER_1)]"
	./$(READER_1) ../input/weather_cordoba.in

diff:
	../input/weather_cordoba.in weather_cordoba.out

val:
		$(VAL) ./$(READER)
gdb: 
		$(GDB) ./$(READER_1)

clean:
		@rm -f $(MAIN).o
		@rm -f $(WEATHER).o
		@rm -f $(WEATHER_TABLE).o
		@rm -f $(WEATHER_UTILS).o
		@rm -f $(READER_1)
		@rm -f *.output

help:
	@echo "Targets disponibles:"
	@echo "  make		    - Compila el proyecto"
	@echo "  make run   	- Ejecuta el programa con main"
	@echo "  make clean     - Borra archivos generados"
	@echo "  make help      - Muestra esta ayuda"

				