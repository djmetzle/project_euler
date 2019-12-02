#include <stdio.h>
#include <stdlib.h>

int main() {

	int N=0;

	char message[1202];

void fill_message() {

	char ct[4];
	void clear_ct() { int i; for (i=0;i<4;i++) ct[i]=' '; }

	FILE *fp;
	fp = fopen("cipher1.txt", "r");

	rewind(fp);

	int i,j;
	int have_comma,have_eof=0;
	char c;
	while (!have_eof) {
		clear_ct();
		have_comma=0;
		for(j=0;j<3;j++) {
			if (!have_comma) {
				c = fgetc(fp);
				if (c=='\n') continue;
				if (c==EOF) { have_eof=1; break; }
				if (c==',') have_comma = 1;
				else ct[j] = c;
			}
		}
		if (have_eof==0) {
		int value = atoi(ct);
//		printf("%s : %d\n",ct,value); 
		message[N++] = (char) value; }
	
	}
	printf("Message is %d characters long\n",N);
	fclose(fp);

}

	fill_message();

	char plain_text[1202];
	char passkey[3]={97,97,97};

	int n_e, n_spaces = 0;
	int max_n_e=0; 
	int max_n_spaces = 0;

	void test_key() {
		int i;
		char temp;
		n_e = n_spaces = 0;
		for (i=0;i<N;i++) {
			temp = message[i] ^ passkey[i%3];
			if (temp ==' ') n_spaces += 1;
			if (temp =='e') n_e +=1;
			plain_text[i] = temp;
		}
		if (n_spaces > max_n_spaces) {
			max_n_spaces = n_spaces; 
//			printf("%d spaces found:\n%s : %s\n",max_n_spaces,passkey,plain_text);
		}
		if (n_e > max_n_e) { 
			max_n_e = n_e;
//			printf("%d e's found:\n%s : %s\n",max_n_e,passkey,plain_text);
		}

	}
		

	while (passkey[2] != 123) {
		if (passkey[0] == 123) {
			passkey[0] = 97;
			passkey[1] +=1;
		}
		if (passkey[1] == 123) {
			passkey[1] = 97;
			passkey[2] +=1;
		}	

		test_key();

		passkey[0] += 1;
	}
	
	int i;
	for (i=0;i<N;i++) plain_text[i] = message[i] ^ "god"[i%3];
	printf("%s\n",plain_text);	

	int sum =0;
	for (i=0;i<N;i++) sum += (int)(plain_text[i]);

	printf("%d is the sum.\n",sum);


	return 0;
}
