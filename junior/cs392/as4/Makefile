#	Christopher Rudel
#	Professor Xu
#	CS 392
#	Makefile
#   I pledge my honor that I have abided by the Stevens Honor System

CC=gcc
OBJS=cs392_thread.o
RM=rm -rf
LDFLAGS=-pthread

cs392_thread: $(OBJS)

cs392_thread.o: cs392_thread.c 
	$(CC) -o cs392_thread.o -c cs392_thread.c $(LDFLAGS)
	
clean: 
	$(RM) *.o 
	$(RM) cs392_thread

re: clean cs392_thread
