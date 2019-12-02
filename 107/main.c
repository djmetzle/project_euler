#include <stdio.h>
#include <stdlib.h>

typedef struct {
	int weight;
	int i,j;
} Edge;

Edge edges[800];
int N_edges=0;

int V[40][40]={0};

void fill_graph_from_file() {
	FILE *fp = fopen("network.txt","r");
	int i,j;
	int n=0;
	char buffer[1024];
	char char_in[40][1024];
	for (i=0;i<40;i++) {
		fscanf(fp,"%s\n",&buffer);
		for (j=0;j<1024;j++) char_in[n][j] = buffer[j];
		n++;
	}	
	for (n=0;n<40;n++) {
		char n_buffer[20];
		i = 0;
		int number=0;
		int reverse=0;
		do {
			reverse++;
			if ((char_in[n][i] == ',') || (char_in[n][i] == '\0')) {	
				for (j=0;j<reverse-1;j++) n_buffer[j] = char_in[n][i+j-reverse+1]; 
				n_buffer[reverse-1] = '\0';
				if (n_buffer[0] == '-') V[n][number++] = 0;
				else V[n][number++] = atoi(n_buffer);
				reverse = 0;
			}
		} while (char_in[n][i++] != '\0');
	}
	return;
}

void print_out_network() { 
	int i,j;
	for (i=0;i<40;i++) { for (j=0;j<40;j++) printf("%03d ",V[i][j]);
		printf("\n"); }
	return;
}

void print_out_connections() { 
	int i,j;
	for (i=0;i<40;i++) { for (j=0;j<40;j++) {
		if (V[i][j]) printf("X ");
		else printf("O "); }
		printf("\n"); }
	return;
}

int sum_network_weight() {
	int sum = 0;
	int i,j;
	for (i=0;i<40;i++) for (j=0;j<i;j++) sum += V[j][i];
	return sum;
}

int fill_edges() {
	int N=0;	
	int i,j;
	for (i=0;i<40;i++)
		for (j=0;j<i;j++) {
			if (V[j][i] != 0) {
				edges[N].weight = V[j][i];
				edges[N].i = i;
				edges[N].j = j;
				N++;
			}
		}
	return N;
}

void sort_edges() {
	int i,n=0;
	int min=1000;
	int min_i;
	Edge temp;
	for (n=0;n<N_edges;n++) {
		min=1000;
		for (i=n;i<N_edges;i++) {
			if (edges[i].weight<min) {
				min = edges[i].weight;
				min_i = i;
			} 
		}
		temp = edges[n];
		edges[n] = edges[min_i];
		edges[min_i] = temp;
	}

	return;
}

int is_connected(int u, int v) {
	if(V[u][v]!=0) return 1;
	int i,j;
	for (i=0;i<40;i++) {
		if (V[i][u] != 0) {
			if(V[i][v]!=0) return 1;
			if(is_connected(i,v)) return 1;
		}

	}
	return 0;
}

void print_out_edges() {
	int n;
	for (n=0;n<N_edges;n++) printf("%d %d : %d\n",edges[n].i,edges[n].j,edges[n].weight );
}

void reverse_delete() {
	int n;
	for (n=N_edges;n>=0;n--) {
		Edge temp = edges[n];
		V[temp.i][temp.j]=V[temp.j][temp.i]=0;
		if (!is_connected(temp.i,temp.j)) 
			V[temp.i][temp.j]=V[temp.j][temp.i]=temp.weight;

	}
	return;
}

	int V_new[40][40]={0};
void prims_algo() {
	int verts[40]={1};
	inline int all_verts() { int i; for (i=0;i<40;i++) if (verts[i] == 0) return 0; return 1; }
		int min, min_i, min_n;
		int n,i;	
	int shortest_edge() {
		min = 1000;
		for (i=0;i<40;i++) 
			if (verts[i]) {
				for (n=0;n<40;n++) {
					if ((!verts[n]) && (V[i][n]<min) && (V[i][n]!=0)) {
						min = V[i][n];
						min_i = i;
						min_n = n;
					}
				}

			}
		printf("%d %d : %d\n",min_i,min_n,min);
		V_new[min_i][min_n] = V_new[min_n][min_i] = V[min_n][min_i];
		verts[min_n] = 1;	
//		for (i=0;i<40;i++) printf("%d ",verts[i]); printf("\n");
	}
	do {
		shortest_edge();	
	} while (!all_verts());
	int j;
	for (i=0;i<40;i++) for (j=0;j<40;j++) V[i][j] = V_new[i][j];
	return;
}

int main() {
	fill_graph_from_file();
	int total_weight = sum_network_weight();
//	print_out_network();
	printf("Total Network Weight: %d\n", total_weight);
	N_edges = fill_edges();
	printf("%d edges found.\n",N_edges);
	sort_edges();
//	print_out_edges();
//	reverse_delete();
	prims_algo();
	print_out_connections();
	int reduced_weight = sum_network_weight();
	printf("Reduced Network Weight: %d\n", reduced_weight);
	printf("Reduction: %d\n", total_weight - reduced_weight);
	return 0;
}
