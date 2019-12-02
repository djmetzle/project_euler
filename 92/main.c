#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_SEARCH 10000000

unsigned long long int N; // number found

void check_chain(unsigned long long int x) {
	char c[20]={0};
	sprintf(c, "%020llu", x);
	int i;
	unsigned long long int sum=0;
	for (i=0;i<20;i++) {
		int z = c[i] - '0';
		sum += z*z;
	}

	if (sum == 89) N++; //printf( "%llu : %llu\n",x,sum); }
	else if (sum == 1) ;//printf( "%llu : %llu\n",x,sum); 
	else { check_chain(sum); }


	return;
}

int main() {
//	printf("%020llu\n",(unsigned long long int)ULLONG_MAX);

	unsigned long long int i;
	for (i=1;i<=MAX_SEARCH;i++) {
		check_chain(i);
	}
	printf("found %llu that tend to 89\n",N);
	return 0;
}
