// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#ifndef _FS_H_
#define _FS_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <cstring>
#include <vector>
#include <signal.h>
#include <assert.h>
#include <time.h>
#include <deque>
#include "fsfile.h"

#define FREE 0
#define USED 1

#define TERM_COLOR "\u001b[37m"
#define DIR_COLOR "\u001b[1m\u001b[34;1m"
#define COLOR_RESET "\u001b[0m"

typedef struct block_t {
	int status; // FREE or USED
	int uid;
} block_t;

typedef struct ldisk_node ldisk_node;
struct ldisk_node {
	ldisk_node* next;
	int status; // FREE or USED
	int from;
	int to;
};

extern int available_blocks;
extern int disk_size;
extern int block_size;
extern block_t** disk; // Physical disk representation
extern ldisk_node* ldisk;

extern dir* root;
extern dir* working_dir;

int load_dir_list(char* filename);
int load_file_list(char* filename); 

void create_ldisk();
void free_ldisk();

int allocateDisk(file_attr* f, int bytes);
int deallocateDisk(file_attr* f, int bytes);
void free_ldisk_block(int block_id);

void changeDir(char*);
void listFiles();
void mkdir(char*);

int append(char*, int);
int append(file_attr*, int);

int remove(char*, int);
int remove(file_attr*, int);

void deleteEntry(char*);

void bfsDir();
void stat(char*);
void statFile(dir*, file_attr* f);
void statDir(dir*);

void prfiles();
void prdisk();

void usage(char* progName);

char** str2vect(char*);

#endif
