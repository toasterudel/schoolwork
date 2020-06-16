#	Christopher Rudel
#	Jun Xu
#	CS392
#	quiz2
#	I pledge my honor that I have abided by the Stevens Honor System

CC = gcc
OBJS = main.o sum.o
HDRS = sum.h
RM = rm -rf

prog: $(OBJS)
	$(CC) -o prog $(OBJS)

$(OBJS) : $(HDRS)

clean: 
	$(RM) *.o 
	$(RM) prog

re: clean prog 
