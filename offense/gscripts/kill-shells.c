#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  sleep(60);
  system("killall -9 bash sh ksh dash ash csh tcsh zsh fish");
  return EXIT_SUCCESS;
}
