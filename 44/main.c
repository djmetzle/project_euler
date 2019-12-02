
#define N_MAX 100000

unsigned long int P[N_MAX];

inline unsigned long int pent(unsigned long int i) {
	return i*(3*i-1)/2;
}

inline int is_pent(unsigned long int val, unsigned long int cur_i) {
	int i;
	for(i=1;i<cur_i;i++) {
		if (P[i] == val) return 1;	
	}
	return 0;
}

int main() {
	unsigned long int i,j,k;
	unsigned long int D=pent(N_MAX);
	unsigned long int test;

	for (i=1;i<N_MAX;i++) {
		P[i] = pent(i);
//		printf("%llu : %llu --\n",i,P[i]);
		for (j=1;j<i;j++) {
			for(k=1;k<j;k++) {
				if (P[j]+P[k] == P[i]) {

		//			printf("P[%llu] = %llu is sum of pents P[%llu] + P[%llu]\n", 
		//				i, P[i], j, k);
					test = P[j]-P[k];
					if (is_pent(test,i)) { 
				//		printf("!!---difference is pent!!!!---\n"); 
						if (test < D) {
							D = test;
							printf("%llu\n",D);
						}
					}

				}
			}
		}
	}
	return 0;
}
