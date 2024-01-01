import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Cat {
  public static void main(String[] args) {
    if (args.length <= 0) {
      System.out.println("Not enough arguments");
      System.exit(-1);
    }

    String fileName = args[0];

    try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
      int c;
      while ((c = reader.read()) != -1) {
        System.out.print((char)c);
      }
    } catch (IOException e) {
      System.out.println("Cannot open file " + fileName);
    }
  }
}
