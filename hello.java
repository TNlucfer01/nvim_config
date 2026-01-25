import java.util.Deque;

public class hello {

  public static void main(String[] args) {

    System.out.println("hello world ");
    int a = 10;
    System.out.println("hello world " + a);
    for (int i = 0; i < 10; i++) {
      System.out.println(i);
    }
  }

  @Override
  public String toString() {
    return "hello []";
  }
}

class Solution {
  public int[] maxSlidingWindow(int[] nums, int k) {

    Deque<Integer> Window = new ArrayDeque<>();
    Integer Temp_max;
    int[] max_array = {};
    ///  so wat  i need to do id that i have to do a ceratain no of instruction for each k times
    ///  so what ar ethe ways i can

    // we need a loop
  }
}
