# John Banya and Christopher Rudel
# "I pledge my honor that I have abided by the Stevens Honor System."

NAME=fssim
SRC=main.cpp fsfile.cpp fs.cpp str2vect.cpp

SRCPATH=./
OBJ=$(addprefix $(SRCPATH), $(SRC:.cpp=.o))

RM=rm -f
INCPATH=includes
CPPFLAGS+= -std=c++11 -I $(INCPATH)


all: build

build: $(OBJ)
	g++ $(OBJ) -o $(NAME)

test: $(OBJ)
	g++ $(OBJ) -o $(NAME) && ./$(NAME) -f file_list.txt -d dir_list.txt -b 512 -s 10485760

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

