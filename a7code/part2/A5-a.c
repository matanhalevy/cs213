#include <stlib.h>
#include <stdio.h>

int array[10];
int* ptr = array;

void foo(int a, int index){
	a = a + ptr[index];
	ptr[index] = a;
}

int main(){
	int a0 = 1;
	int a1 = 2;
	int a2 = 3;
	int a3 = 4;

	foo(a2, a3);
	foo(a0, a1);

	for (int i=0; i<10; i++){
		printf("%d\n", array[i]);
	}
}