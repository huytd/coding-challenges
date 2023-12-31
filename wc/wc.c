#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

int countFileSize(char* fileName) {
  struct stat st;
  if (stat(fileName, &st) == -1) {
    printf("Cannot read file size");
    return -1;
  }
  return st.st_size;
}

int main(int argc, char **argv) {
  char* opt = argv[1];
  char* fileName = argv[2];

  FILE* file = fopen(fileName, "r");
  if (file == NULL) {
    printf("Cannot open file %s", fileName);
    return -1;
  }

  if (strcmp(opt, "-c") == 0) {
      int fileSize = countFileSize(fileName);
      printf("%d %s", fileSize, fileName);
      return 0;
  }

  printf("Unknown option %s", opt);

  fclose(file);
  return 0;
}
