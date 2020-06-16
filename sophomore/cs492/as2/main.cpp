#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <deque>
#include <vector>
#include <math.h>

#define FIFO 0
#define LRU 1
#define CLOCK 2
#define MEMORY_SIZE 512

using namespace std;

void default_load();
void access_page_fifo(int, int);
void access_page_lru(int, int);
void access_page_clock(int, int);
void swap_memory(int, int);

typedef struct page {
    int page_number;
    int valid;
    unsigned int last_time_accessed;
    unsigned int time_added;
    int referenced;
} Page;

typedef struct process {
    int pid;
    int page_table_size;
    Page** page_table;
    deque<int>* page_queue; // Contains a queue of indices to be used in conjunction with the page table (FIFO and Clock).
    int hand_position; // Hand position (in page_queue) for Clock
} Process;

vector<Process*> processes;

int pageSize, pageAlgorithm, prepaging;
unsigned int totalPageFaults = 0;
unsigned int g_counter = 1;

int* main_memory; // Simuates main memory by storing the unique page names

int main(int argc, char *argv[])
{
    if(argc != 5 && argc != 6)
    {
        fprintf(stderr, "Invalid number of arguments.\n");
        fprintf(stderr, "Usage:\n");
        fprintf(stderr, "\tVMsimulator [plist] [ptrace] [page size] [replacement algorithm] [+/- pre-paging]\n");
        exit(1);
    }

    // Read args
    // argv[1] and argv[2] are plist and ptrace respectively
    if(sscanf(argv[3], "%i", &pageSize) != 1)
    {
        fprintf(stderr, "Argument 1 (size of pages) is not a parsable integer\n");
        exit(1);
    }

    char flag = '-';
    if(argc == 6 && sscanf(argv[5], "%c", &flag) != 1)
    {
        fprintf(stderr, "Argument 3 (Pre-paging) is not a parsable character\n");
        exit(1);
    }

    // Validate args
    if(pageSize <= 0)
    {
        fprintf(stderr, "Invalid page size (%d).\n", pageSize);
        exit(1);
    }

    if(strcmp(argv[4], "FIFO") == 0) {
        pageAlgorithm = FIFO;
    } else if(strcmp(argv[4], "LRU") == 0) {
        pageAlgorithm = LRU;
    } else if(strcmp(argv[4], "Clock") == 0) {
        pageAlgorithm = CLOCK;
    } else {
        fprintf(stderr, "Invalid page algorithm, expected \"FIFO\" or \"LRU\" or \"Clock\", received %s\n", argv[4]);
        exit(1);
    }
    
    if(flag == '+') {
        prepaging = 1;
    } else if(flag == '-') {
        prepaging = 0;
    } else {
        fprintf(stderr, "Invalid pre-paging flag, expected + or -, received %c\n", flag);   
        exit(1);
    }

    // Open process files
    FILE* plist = fopen(argv[1], "r");
    if(plist ==  NULL)
    {
        fprintf(stderr, "Unable to open file %s\n", argv[1]);
        exit(1);
    }

    FILE* ptrace = fopen(argv[2], "r");
    if(ptrace == NULL) 
    {
        fprintf(stderr, "Unable to open file %s\n", argv[2]);
        fclose(plist);
        exit(1);
    }

    // Print out all args
    printf("Using args:\n");
    printf("\tLoading programs from %s\n", argv[1]);
    printf("\tLoading memory accesses from %s\n", argv[2]);
    printf("\tSize of pages: %d\n", pageSize);
    printf("\tPage replacement algorithm: %s\n", argv[4]);
    flag == '+' ? printf("\t(+) Pre-paging turned on\n") : printf("\t(-) Pre-paging turned off\n");
    printf("\n");

    // Load processes from plist
    char* line;
    size_t len = 0;
    int upageid = 1;
    while(getline(&line, &len, plist) != -1)
    {
        if(strlen(line) == 1 && line[0] == '\n') {
            // Skip empty lines
            continue;
        }

        int pid, memory;

        // Split
        char* elems = strtok(line, " ");
        if(elems) 
        {
            // Process ID
            if(sscanf(elems, "%i", &pid) != 1) {
                fprintf(stderr, "Invalid entry in plist line: %s\n", line);
                fclose(plist);
                exit(1);
            }
        }

        elems = strtok(NULL, " ");
        if(elems) 
        {
            // Process memory
            if(sscanf(elems, "%i", &memory) != 1) {
                fprintf(stderr, "Invalid entry in plist line: %s\n", line);
                fclose(plist);
                exit(1);
            }
        }

        // Create the process and its page table
        int numPages = ceil((double)memory / (double)pageSize);
        printf("Loading process %d with %d memory addresses (%d pages).\n", pid, memory, numPages);
        Process* proc = (Process*) malloc(sizeof(Process));
        proc->page_table = (Page**) malloc(numPages * sizeof(Page*));
        for(int i = 0; i < numPages; i++) {
            proc->page_table[i] = (Page*) malloc(sizeof(Page));
            proc->page_table[i]->page_number = upageid++;
            proc->page_table[i]->valid = 0;
        }
        proc->page_table_size = numPages;
        proc->pid = pid;
        proc->page_queue = new deque<int>();
        processes.push_back(proc);
    } 
    fclose(plist);

    // Perform default load of first pages
    main_memory = (int*) malloc(MEMORY_SIZE * sizeof(int));
    for(int i = 0; i < MEMORY_SIZE; i++)
        main_memory[i] = -1;
    default_load();

    // Begin executing processes based on the information located in ptrace
    printf("\n");
    while(getline(&line, &len, ptrace) != -1)
    {   
        if(strlen(line) == 1 && line[0] == '\n') {
            // Skip empty lines
            continue;
        }

        int pid, memory;

        // Split
        char* elems = strtok(line, " ");
        if(elems) 
        {
            // Process ID
            if(sscanf(elems, "%i", &pid) != 1) {
                fprintf(stderr, "Invalid entry in ptrace line: %s\n", line);
                fclose(ptrace);
                exit(1);
            }
        }

        elems = strtok(NULL, " ");
        if(elems) 
        {
            // Process memory
            if(sscanf(elems, "%i", &memory) != 1) {
                fprintf(stderr, "Invalid entry in ptrace line: %s\n", line);
                fclose(ptrace);
                exit(1);
            }
        }

        // Line read successfully
        // Begin accessing memory
        int page_num = ceil((double)memory / (double)pageSize);
        page_num = page_num-1; // Convert [1,n] from ptrace to [0,n) format used here
        switch (pageAlgorithm) {
        case FIFO:
            access_page_fifo(pid, page_num);
            break;
        case LRU:  
            access_page_lru(pid, page_num);
            break;
        case CLOCK:
            access_page_clock(pid, page_num);
            break;
        default:
            fprintf(stderr, "[!] Unknown paging algorithm.\n");
            exit(1);
            break;
        }

        g_counter++;   
    }
    fclose(ptrace);

    printf("All processes finished.\n");
    printf("Total page faults: %d\n", totalPageFaults);

    // Free all processes and page tables
    for(int i = 0; i < processes.size(); i++) {
        for(int j = 0; j < processes.at(i)->page_table_size; j++)
            free(processes.at(i)->page_table[j]);

        free(processes.at(i)->page_table);
        delete processes.at(i)->page_queue;
        free(processes.at(i));
    }

    free(main_memory);

    return 0;   
}

// Performs the default load and sets up the page queue depending on the algorithm used
void default_load() {
    int memsize = MEMORY_SIZE / processes.size();
    printf("Splitting memory evenly between %ld processes (%d memory locations | %d pages).\n", processes.size(), memsize, memsize/pageSize);

    int memloc = 0;
    for(int p = 0; p < processes.size(); p++) {
        for(int i = 0; i < memsize/pageSize; i++) {
            if(i < processes.at(p)->page_table_size) {
                processes.at(p)->page_table[i]->valid = 1;
                processes.at(p)->page_table[i]->last_time_accessed = 0;
                processes.at(p)->page_table[i]->time_added = 0;
                processes.at(p)->page_table[i]->referenced = 1;
                totalPageFaults++;

                // Add main memory
                for(int j = 0; j < pageSize; j++)
                    main_memory[memloc++] = processes.at(p)->page_table[i]->page_number;

                if(pageAlgorithm == FIFO || pageAlgorithm == CLOCK) {
                    processes.at(p)->page_queue->push_back(i);
                }
            } else {
                memloc++;
            }
        }
    }
}

// Access a page using the FIFO algorithm
void access_page_fifo(int pid, int page_num) {
    Process* proc = processes.at(pid); 
    if(proc->page_table[page_num]->valid) {
        // Page is already in memory
        proc->page_table[page_num]->last_time_accessed = g_counter;
        proc->page_table[page_num]->referenced = 1;
        return;
    }

    // Page is not in memory
    // Remove the oldest page in the queue
    // In the case that prepaging is enabled, we will also find the second oldest and swap that out for the next invalid page
    int min_i = -1;
    if(proc->page_queue->size() != 0) {
        min_i = proc->page_queue->front();
        proc->page_queue->pop_front();
    } else {
        // No available pages to swap out (should never happen besides for when no pages are in memory due to large page sizes)
        printf("[!] Unable to find page to swap. Try lowering the page size!\n");
        exit(1);
    }

    printf("Page fault in process %d. Swapping out page %d for page %d (FIFO).\n", pid, min_i+1, page_num+1);
    totalPageFaults++;

    proc->page_table[min_i]->valid = 0;
    proc->page_table[page_num]->valid = 1;
    proc->page_table[page_num]->time_added = g_counter;
    proc->page_table[page_num]->last_time_accessed = g_counter;
    proc->page_table[page_num]->referenced = 1;
    proc->page_queue->push_back(page_num);

    swap_memory(proc->page_table[min_i]->page_number, proc->page_table[page_num]->page_number);

    // Find the next non-valid page for pre-paging
    int pageToSwap = -1;
    for(int i = 1; i < proc->page_table_size && pageToSwap == -1; i++) {
        int temp = (page_num + i) % proc->page_table_size;
        if(proc->page_table[temp]->valid == 0) {
            pageToSwap = temp;
        }
    }

    // Get the second oldest page for prepaging
    int smin_i = proc->page_queue->front();
    if(prepaging && proc->page_queue->size() > 1 && pageToSwap != -1 && pageToSwap != page_num && smin_i != page_num) {
        proc->page_queue->pop_front();

        printf("\t> Also swapping out page %d for %d (pre-paging).\n", smin_i+1, pageToSwap+1);
        proc->page_table[smin_i]->valid = 0;
        proc->page_table[pageToSwap]->valid = 1;
        proc->page_table[pageToSwap]->time_added = g_counter;
        proc->page_table[pageToSwap]->last_time_accessed = g_counter;
        proc->page_table[pageToSwap]->referenced = 1;
        proc->page_queue->push_back(pageToSwap);

        swap_memory(proc->page_table[smin_i]->page_number, proc->page_table[pageToSwap]->page_number);
    }
    
    return;
}

// Access a page using the LRU algorithm
void access_page_lru(int pid, int page_num) {
    Process* proc = processes.at(pid);
    if(proc->page_table[page_num]->valid) {
        // Page is already in memory
        proc->page_table[page_num]->last_time_accessed = g_counter;
        proc->page_table[page_num]->referenced = 1;
        return;
    }

    // Page is not in memory
    // Find the page that was accessed longest ago and swap it out
    // In the case that prepaging is enabled, we will also find the second candidate and swap that out for next invalid page
    unsigned int min = g_counter+1, smin = g_counter+1;
    int min_i = -1, smin_i = -1;
    for(int i = 0; i < proc->page_table_size; i++) {
        unsigned int val = proc->page_table[i]->last_time_accessed;
        if(val < min && proc->page_table[i]->valid == 1) {
            smin = min;
            smin_i = min_i;  
            min = val;
            min_i = i;
        } else if(val < smin && proc->page_table[i]->valid == 1) {
            smin = val;
            smin_i = i;  
        }
    }

    if(min_i == -1) {
        // No available pages to swap out (should never happen besides for when no pages are in memory due to large page sizes)
        printf("[!] Unable to find page to swap. Try lowering the page size!\n");
        exit(1);
    }

    printf("Page fault in process %d. Swapping out page %d for page %d (LRU).\n", pid, min_i+1, page_num+1);
    totalPageFaults++;

    proc->page_table[min_i]->valid = 0;
    proc->page_table[page_num]->valid = 1;
    proc->page_table[page_num]->time_added = g_counter;
    proc->page_table[page_num]->last_time_accessed = g_counter;
    proc->page_table[page_num]->referenced = 1;

    swap_memory(proc->page_table[min_i]->page_number, proc->page_table[page_num]->page_number);

    // Find the next non-valid page for pre-paging
    int pageToSwap = -1;
    for(int i = 1; i < proc->page_table_size && pageToSwap == -1; i++) {
        int temp = (page_num + i) % proc->page_table_size;
        if(proc->page_table[temp]->valid == 0) {
            pageToSwap = temp;
        }
    }

    if(prepaging && smin_i != -1 && pageToSwap != -1 && pageToSwap != page_num && smin_i != page_num) {
        printf("\t> Also swapping out page %d for %d (pre-paging).\n", smin_i+1, pageToSwap+1);
        proc->page_table[smin_i]->valid = 0;
        proc->page_table[pageToSwap]->valid = 1;
        proc->page_table[pageToSwap]->time_added = g_counter;
        proc->page_table[pageToSwap]->last_time_accessed = g_counter;
        proc->page_table[pageToSwap]->referenced = 1;

        swap_memory(proc->page_table[smin_i]->page_number, proc->page_table[pageToSwap]->page_number);
    }
    
    return;
}

void access_page_clock(int pid, int page_num) {
    Process* proc = processes.at(pid);
    if(proc->page_table[page_num]->valid) {
        // Page is already in memory
        proc->page_table[page_num]->last_time_accessed = g_counter;
        proc->page_table[page_num]->referenced = 1;
        return;
    }

    // Page is not in memory
    // Perform the clock algorithm
    if(proc->page_queue->size() == 0) {
        printf("[!] Unable to find page to swap. Try lowering the page size!\n");
        exit(1);
    }

    if(proc->hand_position >= proc->page_queue->size()) {
        proc->hand_position = 0;
    }

    // Search for a page that is not referenced and evict it
    int evicted = -1;
    while(evicted == -1) {
        int table_index = proc->page_queue->at(proc->hand_position);
        if(proc->page_table[table_index]->referenced == 0) {
            // Page at hand position is not referenced, evict it
            proc->page_table[table_index]->valid = 0;
            proc->page_table[page_num]->valid = 1;
            proc->page_table[page_num]->time_added = g_counter;
            proc->page_table[page_num]->last_time_accessed = g_counter;
            proc->page_table[page_num]->referenced = 1;
            proc->page_queue->at(proc->hand_position) = page_num;

            swap_memory(proc->page_table[table_index]->page_number, proc->page_table[page_num]->page_number);
            evicted = table_index;
        } else {
            // Page at hand position is referenced
            proc->page_table[table_index]->referenced = 0;
        }

        proc->hand_position++;
        if(proc->hand_position >= proc->page_queue->size()) {
            proc->hand_position = 0;
        }
    }

    printf("Page fault in process %d. Swapping out page %d for page %d (Clock).\n", pid, evicted+1, page_num+1);
    totalPageFaults++;

    // Find the next non-valid page for pre-paging
    int pageToSwap = -1;
    for(int i = 1; i < proc->page_table_size && pageToSwap == -1; i++) {
        int temp = (page_num + i) % proc->page_table_size;
        if(proc->page_table[temp]->valid == 0) {
            pageToSwap = temp;
        }
    }

    // Perform the same operation if prepaging is enabled, but for the next invalid page_num
    if(prepaging && processes.at(pid)->page_queue->size() > 1 && pageToSwap != -1 && pageToSwap != page_num) {
        evicted = -1;
        while(evicted == -1) {
            int table_index = proc->page_queue->at(proc->hand_position);
            if(proc->page_table[table_index]->referenced == 0) {
                // Page at hand position is not referenced, evict it
                proc->page_table[table_index]->valid = 0;
                proc->page_table[pageToSwap]->valid = 1;
                proc->page_table[pageToSwap]->time_added = g_counter;
                proc->page_table[pageToSwap]->last_time_accessed = g_counter;
                proc->page_table[pageToSwap]->referenced = 1;
                proc->page_queue->at(proc->hand_position) = pageToSwap;

                swap_memory(proc->page_table[table_index]->page_number, proc->page_table[pageToSwap]->page_number);
                evicted = table_index;
            } else {
                // Page at hand position is referenced
                proc->page_table[table_index]->referenced = 0;
            }

            proc->hand_position++;
            if(proc->hand_position >= proc->page_queue->size()) {
                proc->hand_position = 0;
            }
        }
        printf("\t> Also swapping out page %d for %d (pre-paging).\n", evicted+1, pageToSwap+1);
    }    

    return;
}

// Swap one value (unique ID) in main memory for another
void swap_memory(int from, int to) {
    int found = 0;
    for(int i = 0; i < MEMORY_SIZE; i++) {
        if(main_memory[i] == from) {
            main_memory[i] = to;
            found = 1;
        }
    }

    if(found)
        return;

    // Not found? Something went wrong...
    printf("Page in memory not found. Main memory simulation corrupted, quitting...\n");
    exit(1);
}
