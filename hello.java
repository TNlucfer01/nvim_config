import java.io.*;

public class hello

{
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
