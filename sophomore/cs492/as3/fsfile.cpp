// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#include "fsfile.h"

// Creates an empty file
// This function does not allocate blocks in ldisk
file_attr* createFile(char* name, int64_t size, int64_t timestamp) {
	file_attr* f = (file_attr*) malloc(sizeof(file_attr));
	f->name = (char*) malloc(strlen(name)*sizeof(char));
	strcpy(f->name, name);
	f->size = size;
	f->timestamp = timestamp;
	f->lfile = NULL;
}

void print_lfile(file_attr* f, int block_size) {
	if(f == NULL) {
		return;
	}

	printf("Block addresses: [ ");
	lfile_node* cur = f->lfile;
	while(cur != NULL) {
		printf("<%d (id: %d): %d bytes> ", cur->block_addr, cur->block_addr / block_size, cur->bytes);
		cur = cur->next;
	}
	printf("]\n");
	return;
}

void freeFile(file_attr* f) {
	if(f == NULL) 
		return;

	free(f->name);

	if(f->lfile != NULL) {
		lfile_node* cur = f->lfile;
		while(cur != NULL) {
			lfile_node* temp = cur->next;
			free(cur);
			cur = temp;
		}
		f->lfile = NULL;
	}

	free(f);
	f = NULL;
}

// Adds a new series of directories parsed from 'path' to the provided existing directory structure
// Returns non-zero if an error occurs
int addPathToDir(dir* root, char* path) {
	dir* cur = root;

	char* name = strtok(path, "/");
    while(name) {
    	if(strcmp(name, ".") == 0 || strcmp(name, "..") == 0) {
    		return 1;
    	}

		int found = 0;
		for(int i = 0; i < cur->subdirs->size() && found == 0; i++) {
			if(strcmp(cur->subdirs->at(i)->name, name) == 0) {
				found = 1;
				cur = cur->subdirs->at(i);
			}
		}

		if(found == 0) {
			cur = addToDir(cur, name);
			if(cur == NULL) {
				fprintf(stderr, "Unable to create directory %s: name conflict.\n", name);
				return 2;
			}
		}
		name = strtok(NULL, "/");
    }

    return 0;
}

// Creates and adds the given child directory to the parent directory
// Returns NULL if the child cannot be added (e.g. name conflict). Returns the child otherwise
dir* addToDir(dir* parent, char* child) {
	// Check for name conflicts
	for(int i = 0; i < parent->subdirs->size(); i++) {
		if(strcmp(parent->subdirs->at(i)->name, child) == 0) {
			return NULL;
		}
	}

	for(int i = 0; i < parent->files->size(); i++) {
		if(strcmp(parent->files->at(i)->name, child) == 0) {
			return NULL;
		}
	}

	dir* next = createDir(child);
	next->parent = parent;
    parent->subdirs->push_back(next);
    parent->timestamp = time(NULL);
    return next;
}

// Creates and adds the given file to the parent directory
// Returns NULL if the file cannot be added (e.g. name conflict). Returns the file otherwise
// Note: Does NOT allocate the file's disk space
file_attr* addFileToDir(dir* parent, char* name, int64_t size, int64_t timestamp) {
	// Check for name conflicts
	for(int i = 0; i < parent->subdirs->size(); i++) {
		if(strcmp(parent->subdirs->at(i)->name, name) == 0) {
			return NULL;
		}
	}

	for(int i = 0; i < parent->files->size(); i++) {
		if(strcmp(parent->files->at(i)->name, name) == 0) {
			return NULL;
		}
	}

	file_attr* f = createFile(name, size, timestamp);
	parent->files->push_back(f);
	parent->timestamp = time(NULL);
	return f;
}

// Creates a new empty directory with the given name
dir* createDir(char* name) {
	dir* root = (dir*) malloc(sizeof(struct dir));
	root->parent = NULL;
	root->subdirs = new vector<dir*>();
	root->files = new vector<file_attr*>();
	root->name = (char*) malloc(strlen(name)*sizeof(char));
	strcpy(root->name, name);
	root->timestamp = time(NULL);
	return root;
}

void printDir(dir* root, int depth) {
	for(int i = 0; i < depth; i++)
		printf("--");
	printf("%s\n", root->name);
	for(int i = 0; i < root->subdirs->size(); i++) {
		printDir(root->subdirs->at(i), depth+1);
	}
}

// Recursively free all resources starting from and including the provided dir, including files
void freeDirTree(dir* root) {
	if(root == NULL)
		return;

	free(root->name);
	while(root->files->size() != 0) {
		freeFile(root->files->at(0));
		root->files->erase(root->files->begin());
	}
	delete root->files;

	while(root->subdirs->size() != 0) {
		freeDirTree(root->subdirs->at(0));
		root->subdirs->erase(root->subdirs->begin());
	}
	delete root->subdirs;

	free(root);
	root = NULL;
}