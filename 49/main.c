#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

int primes[1500];
//char permutations[24][4];

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
	int found = 0;
	int i,j;
	int N=0;
	// find all the primes we need to search
	for (i=1001;i<10000;i+=2) {
		if (is_prime(i)) {
			primes[N++] = i;	
		}
	}
	for (N=67;N<1500;N++) {
	// write a prime down
	char str[5];
	sprintf(str,"%d",primes[N]);
	// find all permuations
	char a=str[0]; char b=str[1]; char c=str[2]; char d=str[3];
	char permutations[24][4] = { {a,b,c,d},{a,b,d,c},{a,c,b,d},{a,c,d,b},
		{a,d,b,c},{a,d,c,b},{b,a,c,d},{b,a,d,c},
		{b,c,a,d},{b,c,d,a},{b,d,a,c},{b,d,c,a},
		{c,a,b,d},{c,a,d,b},{c,b,a,d},{c,b,d,a},
		{c,d,a,b},{c,d,b,a},{d,a,b,c},{d,a,c,b},
		{d,b,a,c},{d,b,c,a},{d,c,a,b},{d,c,b,a}};
	// rewrite the permutations as ints
	int perm_ns[24];
	int perm_ns_sorted[24];
	for(i=0;i<24;i++) { 
		strncpy(str,permutations[i],4);
		perm_ns[i] = atoi(str);
	}
	// sort the permutations
	for (i=23;i>=0;i--) {
		int largest=0;
		int large_j;
		for (j=0;j<24;j++) if (perm_ns[j] > largest) {
			largest = perm_ns[j]; large_j = j;	
		}
		perm_ns_sorted[i] = perm_ns[large_j];
		perm_ns[large_j]=0;	
	}
	// find increaing primes in the permutations
	int prime_perms[28];
	prime_perms[0] = primes[N];
	int n = 1;
	for (i=0;i<24;i++) { 
		if ((perm_ns_sorted[i] > prime_perms[n-1]) && (is_prime(perm_ns_sorted[i]))) {
			prime_perms[n++] = perm_ns_sorted[i];
		}
	}
//	printf("%02d: %d\n",n,primes[N]);
	// search for sequence
	int difference;
	int k;
	for (i=0;i<n;i++) {
		for (j=i+1;j<n;j++) {
			difference = prime_perms[j]-prime_perms[i];
			for (k=j+1;k<n;k++) if ((prime_perms[k]-prime_perms[j] == difference)) 
				if (difference == 3330) 
				printf("%d%d%d\n",prime_perms[i],prime_perms[j],prime_perms[k]);
		}
	}
	}
	
	return 0;
}
