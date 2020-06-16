#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>

int main(int argc, char** argv){
    int serversock;
    struct sockaddr_in echoserver;
    serversock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if(serversock == 0){
		perror("Socket failure");
		exit(EXIT_FAILURE);
	}
    memset(&echoserver, 0, sizeof(echoserver));
    echoserver.sin_family = AF_INET;
    echoserver.sin_addr.s_addr = htonl(INADDR_ANY);
    echoserver.sin_port = htons(atoi(argv[1])); /* server port */
    bind(serversock, (struct sockaddr *) &echoserver, sizeof(echoserver));
    listen(serversock, MAXPENDING);
	clientsock = accept(serversock, (struct sockaddr *) &echoserver, )
}
