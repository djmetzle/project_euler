#include <stdio.h>

#define SQR_SIZE 50

int N = 0;

void check_points(int i, int j, int k, int l) {

	int as = i*i + j*j;
	int bs = k*k + l*l;

	int cs = (k-i)*(k-i) + (l-j)*(l-j);

	if ( ((as + bs) == cs) 
		|| ((as+cs)==bs) 
		|| ((bs+cs)==as) 	
		)N++;

	return;
}

int main() {
	int i,j,k,l;
	for (i=0;i<= SQR_SIZE;i++)
	for (j=0;j<= SQR_SIZE;j++)
	for (k=0;k<= SQR_SIZE;k++)
	for (l=0;l<= SQR_SIZE;l++) {
	// check for points at the origin
		if( (i==j) && (i==0) ) continue;
		if( (k==l) && (k==0) ) continue;

		if( (i==k) && (j==l) ) continue;

		check_points(i,j,k,l);
	}

	printf("Found %d\n",N/2);

	return 0;
}
