#include <iostream>

int main() {
  int x = 5;
  int y = 15;
  int* p1;
  int* p2;

  p1 = &x; // x=5 y=15 p1=addr x p2=unassigned
  p2 = &y; // x=5 y=15 p1=addr x p2=addr y

  *p1 = 6; // x=6 y=15 p1=addr x p2=addr y

  *p1 = *p2; // x=15 y=15 p1=addr x p2=addr y

  p2 = p1; // x=15 y=15 p1=addr x p2=addr x

  *p1 = *p2+10; // x=25 y=15 p1=addr x p2=addr x 

  return 0;
}
