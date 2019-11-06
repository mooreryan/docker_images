#include <stdio.h>
#include <math.h>

int main(int argc, char **argv)
{
  int i;
  int result;

  for(i = 0; i < 65535; i++) {
    result = sin(i);
  }

  return 0;
}
