#include <stdio.h>
#include <math.h>

int main() {
	int N = 0;
	int base;
	int power = 1;

	int tempn;
	int found;

	char str[100];
	unsigned long int X, min, max;
	
	int i;

	unsigned long int ipow(unsigned long int x, unsigned long int y) {
		int i;
		unsigned long int temp = x;
		for (i=1;i<y;i++) temp *= x; 
		return temp;
	}


	do {
		found = 0;	
		tempn = N;
		min = 1;
		for (i=1;i<power;i++) min*=10;
		max = 10;
		for (i=1;i<power;i++) max*=10;
	
		base = 1;
		for (base=1;base<10;base++) {
			X = ipow(base,power);
			if ( (X>=min) && (X<max) ) {
				printf("%d ^ %d = %llu\n", base, power, X);
				N++;
				found +=1;
			}
		}
		printf("found %d powers for %d : N = %d\n",N-tempn, power, N); 
		power += 1;
	} while (1);
	


	return 0;
}
