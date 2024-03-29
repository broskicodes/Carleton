#include <stdio.h>
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

