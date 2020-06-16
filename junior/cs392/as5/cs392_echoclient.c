/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_echoclient.c
*   I pledge my honor that I have abided by the Stevens Honor System Christopher Rudel
*
*/

#include <stdio.h>
#include <netdb.h> 
#include <netinet/in.h> 
#include <stdlib.h> 
#include <string.h> 
#include <sys/socket.h> 
#include <sys/types.h> 
#include <sys/wait.h>
#include <arpa/inet.h>
#include <unistd.h>

//#include "cs392_log.h"
/* I'd rather have include statements in the header file but the assignment 
said to only have the header file be for the server and log files */

int main(int argc, char** argv){
	if(argc != 3){
		perror("Incorrect number of arguments: Expected 2.\n");
		exit(EXIT_FAILURE);
	}

	int sock;
	struct sockaddr_in echoserver;
	char buffer[1024];

	/* creating a socket */
	if( (sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == 0){
		perror("Socket failure. Exiting...\n");
		exit(EXIT_FAILURE);
	}
	memset(&echoserver, 0, sizeof(echoserver));
	echoserver.sin_family = AF_INET;
	echoserver.sin_addr.s_addr = inet_addr(argv[1]); /*Should be the IP address*/
	echoserver.sin_port = htons(atoi(argv[2])); /*Should be server port*/
	
	/* It will need to connect to the server using the "connect" interface. */
	if( connect(sock, (struct sockaddr *) &echoserver, sizeof(echoserver)) < 0){
		perror("Connection failed. Exiting...\n");
		exit(EXIT_FAILURE);
	}else{
		printf("Connection established. Please enter your message to the server:\n");
		fgets(buffer, sizeof(buffer), stdin); //Originally I had scanf but it didnt like spaces in input
		buffer[strlen(buffer)-1] = '\0'; //This would be a newline which makes things a little funky
		printf("sending message: %s\n", buffer);

		if( send(sock, buffer, strlen(buffer), 0) == -1){
			perror("Error sending. Exiting...\n");
			exit(EXIT_FAILURE);
		}
		memset(buffer, 0, sizeof(buffer)); /*If the server doesnt send anything back we'll know because it'll be empty */
		if( recv(sock, buffer, 1024-1, 0) == -1){
			perror("Error receiving. Exiting...\n");
			exit(EXIT_FAILURE);
		}
		/*After receiving the echo, it will print the message to standard output, */
		printf("Received message: %s\n", buffer); 
		fflush(stdout);
		close(sock); /* close the socket, */
	}
	return 0; /* and exit the program. */
}
