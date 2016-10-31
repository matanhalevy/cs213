#include <stdio.h>

int foo(int a, int b, int c) {

	int d;

	switch (a) {
	case 10:	d = b + c; 					
		break;
	case 12:	d = b - c; 					
		break;
	case 14:	d = (b > c) ? 1 : 0;			
		break;
	case 16:	d = (c > b) ? 1 : 0;			
		break;
	case 18:	d = (b == c) ? 1 : 0;		
		break;
	default: 	d = 0; 	   					
		break;
	}

	return d;
}


int main(int argc, char** argv) {
	int a = 0;
	int b = 0;
	int c = 0;
	int d = foo(a, b, c);
}