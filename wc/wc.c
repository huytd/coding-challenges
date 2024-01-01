#include <ctype.h>
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <wchar.h>

typedef struct {
  int lines;
  int words;
  int chars;
  int bytes;
} count_t;

FILE* openFile(char* fileName) {
  FILE* file = fopen(fileName, "r");
  if (file == NULL) {
    printf("Cannot open file %s", fileName);
    exit(-1);
  }
  return file;
}

int countFileSize(char* fileName) {
  struct stat st;
  if (stat(fileName, &st) == -1) {
    printf("Cannot read file size");
    exit(-1);
  }
  int fileSize = st.st_size;
  return fileSize;
}

count_t count(char* fileName) {
  FILE* file = openFile(fileName);
  int wordCount = 0, lineCount = 0, charCount = 0;
  char c, last_c = ' ';

  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') lineCount++;
    if (isspace(last_c) && !isspace(c)) wordCount++;
    last_c = c;
  }

  fseek(file, 0, SEEK_SET);

  while ((fgetwc(file)) != EOF) {
    charCount++;
  }

  fclose(file);

  count_t result;
  result.lines = lineCount;
  result.words = wordCount;
  result.chars = charCount;
  result.bytes = countFileSize(fileName);

  return result;
}

int hasValidArguments(int argc, char **argv) {
  int hasTwoArgs = argc == 3 && argv[1][0] == '-';
  int hasOneArgs = argc == 2 && argv[1][0] != '-';
  return hasTwoArgs || hasOneArgs;
}

int main(int argc, char **argv) {
  (void)setlocale(LC_ALL,"");

  if (!hasValidArguments(argc, argv)) {
    printf("Not enough arguments");
    return -1;
  }

  char opt = '\0';
  char* fileName;

  if (argv[1][0] == '-') {
    opt = argv[1][1];
    fileName = argv[2];
  } else {
    fileName = argv[1];
  }

  switch (opt) {
    case 'c':
      printf("%d %s", count(fileName).bytes, fileName);
      break;
    case 'l':
      printf("%d %s", count(fileName).lines, fileName);
      break;
    case 'w':
      printf("%d %s", count(fileName).words, fileName);
      break;
    case 'm':
      printf("%d %s", count(fileName).chars, fileName);
      break;
    case '\0': {
      count_t result = count(fileName);
      printf("%d\t%d\t%d %s", result.lines, result.words, result.bytes, fileName);
      }
      break;
    default:
      printf("Unknown option -%c", opt);
  }

  return 0;
}
