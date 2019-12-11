#include <stdio.h>
#include <glob.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


int globerr(const char *path, int _errno) {
  fprintf(stderr, "%s: %s\n", path, strerror(_errno));
  return 0;
}

int main(int argc, char *argv[]) {
  int i, n;
  int res;
  int cmdlen;
  glob_t globbuf;

  srand(time(NULL));

  res = glob("/proc/[0-9]*/cmdline", 0, globerr, &globbuf);
  if (res != 0) {
    fprintf(stderr, "glob() error\n");
    return EXIT_FAILURE;
  }

  cmdlen = strlen(argv[0]);

  for(i=0; i < globbuf.gl_pathc; i++) {
    FILE *fp;
    fp = fopen(globbuf.gl_pathv[i], "r");
    if (fp == NULL)
      continue;

    char buf[1024];
    memset(buf, 0, sizeof(buf));
    fgets(buf, sizeof(buf), fp);
    fclose(fp);

    len = strlen(buf)
    if (len > cmdlen || len == 0)
      continue;

    printf("%d %s\n", i, buf); // add these to an array
  }

  for (i=0; i<10; i++) {
    // spawn bogus processes to make resulting PIDs non-sequential
    int n;
    int x = rand() % 1000;
    for (n=0; n<x; n++) {
      if (fork() == 0)
        return EXIT_SUCCESS;
      continue;
    }

    if (fork() == 0) {
      // change argv[0] of child process
      memset(argv[0], 0, strlen(argv[0]));
      strncpy(argv[0], "wert", 5); // TODO pick random one from array

      for (;;)
	sleep(3);
      return EXIT_SUCCESS;
    }
  }

  globfree(&globbuf);

  return EXIT_SUCCESS;
}


