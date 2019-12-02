#include <stdio.h>
#include <math.h>

#define MAX 1000000

unsigned long int p[MAX];

int is_prime(unsigned long int x) {
	if (x==2) return 1;
	if (x%2==0) return 0;
	int i;
	for (i=3;i<x/2;i+=2) {
	//	printf("%llu mod %llu : %llu\n",x,i,x%i);
		if (x % i == 0) return 0;
	} 
	return 1;
}

int is_prime_fast(unsigned long int x) {
	unsigned long int i=0;
	for (i=0;i<MAX;i++) {
		if (p[i]==x) return 1;
		if (p[i] > x) return 0;
	}
	return 0;
}

int main() {
	unsigned long int i;
	unsigned long int N=0;
	// Populate primes array
	for (i=2;i<MAX;i++) {
		if (is_prime(i)) { 
			p[N++] = i;
		}
	}
	printf("%llu to search\n",N);
	
	unsigned long int j, sum;

	unsigned long int max_n=0, max_sum;

	for (i=0;i<N;i++) {
		printf("%llu : %llu\n",i,p[i]);
		sum = 0;
		for (j=i;j<N;j++) {
			sum += p[j];
			if (is_prime_fast(sum)) { 
//				printf("%llu is sum of %llu primes\n",sum,j-i+i);
				if ((j-i+1>max_n) && (sum<MAX)) { max_n = j-i+1;
					max_sum = sum;
	printf("%llu can be written as the sum of %llu primes\n",max_sum,max_n);
					
				}

			}
			if (sum > MAX) break;
		}
	}
	
	return 0;
}
