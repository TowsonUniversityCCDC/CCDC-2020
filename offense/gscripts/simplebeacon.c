#include <stdio.h>
#include <unistd.h>

#if defined(__WIN32__) || defined(WIN32) || defined(_WIN32)
  #define WIN32_LEAN_AND_MEAN
  #include <winsock.h>
#else
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <arpa/inet.h>

typedef int SOCKET;
#define send(x,y,z,a) write(x,y,z)
#endif /* defined(__WIN32__) || defined(WIN32) || defined(_WIN32) */

int main() {
  SOCKET s;
  struct sockaddr_in c;

#if defined(__WIN32__) || defined(WIN32) || defined(_WIN32)
  WSADATA wsadata;
  WSAStartup(MAKEWORD(1,1), &wsadata);
#endif

  c.sin_family = AF_INET;
  c.sin_port = htons (443);
  c.sin_addr.s_addr = inet_addr ("10.150.100.190");

  s = socket (AF_INET, SOCK_STREAM, IPPROTO_IP);

  connect (s, (struct sockaddr *)&c, sizeof (c));

  char msg[] = "your team token here\n";
  send(s, msg, sizeof(msg), 0);
  close(s);

#if defined(__WIN32__) || defined(WIN32) || defined(_WIN32)
  WSACleanup();
#endif
}
