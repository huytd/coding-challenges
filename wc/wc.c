#include <ctype.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <wchar.h>

FILE* openFile(char* fileName) {
  FILE* file = fopen(fileName, "r");
  if (file == NULL) {
    printf("Cannot open file %s", fileName);
    exit(-1);
  }
  return file;
}

void countFileSize(char* fileName) {
  struct stat st;
  if (stat(fileName, &st) == -1) {
    printf("Cannot read file size");
    exit(-1);
  }
  int fileSize = st.st_size;
  printf("%d %s", fileSize, fileName);
}

void countLines(char* fileName) {
  FILE* file = openFile(fileName);
  int count = 0;
  char c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') count++;
  }
  fclose(file);
  printf("%d %s", count, fileName);
}

void countWords(char* fileName) {
  FILE* file = openFile(fileName);
  int count = 0;
  char c, last_c = ' ';
  while ((c = fgetc(file)) != EOF) {
    if (isspace(last_c) && !isspace(c)) count++;
    last_c = c;
  }
  fclose(file);
  printf("%d %s", count, fileName);
}

void countCharacters(char* fileName) {
  FILE* file = openFile(fileName);
  int count = 0;
  while ((fgetwc(file)) != EOF) {
    count++;
  }
  fclose(file);
  printf("%d %s", count, fileName);
}

int main(int argc, char **argv) {
  (void)setlocale(LC_ALL,"");

  if (argc < 3) {
    printf("Not enough arguments");
    return -1;
  }

  char opt = argv[1][1];
  char* fileName = argv[2];

  switch (opt) {
    case 'c':
      countFileSize(fileName);
      break;
    case 'l':
      countLines(fileName);
      break;
    case 'w':
      countWords(fileName);
      break;
    case 'm':
      countCharacters(fileName);
      break;
    default:
      printf("Unknown option -%c", opt);
  }

  return 0;
}
