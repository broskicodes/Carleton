primeServer.c                                                                                       0000664 0001750 0001750 00000005231 13760250476 013324  0                                                                                                    ustar   braeden                         braeden                                                                                                                                                                                                                #include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <math.h>


#define SERVER_PORT 6000

void *prime(void*);


int main() {
  int                 serverSocket, num;
  struct sockaddr_in  serverAddr, clientAddr;
  int                 status, addrSize, bytesReceived;
  fd_set              readfds, writefds;
  char                buffer[30];
	char *response;

 
  // Create the server socket
  serverSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
  if (serverSocket < 0) {
    printf("*** SERVER ERROR: Could not open socket.\n");
    exit(-1);
  }

  // Setup the server address
  memset(&serverAddr, 0, sizeof(serverAddr)); // zeros the struct
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_addr.s_addr = htonl(INADDR_ANY);
  serverAddr.sin_port = htons((unsigned short) SERVER_PORT);

  // Bind the server socket
  status = bind(serverSocket, (struct sockaddr *) &serverAddr, sizeof(serverAddr));
  if (status < 0) {
    printf("*** SERVER ERROR: Could not bind socket.\n");
    exit(-1);
  }

  // Wait for clients now
  while (1) {
    FD_ZERO(&readfds);
    FD_SET(serverSocket, &readfds);
    FD_ZERO(&writefds);
    FD_SET(serverSocket, &writefds);
    status = select(FD_SETSIZE, &readfds, &writefds, NULL, NULL);
    if (status == 0) {
      // Timeout occurred, no client ready
    }
    else if (status < 0) {
      printf("*** SERVER ERROR: Could not select socket.\n");
      exit(-1);
    }
    else {
      addrSize = sizeof(clientAddr);
      bytesReceived = recvfrom(serverSocket, buffer, sizeof(buffer),
                               0, (struct sockaddr *) &clientAddr, &addrSize);
      if (bytesReceived > 0) {
        buffer[bytesReceived] = '\0';
        printf("SERVER: Received client request: %s\n", buffer);
      }
			
			// If the client said to stop, then I'll stop myself
      if (strcmp(buffer, "stop") == 0)
				break;

			sscanf(buffer, "%d", &num);
			response = prime(&num);

      // Respond with an "OK" message
			printf("SERVER: Sending \"%s\" to client\n", response);
			sendto(serverSocket, response, strlen(response), 0,
				(struct sockaddr *) &clientAddr, sizeof(clientAddr));
    }
  } 

  // Don't forget to close the sockets!
  close(serverSocket);
  printf("SERVER: Shutting down.\n");
}

void *prime(void *n) {
  int i;
  int num = *((int *)n);
  int max = (int) sqrt(num);
  // char*               response;


  for (i = 2; i <= max; i++) {
    usleep(1000);
    if (num % i == 0) {
      printf("SERVER: %d is not prime\n", num);
			return "number is not a prime";
      // return NULL;
    }
  }
  printf("SERVER: %d is prime\n", num);
	return "number is a prime";
}                                                                                                                                                                                                                                                                                                                                                                       primeThreads.c                                                                                      0000664 0001750 0001750 00000001347 13760242671 013452  0                                                                                                    ustar   braeden                         braeden                                                                                                                                                                                                                #include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <pthread.h>

void *prime(void*);

int main() 
{
  int i;
	pthread_t thrs[10];

  long int number[10] = {5011*5009, 1293961, 1293967, 5021*4241, 4723*5009, 
                         5011*5021, 1299173, 1160807, 4241*4723, 1161829};

  for (i = 0; i < 10; i++) {
		pthread_create(&(thrs[i]), NULL, prime, number+i);
  } 

	for (i = 0; i < 10; i++) {
		pthread_join(thrs[i], NULL);
  } 

  return(0);
}


void *prime(void *n) {
  int i;
  long int num = *((long int *)n);
  int max = (int) sqrt(num);
  for (i = 2; i <= max; i++) {
    usleep(1000);
    if (num % i == 0) {
      printf("%ld is not prime\n", num);
      return NULL;
    }
  }
  printf("%ld is prime\n", num);
}

                                                                                                                                                                                                                                                                                         userClient.c                                                                                        0000664 0001750 0001750 00000003623 13760250153 013131  0                                                                                                    ustar   braeden                         braeden                                                                                                                                                                                                                #include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define SERVER_IP "127.0.0.1"
#define SERVER_PORT 6000

int main(){
	int clientSocket, addrSize, bytesReceived;
	struct sockaddr_in  clientAddr;
	int i;

	// int inNum;
	char inStr[80];
  char buffer[80];

	// Create socket
  clientSocket = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
  if (clientSocket < 0) {
    printf("*** CLIENT ERROR: Could open socket.\n");
    exit(-1);
  }

	// Setup address 
  memset(&clientAddr, 0, sizeof(clientAddr));
  clientAddr.sin_family = AF_INET;
  clientAddr.sin_addr.s_addr = inet_addr(SERVER_IP);
  clientAddr.sin_port = htons((unsigned short) SERVER_PORT);

	/* connect to server */

  i = connect(clientSocket, 
              (struct sockaddr *) &clientAddr,
              sizeof(clientAddr));
  if (i<0) {
    printf("client could not connect!\n");
    exit(-1);
  }

/* get input from user and send to server */
  while (1) {
    printf("CLIENT: Enter number to send to primeServer, 'done' to stop:\t\t");
   scanf("%s", inStr);
    // fgets(inStr, sizeof(inStr), stdin);
    // inStr[strlen(inStr)-1] = 0;
    // strcpy(buffer, inNUm);
    strcpy(buffer, inStr);
    printf("CLIENT: Sending \"%s\" to server.\n", buffer);

    sendto(clientSocket, buffer, strlen(buffer), 0,
           (struct sockaddr *) &clientAddr, sizeof(clientAddr));

    // Get response from server, should be "OK"
    addrSize = sizeof(clientAddr);
    bytesReceived = recvfrom(clientSocket, buffer, 80, 0,
		        (struct sockaddr *) &clientAddr, &addrSize);
    buffer[bytesReceived] = 0; // put a 0 at the end so we can display the string
    printf("CLIENT: Got back response \"%s\" from server.\n", buffer);
    
    if ((strcmp(inStr,"done") == 0) || (strcmp(inStr,"stop") == 0))
      break;
  } 

/* close the socket */

  close(clientSocket);

  return 0;
	
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             