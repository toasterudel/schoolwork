#	Christopher Rudel
#	Professor Xu
#	CS 392
#	Makefile
#   I pledge my honor that I have abided by the Stevens Honor System Christopher Rudel

CC = gcc
RM = rm -rf 

all: cs392_log cs392_echoclient cs392_echoserver

cs392_log: cs392_log.o
	$(CC) -c cs392_log.c

cs392_echoclient: cs392_echoclient.o
	$(CC) -c cs392_echoclient.c
	$(CC) -o cs392_echoclient cs392_echoclient.o

cs392_echoserver: cs392_echoserver.o cs392_log.o
	$(CC) -c cs392_echoserver.c
	$(CC) -o cs392_echoserver cs392_echoserver.o cs392_log.o

clean:
	$(RM) *.o 
	$(RM) cs392_echoserver
	$(RM) cs392_echoclient

re: clean all