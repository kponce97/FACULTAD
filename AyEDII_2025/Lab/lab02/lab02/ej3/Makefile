CC = gcc
CFLAGS = -Wall -Werror -Wextra -pedantic -std=c99 -g

GDB = gdb
VAL = valgrind --track-origins=yes --leak-check=full

MAIN = main
FILE_1 = cima_log
TEST_CIMA = test_cima
TEST = tests

READER_1 = main
READER_2 = tests

all:clean reader.output

%.output:	
		@echo "-------------------------Archivos compilados-----------------------------"
		$(CC) $(CFLAGS) -c $(MAIN).c
		$(CC) $(CFLAGS) -c $(FILE_1).c
		$(CC) $(CFLAGS) -c $(TEST).c
		$(CC) $(CFLAGS) $(FILE_1).o $(MAIN).o -o $(READER_1)
		$(CC) $(CFLAGS) $(FILE_1).o $(TEST).o -o $(READER_2)
		@echo "-------------------------------------------------------------------------\n\n"
test_cima:
	@echo "-------------------------Archivos compilados-----------------------------"
	$(CC) $(CFLAGS) -c $(FILE_1).c $(TEST_CIMA).c
	$(CC) $(CFLAGS) $(FILE_1).o $(TEST_CIMA).o -o test_cima

run_main:
	@echo "------Archivo ejecutado\t --> \t[$(READER_1)]"
	./$(READER_1)

run_test:
	@echo "------Archivo ejecutado \t --> \t[$(READER_2)]"
	./$(READER_2)

val:
		$(VAL) ./$(READER)
gdb_tests: 
		$(GDB) ./$(READER_2)
gdb_main: 
		$(GDB) ./$(READER_1)

clean:
		@rm -f main.o
		@rm -f $(FILE_1).o
		@rm -f $(READER_1)
		@rm -f $(READER_2)
		@rm -f $(READER_2).o
		@rm -f $(TEST_CIMA) 
		@rm -f $(TEST_CIMA).o
		@rm -f *.output

help:
	@echo "Targets disponibles:"
	@echo "  make		     - Compila el proyecto"
	@echo "  make run_main   - Ejecuta el programa con main"
	@echo "  make run_test   - Ejecuta el programa tests"
	@echo "  make clean      - Borra archivos generados"
	@echo "  make help       - Muestra esta ayuda"

				