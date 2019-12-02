#include "stdio.h"

#define N_SIZE 1000000

long d_sums[N_SIZE];

void print_d_sum() {
	for (int i=0; i<N_SIZE; i++) {
		printf("%d\n",d_sums[i]);
	}

	return;
}

void init_d_sum() {
	for (int i=0; i<N_SIZE; i++) {
		if (i % 1000 ==0) { printf("%d...\n", i); }
		long d_sum = 0;
		for (int d=1; d< (i/2 + 1); d++) {
			if (i % d == 0) {
				d_sum += d;
			}
		}
		d_sums[i] = d_sum;
	}
	return;
}

int main() {
	init_d_sum();
	print_d_sum();


	return 0;
}
