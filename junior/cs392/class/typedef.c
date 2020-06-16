#include <stdio.h>
//So when want to declare a struct you have to use the syntax 'struct my_struct x' 
//but if we use typedef we can just do 'my_struct x'

typedef struct Student Student;

struct Student {
    char* name;
    int id;
};

Student* newStudent(char* x, int y)
{
    Student *s;
    if((s = malloc(sizeof *s)) != NULL)
    {
        s->name = x;
        s->id = y;
    }
    return s;
}

int main()
{

}