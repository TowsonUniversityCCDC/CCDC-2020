/* chsh-all.c -- change all users shells to /bin/bash */

#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#define TMPFILE "/tmp/.newpasswd"


int main(int argc, char *argv[]) {
  FILE *newpasswd;
  struct passwd *pwd;


  newpasswd = fopen(TMPFILE, "w");
  if (newpasswd == NULL)
    return EXIT_FAILURE;

  while((pwd = getpwent()) != NULL) {
    pwd->pw_shell = "/bin/bash";
    putpwent(pwd, newpasswd);
  }

  fclose(newpasswd);

  if (rename(TMPFILE, "/etc/passwd") != 0) {
    unlink(TMPFILE);
    return EXIT_FAILURE;
  }

  chown("/etc/passwd", 0, 0);
  chmod("/etc/passwd", S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

  return EXIT_SUCCESS;
}
