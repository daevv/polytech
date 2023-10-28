#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main(){
  int i;
  FILE* f = fopen("input.txt", "rt");
  if (fork()){
    sleep(2);
    char buf[5];
    fread(buf, 1, 5, f);
    puts(buf);
  }
  else{
    char buf[5];
    fread(buf, 1, 5, f);
    puts(buf);
  }
}