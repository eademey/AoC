/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adventofcode;

import java.io.Console;
import java.util.Scanner;

/**
 *
 * @author Edward
 */
public class AdventOfCode {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        while (true) {
            System.out.println("Enter the puzzle input: ");
            Scanner scanner = new Scanner(System.in);
            int input = Integer.parseInt(scanner.nextLine());
            if(input == 0){
                System.exit(input);
            }
            day3 d = new day3();
            System.out.println(d.calculateManhattanDistance(input));
        }
    }
}
