// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#ifndef _FSFILE_H_
#define _FSFILE_H_

#include <vector>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <cstdint>
#include <cstring>

using namespace std;

typedef struct lfile_node lfile_node;
struct lfile_node {
	lfile_node* next;
	int block_addr;
	int bytes;
};

typedef struct file_attr {
	char* name;
	int64_t size;
	time_t timestamp;
	lfile_node* lfile;
} file_attr;

typedef struct dir dir;
struct dir {
	char* name;
	vector<dir*>* subdirs;
	vector<file_attr*>* files;
	dir* parent;
	time_t timestamp;
};

int addPathToDir(dir* root, char* path);
dir* addToDir(dir* parent, char* child);
dir* createDir(char* name);
void printDir(dir* root, int depth);
void freeDirTree(dir* root);

file_attr* createFile(char* name, int64_t size, time_t timestamp);
file_attr* addFileToDir(dir* parent, char* name, int64_t size, time_t timestamp);
void print_lfile(file_attr* f, int block_size);
void freeFile(file_attr* f);

#endif