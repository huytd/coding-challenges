import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

class Cat {
  static void printFile(String fileName) throws IOException {
    BufferedReader reader = new BufferedReader(new FileReader(fileName));
    int c;
    while ((c = reader.read()) != -1) {
      System.out.print((char)c);
    }
    reader.close();
  }

  static void printStdin() throws IOException {
    Scanner scanner = new Scanner(new InputStreamReader(System.in, "UTF-8"));
    System.out.print(scanner.next());
    while (scanner.hasNext()) {
      System.out.print(" " + scanner.next());
    }
    scanner.close();
  }

  public static void main(String[] args) {
    if (args.length <= 0) {
      System.out.println("Not enough arguments");
      System.exit(-1);
    }

    String fileName = args[0];

    try {
      if (fileName.equals("-")) {
        printStdin();
      } else {
        printFile(fileName);
      }
    } catch (Exception e) {
      System.out.println("Cannot read input");
    }
  }
}
