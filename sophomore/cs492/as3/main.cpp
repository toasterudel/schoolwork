// John Banya and Christopher Rudel
// "I pledge my honor that I have abided by the Stevens Honor System."

#include "fs.h"

int main(int argc, char* argv[]) {
	if(argc != 9) {
		usage(argv[0]);
		exit(2);
	}

	char* files_info = NULL;
	char* dir_info = NULL;

	// Parse command line args
	int state = -1;
	for(int i = 1; i < argc; i++) {
		if(strcmp(argv[i], "-f") == 0) {
			state = 1;
			continue;
		} else if(strcmp(argv[i], "-d") == 0) {
			state = 2;
			continue;
		} else if(strcmp(argv[i], "-s") == 0) {
			state = 3;
			continue;
		} else if(strcmp(argv[i], "-b") == 0) {
			state = 4;
			continue;
		} else if(state == -1) {
			fprintf(stderr, "Unknown command line arg: %s\n", argv[i]);
			usage(argv[0]);
			exit(2);
		}

		if(state == 3 && sscanf(argv[i], "%i", &disk_size) != 1) {
		    fprintf(stderr, "Disk size is not a parsable integer.\n");
		    usage(argv[0]);
		    exit(2);
		} else if(state == 4 && sscanf(argv[i], "%i", &block_size) != 1) {
			fprintf(stderr, "Block size is not a parsable integer.\n");
		    usage(argv[0]);
		    exit(2);
		} else if(state == 1) {
			files_info = argv[i];
		} else if(state == 2) {
			dir_info = argv[i];
		}

		state = -1;
	}
	
	create_ldisk();

	// Read directory list
	printf("Loading directory list from %s...\n", dir_info);
	int err = load_dir_list(dir_info);
	if(err != 0) {
		fprintf(stderr, "Unable to read file %s\n", dir_info);
		free_ldisk();
		freeDirTree(root);
        exit(1);
	}

    // Read file list
    printf("Loading file list from %s...\n", files_info);
	err = load_file_list(files_info);
	if(err != 0) {
		fprintf(stderr, "Unable to read file %s\n", files_info);
		free_ldisk();
		freeDirTree(root);
        exit(1);
	}

	// Disable SIGINT so that the valid way to exit is via the command 'exit' (so that we can terminate gracefully)
	signal(SIGINT, SIG_IGN);

	// Begin reading commands
	int n;
	char* line;
	char** words;
	line = (char*) malloc(256 * sizeof(char));
	bzero((void*)line, 256 * sizeof(char));
	int quit = 0;
	while(!quit)
	{	
		printf("%s[fssim]$%s ", TERM_COLOR, COLOR_RESET);
		fflush(stdout);
		if((n = read(0, line, 256)) == -1)
		{
			perror(argv[0]);
			exit(1);
		} else if(n >= 2) {
			line[n-1] = '\0';
			words = str2vect(line);
			
			if(!strcmp(words[0], "cd"))
			{
				if (words[1] != NULL)
					changeDir(words[1]);
				else
					printf("usage: cd directory\n");
			}	
			else if(!strcmp(words[0], "cd.."))
			{
				char* back = (char*) malloc(3*sizeof(char));
				strcpy(back, "..");
				back[2] = '\0';
				changeDir(back);
				free(back);
			}
			else if(!strcmp(words[0], "ls"))
			{
				listFiles();
			}
			else if(!strcmp(words[0], "mkdir"))
			{
				if (words[1] != NULL)
					mkdir(words[1]);
				else
					printf("usage: mkdir directory\n");
			}
			else if(!strcmp(words[0], "create"))
			{
				if(words[1] != NULL) {
					file_attr* f = addFileToDir(working_dir, words[1], 0, time(NULL));
			    	if(f == NULL) {
			    		printf("Unable to create file: name conflict\n");
			    	}
				}
				else
					printf("usage: create name \n");
			}
			else if(!strcmp(words[0], "append"))
			{
				if(words[1] != NULL && words[2] != NULL) {
					append(words[1], atoi(words[2]));
				} else
					printf("usage: append name size\n");
			}
			else if(!strcmp(words[0], "remove"))
			{
				if(words[1] != NULL & words[2] != NULL)
					remove(words[1], atoi(words[2]));
				else
					printf("usage: remove name size\n");
			}
			else if(!strcmp(words[0], "delete"))
			{
				if (words[1] != NULL)
					deleteEntry(words[1]);
				else
					printf("usage: delete name\n");
			}
			else if(!strcmp(words[0], "exit"))
			{
				quit = 1;
			}
			else if(!strcmp(words[0], "dir"))
			{
				bfsDir();
			}
			else if(!strcmp(words[0], "prfiles"))
			{
				prfiles();
			}
			else if(!strcmp(words[0], "prdisk"))
			{
				prdisk();
			}
			else if(!strcmp(words[0], "stat"))
			{
				if (words[1] != NULL)
					stat(words[1]);
				else
					printf("usage: stat name\n");
			}
			else if(!strcmp(words[0], "clear"))
			{
				// For sanity...
				printf("\033[2J\033[H");
				fflush(stdout);
			}
			else
			{
				printf("Command not found: %s\n", words[0]);
			}

			int f;
			for(f=0; words[f] != NULL; f++)
				free(words[f]);
			free(words[f]);
			free(words);
		}
	}

	freeDirTree(root); // Recursively frees files and directories starting from and including root
	root = NULL;
	free_ldisk();
	free(line);

	return 0;

}
