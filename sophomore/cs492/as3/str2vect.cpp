// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#include "fs.h"

//creates a vector for each word in s
char** str2vect(char *s)
{
    char **vect;
    int i;
    int w;
    int c;
    int len;
    char last;

    if (s == NULL)
        return NULL;
    w = 0;
    len = 1;
    last = '\0';


    //number of words
    for (i = 0; s[i] != '\0'; i++)
    {
        if (s[i] != ' ' && s[i] != '\t')
            if (last == ' ' || last == '\t' || last == '\0')
                w++;
        last = s[i];
        len++;
    }

    if (w > 0)
        vect = (char**)malloc((w+1)*sizeof(char*));
    else
    {
        vect = (char**)malloc(sizeof(char*));
        *vect = NULL;
        return vect;
    }
    c = 0;
    w = 0;
    last = '\0';

    //length of each word
    for (i = 0; i <= len; i++)
    {
        if (s[i] != ' ' && s[i] != '\t' && s[i] != '\0')
            c++;
        else if (c != 0)
        {
            vect[w++] = (char*)malloc((c+1)*sizeof(char));
            c = 0;
        }
        last = s[i];
    }
    vect[w] = (char*)malloc(sizeof(char));
    c = 0;
    w = 0;
    last = '\0';

    //copy the words to the vector
    for (i = 0; i <= len; i++)
    {
        if (s[i] != ' ' && s[i] != '\t' && s[i] != '\0')
        {

            vect[w][c++] = s[i];
        }
        else if (last != ' ' && last != '\t' && last != '\0')
        {
            vect[w++][c] = '\0';
            c = 0;
        }
        last = s[i];
    }
    vect[w] = NULL;
    return vect;
}
