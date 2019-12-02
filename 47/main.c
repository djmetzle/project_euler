#define FIND 4
#define PRIME_SIZE 100

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


unsigned long long int factors[FIND];
unsigned long long int factor_powers[FIND];

unsigned long long int * primes;
unsigned long long int N_primes;
unsigned long long int cur_primes=1;


unsigned long long int N_before = 0;
unsigned long long int N = 0;

unsigned long long int int_sqrt(unsigned long long int x) {
	return (unsigned long long int) round( sqrt( (double) x ) );
}

int is_prime(unsigned long long int x) {
        if (x%2==0) return 0;
        unsigned long long int i;
	
        for (i=3;i<int_sqrt(x);i+=2) {
        	if (x % i == 0) return 0;
        }
	return 1;
}

void init_primes() {
	primes = (unsigned long long int *) malloc (PRIME_SIZE * sizeof(unsigned long long int)); 
	N_primes = PRIME_SIZE;
	primes[0] = 2;
	unsigned long long int i;
	for (i=3;cur_primes<N_primes;i+=2) {
		if (is_prime(i)) {
			primes[cur_primes++] = i;
		}	
	}
//	for (i=0;i<N_primes;i++) printf("%llu : %llu\n", i, primes[i]);
	return;
}

void increase_primes() {
	primes = (unsigned long long int *) realloc (primes, 2* N_primes * sizeof(unsigned long long int));
	N_primes *= 2;
	unsigned long long int i;
	for (i=primes[cur_primes-1];cur_primes<N_primes;i+=2) {
		if (is_prime(i)) {
			primes[cur_primes++] = i;
		}	
	}
//	for (i=0;i<N_primes;i++) printf("%llu : %llu\n", i, primes[i]);
	return;
}

unsigned long long int factorize(unsigned long long int x) {
	unsigned long long int factors_found=0;
	unsigned long long int i;
	for (i=0;i<FIND;i++) factors[i] = factor_powers[i] = 0; 
	i = 0;
	unsigned long long int sqrt_X = int_sqrt(x);
	do {
		if (x % primes[i] == 0) { 
			factors[factors_found] = primes[i];
			factor_powers[factors_found] += 1;
			x /= primes[i];
			if (x ==1 ) return factors_found+1;
		 	if (x % primes[i] == 0) continue; 
			else { factors_found++; i++; }
		} else i++;
		if (factors_found >= FIND) return 0;
	} while (primes[i] <= sqrt_X);	
	return factors_found+1;
} 

void test_factorize() {
	int i;
	for (i=1;i<50;i++) {
	printf("%d: found %llu factors:\n",i,factorize(i));
	}
	return;
}

int main() {
	init_primes();
	increase_primes();

	N = 13;
//	test_factorize();

	N_before = 0;

	unsigned long long int found = 0;

	while (1) {
		if (N_before == FIND) break; 
		found = factorize(N++);
		if (found == FIND) N_before++;
		else N_before=0;
	}

	
	printf("%llu\n",N-FIND);


	free(primes);
	return 0;
}
