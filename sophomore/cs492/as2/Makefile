# John Banya and Christopher Rudel
# "I pledge my honor that I have abided by the Stevens Honor System."

NAME=VMsimulator
SRC=main.cpp

SRCPATH=./
OBJ=$(addprefix $(SRCPATH), $(SRC:.cpp=.o))

RM=rm -f
INCPATH=includes
CPPFLAGS+= -I $(INCPATH)


all: build

build: $(OBJ)
	g++ $(OBJ) -o $(NAME)

test: $(OBJ)
	g++ $(OBJ) -o $(NAME) && ./$(NAME) plist ptrace 2 FIFO +

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

