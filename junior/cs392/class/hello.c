#include <stdio.h>
enum months {JAN = 1, FEB, MAR};
enum week {sun, mon, tues, wed, thurs, fri, sat};
int main(int argc, char** argv)
{
    if(argc < 2){
        printf("Please enter more arguments\n");
        return 1;
    }
    //printf("%s\n", argv[0]);
    printf("%s\n", argv[1]);

    //int var4 = (int)1.785;
    //char c = 0x41424344; // this number is too large and so only 0x44 is kept
    //printf("%c\n", c);
    printf("%d\n", sat);
    return 0;
}