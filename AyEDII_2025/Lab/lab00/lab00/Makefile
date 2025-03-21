CC=gcc
CFLAGS = -std=c99 -pedantic -Wall -Werror -Wextra -g
FILE = tictactoe_gen
all: clean reader.output

%.output: ;
	$(CC) $(CFLAGS) -c $(FILE).c
	$(CC) $(CFLAGS) $(FILE).o -o reader
R:
	make && ./reader

clean:
	@rm -f $(FILE).o
	@rm -f reader
	@rm -f *.output