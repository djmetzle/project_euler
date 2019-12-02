#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int int_sqrt(int x) {
        return (int) round( sqrt( (double) x ) );
}

int is_prime(int x) {
        if (x%2==0) return 0;
        int i;
        for (i=3;i<int_sqrt(x);i+=2) {
        	if (x % i == 0) return 0;
        }
	return 1;
}

int main() {	
	int i,j,k;	
	
	int digits[20];
	int places = 1;

	int sum;

	void clear_digits() {
		int i;
		for(i=0;i<20;i++) digits[i] = 0;
		return;
	}

	int sum_digits() {
		int tens = 1; 
		int i;
		int sum = 0;
		for (i=0;i<places;i++) {
			sum += tens * digits[i];	
			tens *= 10;
		}
		return sum;
	}
	void init_digits(int s) {
		int i;
		for (i=0;i<s;i++) {
			digits[i]=i;	
		}
	}

	int next_combination(int places, int s) {
		int i;
		digits[places-1]++;
		for (i=places-1;i>0;i--) {
			if (digits[i] == places) {
				digits[i-1]++;
			}	
		}
		for (i=1;i<places;i++) if (digits[i] == places) digits[i] = digits[i-1]+1;
		if (digits[0] == places) return 0;
		return 1;
	}

	for (;;) {
		int replaces = 1;	
		int primes = 0;
		for (replaces=1;replaces<places;replaces++) {
			do {
				int search_max;
				char str[32]; 
				for (i=0;i<places;i++) str[i] = i;
				str[places] = '\0';
				search_max
			} while (next_combination(places,replaces);

		}
		clear_digits();
		init_digits(
	
	
		places++;
	}

	return 0;
}
