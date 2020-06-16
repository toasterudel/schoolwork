# John Banya and Christopher Rudel
# "I pledge my honor that I have abided by the Stevens Honor System."

# Name of your program:
NAME=assign1

# List of all .cpp source code files included in your program (separated by spaces):
SRC=main.cpp queue.cpp

SRCPATH=./
OBJ=$(addprefix $(SRCPATH), $(SRC:.cpp=.o))

RM=rm -f
INCPATH=includes
CPPFLAGS+= -I $(INCPATH)


all: build

build: $(OBJ)
	g++ $(OBJ) -o $(NAME) -lpthread

test: $(OBJ)
	g++ $(OBJ) -o $(NAME) -lpthread && ./$(NAME) 5 5 1000 100 0 512 12345

clean:
	-$(RM) *~
	-$(RM) *#*
	-$(RM) *swp
	-$(RM) *.core
	-$(RM) *.stackdump
	-$(RM) $(SRCPATH)*.o
	-$(RM) $(SRCPATH)*.obj
	-$(RM) $(SRCPATH)*~
	-$(RM) $(SRCPATH)*#*
	-$(RM) $(SRCPATH)*swp
	-$(RM) $(SRCPATH)*.core
	-$(RM) $(SRCPATH)*.stackdump

fclean: clean
	-$(RM) $(NAME)

re: fclean all

