#	Christopher Rudel
#	Professor Xu
#	CS 392
#	Makefile
#   I pledge my honor that I have abided by the Stevens Honor System


CC = gcc
OBJS = cs392_ass2_test.o libcs392string.so

RM = rm -f

prog: $(OBJS)
	$(CC) -o prog $(OBJS)

cs392_ass2_test.o: cs392_ass2_test.c
	$(CC) -o cs392_ass2_test.o -c cs392_ass2_test.c

libcs392string.so: cs392_memcpy.o cs392_strlen.o 
	$(CC) -shared -fPIC -o libcs392string.so cs392_memcpy.o cs392_strlen.o 

#	The two rules below I explicitly wrote but they are not necessary, the default rules do this 
cs392_memcpy.o: cs392_memcpy.c
	$(CC) -o cs392_memcpy.o -c cs392_memcpy.c 

cs392_strlen.o: cs392_strlen.c 
	$(CC) -o cs392_strlen.o -c cs392_strlen.c


#	I also made it so that it removes the program executable, delete "prog" if you dont want that
clean: 
	$(RM) *.o *.so prog

test: 
	export LD_LIBRARY_PATH=$(shell pwd); ./prog

re: clean prog test
#	The re is so that i dont have to do "make clean, make, make test" each time