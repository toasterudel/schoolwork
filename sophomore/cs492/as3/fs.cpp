// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#include "fs.h"

int available_blocks;
int disk_size;
int block_size;
block_t** disk;
ldisk_node* ldisk;

dir* root;
dir* working_dir;

int load_dir_list(char* filename) {
	char* line;
 	size_t len = 0;

	FILE* dir_list = fopen(filename, "r");
    if(dir_list == NULL) {
       return 1;
    }
 	
    if(root == NULL) {
    	char* rootName = (char*) malloc(2*sizeof(char));
    	rootName[0] = '/';
    	rootName[1] = '\0';
    	root = createDir(rootName);
    	free(rootName);
    }

 	int i = 1;
 	while(getline(&line, &len, dir_list) != -1)
    {
    	line = strtok(line, "\n");
		int err = addPathToDir(root, line);
		if(err != 0) {
			fprintf(stderr, "Error loading directory list on line %d\n", i);
			fclose(dir_list);
			return 1;
		}
    	i++;
    }
    fclose(dir_list);

    working_dir = root;

	return 0;
}

int load_file_list(char* filename) {
	char* line;
 	size_t len = 0;

	FILE* file_list = fopen(filename, "r");
    if(file_list == NULL) {
    	return 1;
    }

    int linenum = 1;
 	while(getline(&line, &len, file_list) != -1)
    {		
    	// Get file size
    	int num_bytes;
    	char* size = strtok(line, " ");
    	for(int i = 0; i < 6; i++) {
    		size = strtok(NULL, " ");

    		if(size == NULL) {
    			fprintf(stderr, "Invalid line format on line %d\n", linenum);
	    		fclose(file_list);
	    		return 1;
    		}
    	}
    	if(sscanf(size, "%i", &num_bytes) != 1) {
    		fprintf(stderr, "Unable to parse file size on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
    	}

    	// Get file timestamp
    	// https://linux.die.net/man/3/ctime
    	char* t = NULL;
    	struct tm tm;

    	// Month
    	char months[][12] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
    	t = strtok(NULL, " ");
    	if(t == NULL) {
			fprintf(stderr, "Invalid line format on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
		}

    	int mon = -1;
    	for(int m = 0; m < 12; m++) {
    		if(strcmp(t, months[m]) == 0) {
    			mon = m;
    			break;
    		}
    	}

    	if(mon == -1) {
    		fprintf(stderr, "Error: Unable to convert month abbreviation %s to int on line %d\n", t, linenum);
    		fclose(file_list);
    		return 1;
    	}

    	tm.tm_mon = mon;
    	
    	// Day 
    	t = strtok(NULL, " ");
    	if(t == NULL) {
			fprintf(stderr, "Invalid line format on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
		}
    	tm.tm_mday = atoi(t);

    	// Time
    	t = strtok(NULL, " ");
    	if(t == NULL) {
			fprintf(stderr, "Invalid line format on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
		}
    	if(strlen(t) != 5) {
    		fprintf(stderr, "Error: Unexpected time format on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
    	}
    	tm.tm_hour = atoi(t);
    	tm.tm_min = atoi(t+3);
    	tm.tm_sec = 0;

    	// Because year is not listed, we will assume the year is 2018
    	tm.tm_year = 2018;

    	// If the month/day is greater than current, assume the year is 2017 instead
    	time_t current_time_raw;
    	time(&current_time_raw);
   	 	struct tm* current_time = localtime(&current_time_raw);

   	 	if(tm.tm_mon > current_time->tm_mon 
   	 		|| (tm.tm_mon == current_time->tm_mon && tm.tm_mday > current_time->tm_mday) 
   	 		|| (tm.tm_mon == current_time->tm_mon && tm.tm_mday == current_time->tm_mday && tm.tm_hour > current_time->tm_hour)
   	 		|| (tm.tm_mon == current_time->tm_mon && tm.tm_mday == current_time->tm_mday && tm.tm_hour == current_time->tm_hour && tm.tm_min > current_time->tm_min)) 
   	 	{
   	 		tm.tm_year = 2017;
   	 	}

   	 	tm.tm_year = tm.tm_year - 1900;

    	// Convert to epoch time
    	time_t epoch = mktime(&tm);

    	// Get file name
    	dir* folder = root;
    	char* file = NULL;
    	char* head = strtok(NULL, "/");
    	while(head) {
    		file = head;
    		head = strtok(NULL, "/");

    		if(head != NULL) {
    			// Previous file was a directory
				int found = 0;
				for(int i = 0; i < folder->subdirs->size(); i++) {
					if(strcmp(file, folder->subdirs->at(i)->name) == 0) {
						folder = folder->subdirs->at(i);
						found = 1;
						break;
					}
				}

				if(found == 0) {
					fprintf(stderr, "Unable to find directory %s on line %d\n", file, linenum);
					fclose(file_list);
					return 1;
				}
    		}
    	}

    	file = strtok(file, "\n");
    	if(file == NULL || strlen(file) == 0) {
    		fprintf(stderr, "Unable to parse file name on line %d\n", linenum);
    		fclose(file_list);
    		return 1;
    	}
    	
    	// Create the file
    	file_attr* f = addFileToDir(folder, file, num_bytes, epoch);
    	if(f == NULL) {
    		fprintf(stderr, "Unable to create file %s: name conflict (line %d)\n", file, linenum);
    		fclose(file_list);
    		return 1;
    	}

    	// Allocate space for the file
    	int bytes_allocated = allocateDisk(f, f->size);
    	//printf("Allocated %d bytes for %s\n", bytes_allocated, f->name);
    	linenum++;
    }

    fclose(file_list);
	return 0;
}

void create_ldisk() {
	if(disk_size % block_size != 0) {
		printf("Warning: Disk size is not a multiple of the block size.\n");
		printf("The effective disk size will be %d.\n", disk_size - disk_size % block_size);
	}

	available_blocks = disk_size / block_size;

	ldisk = (ldisk_node*) malloc(sizeof(ldisk_node));
	ldisk->status = FREE;
	ldisk->next = NULL;
	ldisk->from = 0;
	ldisk->to = available_blocks-1;

	disk = (block_t**) malloc(available_blocks * sizeof(block_t*));
	for(int i = 0; i < available_blocks; i++) {
		disk[i] = (block_t*) malloc(sizeof(block_t));
		disk[i]->status = FREE;
		disk[i]->uid = i;
	}
}

void free_ldisk() {
	for(int i = 0; i < (disk_size / block_size); i++) {
		free(disk[i]);
		disk[i] = NULL;
	}
	free(disk);

	ldisk_node* cur = ldisk;
	while(cur != NULL) {
		ldisk_node* temp = cur->next;
		free(cur);
		cur = temp;
	}
	ldisk = NULL;
}

// Allocates disk space 'bytes' for the given file
// Returns the number of bytes allocated. Prints an error and exits without allocating if not enough free blocks exist to allocate the requested bytes.
// Note: This function does not modify the file's size metadata. That must be handled by the caller.
int allocateDisk(file_attr* f, int bytes) {
	if(bytes == 0 || f == NULL)
		return 0;

	int bytes_allocated = 0;
	lfile_node* lfile_end = f->lfile;
	while(lfile_end != NULL && lfile_end->next != NULL)
		lfile_end = lfile_end->next;

	int truncated_bytes = bytes;
	if(lfile_end != NULL) {
		int available = block_size - lfile_end->bytes;
		truncated_bytes -= available;
	}

	int num_blocks = truncated_bytes / block_size;
	int bytes_leftover = truncated_bytes % block_size;

	if(bytes_leftover != 0)
		num_blocks++;

	if(num_blocks > available_blocks) {
		printf("Not enough space to allocate %d bytes.\n", bytes);
		return 0;
	}

	// If some bytes can be added to the last allocated block, do it
	if(lfile_end != NULL && lfile_end->bytes != block_size) {
		int available = block_size - lfile_end->bytes;
		if(bytes <= available) {
			lfile_end->bytes += bytes;
			return bytes;
		} else {
			lfile_end->bytes += available;
			bytes_allocated += available;
		}
	}

	// Begin allocation of additional blocks:
	ldisk_node* prev = NULL;
	ldisk_node* cur = ldisk;
	while(num_blocks != 0 && available_blocks != 0) {
		// Search for the next free node
		while(cur->next != NULL && cur->status == USED) {
			prev = cur;
			cur = cur->next;
		}

		if(cur->next == NULL && cur->status == USED) {
			printf("Error while seeking for empty space.\n");
			return bytes_allocated;
		}

		if(prev == NULL) {
			// If the free block is the first block in the list
			prev = (ldisk_node*) malloc(sizeof(ldisk_node));
			prev->status = USED;
			prev->next = cur;
			prev->from = cur->from;
			prev->to = cur->from-1;
			ldisk = prev;
		}

		// Allocate as much contiguous space as possible from this segment
		while((cur->to - cur->from >= 0) && num_blocks != 0) {
			int block_id = cur->from;
			disk[block_id]->status = USED;
			prev->to++;
			cur->from++;

			int alloced = 0;
			if(num_blocks == 1 && bytes_leftover != 0) {
				// Allocating a partial block
				alloced = bytes_leftover;
			} else {
				// Allocating a full block
				alloced = block_size;
			}
			bytes_allocated += alloced;

			// Add the block to lfile
			if(lfile_end == NULL) {
				f->lfile = (lfile_node*) malloc(sizeof(lfile_node));
				f->lfile->next = NULL;
				lfile_end = f->lfile;
			} else {
				lfile_end->next = (lfile_node*) malloc(sizeof(lfile_node));
				lfile_end = lfile_end->next;
				lfile_end->next = NULL;
			}

			lfile_end->block_addr = block_id*block_size;
			lfile_end->bytes = alloced;

			num_blocks--;
			available_blocks--;
		}

		if(cur->to - cur->from < 0) {
			// We allocated the entire chunk of free memory, destroy it and perform any necessary merges
			prev->next = cur->next;
			free(cur);
			cur = prev->next;

			if(cur != NULL && cur->status == USED) {
				// Merge
				prev->to = cur->to;
				prev->next = cur->next;
				free(cur);
				cur = prev->next;
			}
		}
	}

	return bytes_allocated;
}

// Deallocates disk space by size 'bytes' for the given file
// Returns the number of bytes deallocated.
// Note: This function does not modify the file's size metadata. That must be handled by the caller.
int deallocateDisk(file_attr* f, int bytes) {
	if(bytes == 0 || f == NULL || f->lfile == NULL)
		return 0;	

	if(f->size < bytes) {
		printf("Unable to deallocate %ld bytes: cannot deallocate more bytes than the file has allocated.\n", f->size);
		return 0;
	}

	int bytes_deallocated = 0;

	int lfile_length = 1;
	lfile_node* lfile_cur = f->lfile;
	lfile_node* lfile_prev = NULL;
	while(lfile_cur->next != NULL) {
		lfile_prev = lfile_cur;
		lfile_cur = lfile_cur->next;
		lfile_length++;
	}

	// Deallocate from the end node first
	if(bytes <= lfile_cur->bytes) {
		// We can deallocate entirely from the end node
		lfile_cur->bytes -= bytes;
		if(lfile_cur->bytes == 0) {
			// Entire block has been deallocated
			int block_id = lfile_cur->block_addr / block_size;
			free(lfile_cur);
			lfile_cur = NULL;
			if(lfile_prev == NULL)
				f->lfile = NULL;
			else
				lfile_prev->next = NULL;

			// Update ldisk
			// Find where the block is located
			available_blocks++;
			disk[block_id]->status = FREE;
			free_ldisk_block(block_id);
		}
		return bytes;
	} else {
		// We can only deallocate some from the end node
		int block_id = lfile_cur->block_addr / block_size;
		bytes_deallocated = lfile_cur->bytes;
		bytes -= lfile_cur->bytes;
		lfile_cur->bytes = 0;
		
		free(lfile_cur);
		lfile_cur = lfile_prev;
		if(lfile_cur != NULL)
			lfile_cur->next = NULL;
		else
			f->lfile = NULL;
		lfile_length--;

		available_blocks++;
		disk[block_id]->status = FREE;
		free_ldisk_block(block_id);
	}

	// Begin deallocation of additional blocks
	// Find how many full blocks we must deallocate
	int full_blocks = bytes / block_size;
	int bytes_leftover = bytes % block_size;

	// Seek to the position where we start deallocating full blocks
	lfile_cur = f->lfile;
	lfile_prev = NULL;
	if(full_blocks < lfile_length) {
		for(int i = 0; i != (lfile_length - full_blocks); i++) {
			lfile_prev = lfile_cur;
			lfile_cur = lfile_cur->next;
		}
	}

	// Start removing full blocks starting from lfile_cur
	while(lfile_cur != NULL) {
		int block_id = lfile_cur->block_addr / block_size;

		lfile_node* temp = lfile_cur->next;
		bytes_deallocated += block_size;
		lfile_cur->bytes = 0;
		free(lfile_cur);
		lfile_cur = temp;
		full_blocks--;

		available_blocks++;
		disk[block_id]->status = FREE;
		free_ldisk_block(block_id);
	}

	// Remove whatever is left, if possible
	if(lfile_prev != NULL) {
		bytes_deallocated += bytes_leftover;
		lfile_prev->bytes -= bytes_leftover;
		bytes_leftover = 0;

		if(lfile_prev->bytes == 0) {
			int block_id = lfile_prev->block_addr / block_size;
			free(lfile_prev);
			lfile_prev = NULL;

			available_blocks++;
			disk[block_id]->status = FREE;
			free_ldisk_block(block_id);
		}
	}

	if(lfile_prev == NULL) {
		f->lfile = NULL;
	} else {
		lfile_prev->next = NULL;
	}

	return bytes_deallocated;
}

// Frees the segment of ldisk that contains block_id
void free_ldisk_block(int block_id) {
	ldisk_node* ldisk_cur = ldisk;
	ldisk_node* ldisk_prev = NULL;
	while(!(block_id >= ldisk_cur->from && block_id <= ldisk_cur->to)) {
		ldisk_prev = ldisk_cur;
		ldisk_cur = ldisk_cur->next;
	}
	assert(ldisk_cur->status == USED);
	if(block_id == ldisk_cur->from) {
		// Block is on the left border
		if(ldisk_prev != NULL) {
			assert(ldisk_prev->status == FREE);
			ldisk_prev->to++;
			ldisk_cur->from++;
		} else {
			ldisk_node* n = (ldisk_node*) malloc(sizeof(ldisk_node));
			n->from = ldisk_cur->from;
			n->to = ldisk_cur->from;
			n->next = ldisk_cur;
			n->status = FREE;
			ldisk_prev = n;
			ldisk = n;
			ldisk_cur->from++;
		}
		
		if(ldisk_cur->from > ldisk_cur->to) {
			ldisk_prev->next = ldisk_cur->next;
			free(ldisk_cur);
			ldisk_cur = NULL;

			if(ldisk_prev->next != NULL && ldisk_prev->next->status == FREE) {
				// Merge right
				ldisk_node* temp = ldisk_prev->next;
				ldisk_prev->to = ldisk_prev->next->to;
				ldisk_prev->next = ldisk_prev->next->next;
				free(temp);
			}
		}
	} else if(block_id == ldisk_cur->to) {
		// Block is on the right border
		if(ldisk_cur->next != NULL) {
			assert(ldisk_cur->next->status == FREE);
			ldisk_cur->to--;
			ldisk_cur->next->from--;
		} else {
			ldisk_node* n = (ldisk_node*) malloc(sizeof(ldisk_node));
			n->from = ldisk_cur->to;
			n->to = ldisk_cur->to;
			n->next = NULL;
			n->status = FREE;
			ldisk_cur->next = n;
			ldisk_cur->to--;	
		}

		if(ldisk_cur->from > ldisk_cur->to) {
			if(ldisk_prev == NULL) {
				ldisk = ldisk_cur->next;
			} else {
				ldisk_prev->next = ldisk_cur->next;
			}
			free(ldisk_cur);
			ldisk_cur = NULL;

			// Merge left
			if(ldisk_prev != NULL && ldisk_prev->next != NULL && ldisk_prev->next->status == FREE) {
				ldisk_node* temp = ldisk_prev->next;
				ldisk_prev->to = ldisk_prev->next->to;
				ldisk_prev->next = ldisk_prev->next->next;
				free(temp);
			}
		}
	} else {
		// Block is somewhere in the middle
		ldisk_node* n = (ldisk_node*) malloc(sizeof(ldisk_node));
		n->from = block_id;
		n->to = block_id;
		n->status = FREE;

		ldisk_node* n2 = (ldisk_node*) malloc(sizeof(ldisk_node));
		n2->from = block_id+1;
		n2->to = ldisk_cur->to;
		n2->status = USED;

		ldisk_cur->to = block_id-1;
		n->next = n2;
		n2->next = ldisk_cur->next;
		ldisk_cur->next = n;
	}
}

void changeDir(char* name) {
	int len = strlen(name);
	if(len == 0)
		return;

	char* temp = (char*) malloc(len * sizeof(char));
	strcpy(temp, name);

	dir* old_wd = working_dir;

	if(name[0] == '/') {
		working_dir = root;
	}

	char* sd = strtok(temp, "/");
	while(sd != NULL) {
		if(strcmp(sd, "..") == 0) {
			if(working_dir->parent != NULL) {
				working_dir = working_dir->parent;
			}
		} else if(strcmp(sd, ".") == 0) {
			// Do nothing
		} else {
			int found = 0;
			for(int i = 0; i < working_dir->subdirs->size() && found == 0; i++) {
				if(strcmp(working_dir->subdirs->at(i)->name, sd) == 0) {
					working_dir = working_dir->subdirs->at(i);
					found = 1;
				}
			}

			if(found == 0) {
				printf("cd: %s: No such directory\n", name);
				working_dir = old_wd;
				free(temp);
				return;
			}
		}

		sd = strtok(NULL, "/");
	}

	free(temp);
}

void listFiles() {
	for(int i = 0; i < working_dir->subdirs->size(); i++) {
		printf("%s%s%s ", DIR_COLOR, working_dir->subdirs->at(i)->name, COLOR_RESET);
	}

	for(int i = 0; i < working_dir->files->size(); i++) {
		printf("%s ", working_dir->files->at(i)->name);
	}

	printf("\n");
}

void mkdir(char* name) {
	dir* child = addToDir(working_dir, name);
	if(child == NULL) {
		printf("Unable to create directory %s: name conflict.\n", name);
	}
}

int append(char* name, int size) {
	file_attr* f = NULL;
	for(int i = 0; i < working_dir->files->size(); i++) {
		if(strcmp(working_dir->files->at(i)->name, name) == 0) {
			f = working_dir->files->at(i);
			break;
		}
	}

	if(f == NULL) {
		printf("File %s not found\n", name);
		return 0;
	}

	return append(f, size);
}

int append(file_attr* f, int size) {
	int allocated = allocateDisk(f, size);
	f->size += allocated;
	f->timestamp = time(NULL);
	printf("Allocated %d bytes to %s\n", allocated, f->name);
}


int remove(char* name, int size) {
	file_attr* f = NULL;
	for(int i = 0; i < working_dir->files->size(); i++) {
		if(strcmp(working_dir->files->at(i)->name, name) == 0) {
			f = working_dir->files->at(i);
			break;
		}
	}

	if(f == NULL) {
		printf("File %s not found\n", name);
		return 0;
	}

	return remove(f, size);
}

int remove(file_attr* f, int size) {
	int deallocated = deallocateDisk(f, size);
	f->size -= deallocated;
	f->timestamp = time(NULL);
	printf("Deallocated %d bytes from %s\n", deallocated, f->name);
}

void deleteEntry(char* name) {
	// Search directories first
	dir* d = NULL;
	int i = 0;
	for(i = 0; i < working_dir->subdirs->size(); i++) {
		if(strcmp(working_dir->subdirs->at(i)->name, name) == 0) {
			d = working_dir->subdirs->at(i);
			break;
		}
	}

	if(d != NULL) {
		// Deleting a directory
		if(d->files->size() != 0 || d->subdirs->size() != 0) {
			printf("Unable to delete directory %s: directory not empty.\n", name);
			return;
		}

		working_dir->subdirs->erase(working_dir->subdirs->begin() + i);
		freeDirTree(d);
		working_dir->timestamp = time(NULL);
		return;
	}

	// Search files
	file_attr* f = NULL;
	for(i = 0; i < working_dir->files->size(); i++) {
		if(strcmp(working_dir->files->at(i)->name, name) == 0) {
			f = working_dir->files->at(i);
			break;
		}
	}

	if(f != NULL) {
		// Deleting a file
		f->size -= deallocateDisk(f, f->size);
		if(f->size != 0) {
			printf("Error: Unable to completely deallocate file.");
			return;
		}

		working_dir->files->erase(working_dir->files->begin() + i);
		freeFile(f);
		working_dir->timestamp = time(NULL);
		return;
	}
}

// Print the stats of all files
void bfsDir() {
	deque<dir*> queue;
	queue.push_back(root);

	while(queue.size() != 0) {
		dir* current = queue.front();
		queue.pop_front();

		// Print the current directory structure
		deque<char*> names;
		dir* temp = current;
		while(temp != NULL) {
			names.push_back(temp->name);
			temp = temp->parent;
		}
		while(names.size() != 0) {
			if(strcmp(names.back(), "/"))
				printf("%s/", names.back());
			else 
				printf("%s", names.back());
			names.pop_back();
		}
		printf("\n");

		// Add next nodes
		for(int i = 0; i < current->subdirs->size(); i++)
			queue.push_back(current->subdirs->at(i));
	}	
}

void prdisk() {
	ldisk_node* cur = ldisk;
	while(cur != NULL) {
		printf("%s : %d - %d", (cur->status == FREE ? "FREE" : "USED"), cur->from, cur->to);
		cur = cur->next;
		printf("\n");
	}
	
	// Calculate fragmentation
	deque<dir*> queue;
	queue.push_back(root);

	int64_t fragmentation = 0;
	while(queue.size() != 0) {
		dir* current = queue.front();
		queue.pop_front();

		for(int i = 0; i < current->files->size(); i++) {
			if(current->files->at(i)->size != 0 && current->files->at(i)->size % block_size != 0)
				fragmentation += (block_size - (current->files->at(i)->size % block_size));
		}

		// Add next nodes
		for(int i = 0; i < current->subdirs->size(); i++)
			queue.push_back(current->subdirs->at(i));
	}
	printf("Fragmentation: %ld bytes\n", fragmentation);
}

// Print the stats of all files (in Breadth-first order)
void prfiles() {
	deque<dir*> queue;
	queue.push_back(root);

	int total = 0;
	while(queue.size() != 0) {
		dir* current = queue.front();
		queue.pop_front();

		// Print all files contained in this directory
		for(int i = 0; i < current->files->size(); i++) {
			file_attr* f = current->files->at(i);
			statFile(current, f);
			printf("\n");
			total++;
		}

		// Add next nodes
		for(int i = 0; i < current->subdirs->size(); i++)
			queue.push_back(current->subdirs->at(i));
	}

	printf("prfiles: Done printing %d files.\n", total);
}

// Prints the stats of a single file
void stat(char* name) {
	file_attr* f = NULL;
	for(int i = 0; i < working_dir->files->size(); i++) {
		if(strcmp(working_dir->files->at(i)->name, name) == 0) {
			f = working_dir->files->at(i);
			break;
		}
	}

	if(f != NULL) {
		statFile(working_dir, f);
		return;
	}

	dir* d = NULL;
	for(int i = 0; i < working_dir->subdirs->size(); i++) {
		if(strcmp(working_dir->subdirs->at(i)->name, name) == 0) {
			d = working_dir->subdirs->at(i);
			break;
		}
	}

	if(d != NULL) {
		statDir(d);
		return;
	}

	printf("No such file or directory: %s\n", name);
	return;
}

void statFile(dir* d, file_attr* f) {
	if(f == NULL)
		return;

	printf("Name: %s\n", f->name);

	// Print absolute directory for the file (Unnecessary but useful)
	printf("Directory: ");
	deque<char*> names;
	dir* temp = d;
	while(temp != NULL) {
		names.push_back(temp->name);
		temp = temp->parent;
	}
	while(names.size() != 0) {
		if(strcmp(names.back(), "/"))
			printf("/%s", names.back());
		names.pop_back();
	}
	printf("/\n");

	printf("Size: %ld bytes\n", f->size);

	char buff[40];
	strftime(buff, 40, "%Y-%m-%d %H:%M:%S", localtime(&f->timestamp));
	printf("Timestamp: %d (%s)\n", f->timestamp, buff);
	print_lfile(f, block_size);
}

void statDir(dir* d) {
	if(d == NULL)
		return;

	printf("Name: %s\n", d->name);

	printf("Absolute path: ");
	deque<char*> names;
	dir* temp = d;
	while(temp != NULL) {
		names.push_back(temp->name);
		temp = temp->parent;
	}
	while(names.size() != 0) {
		if(strcmp(names.back(), "/"))
			printf("/%s", names.back());
		names.pop_back();
	}
	printf("/\n");

	printf("Number of files: %d\n", d->files->size());
	printf("Number of directories: %d\n", d->subdirs->size());

	int64_t totalSize = 0;
	for(int i = 0; i < d->files->size(); i++) {
		totalSize += d->files->at(i)->size;
	}
	printf("Size of file content: %ld bytes\n", totalSize);

	char buff[40];
	strftime(buff, 40, "%Y-%m-%d %H:%M:%S", localtime(&d->timestamp));
	printf("Timestamp: %d (%s)\n", d->timestamp, buff);
}

void usage(char* progName) {
	printf("%s (args)\n", progName);
	printf("    -f [input files storing information on files]\n");
	printf("    -d [input files storing information on directories]\n");
	printf("    -s [disk size in bytes]\n");
	printf("    -b [block size in bytes]\n");
}
