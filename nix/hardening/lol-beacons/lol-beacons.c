#define _GNU_SOURCE

#include <stdio.h>
#include <dlfcn.h>
#include <ctype.h>
#include <unistd.h>
#include <string.h>
#include <stdbool.h>
#include <syslog.h>

#include <sys/types.h>


ssize_t write(int fd, const void *buf, size_t count) {
  int i;
  bool found;
  char *str = (char *)buf;
  ssize_t (*original_write)(int, const void *, size_t);

  *(void **)(&original_write) = dlsym(RTLD_NEXT, "write");

  /* abcdef00-1122-3344-5566-0123456789ab */
  for (i = 0, found = true; i < count; i++, *str++) {
    if (!isxdigit(*str) && *str != '-' && *str != '\n' && *str != '\r') {
      found = false;
      break;
    }

    if ((i == 8 || i == 13 || i == 18 || i == 23) && *str != '-') {
      found = false;
      break;
    }
  }

  if (found) {
    //char token[] = "our token here";
    //memcpy(str, token, sizeof(token));
    //memset(str, 'A', count);

    openlog("lol-beacons", LOG_CONS | LOG_PID | LOG_NDELAY, LOG_LOCAL1);
    syslog(LOG_NOTICE, "beacon pid: %d uid: %d gid: %d", getpid(), getuid(), getgid());
    closelog();
  } else {
    str -= i;
  }

  return ((*original_write)(fd, str, count));
}

