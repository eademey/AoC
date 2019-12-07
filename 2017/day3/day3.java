/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adventofcode;

import java.util.ArrayList;

/**
 *
 * @author Edward
 */
public class day3 {
    public day3(){}
    
    /*
    * Gives the amount of width required for the input
    */
    public int calculateMemoryWidth(int input){
        int sqrt = (int) Math.ceil(Math.sqrt(input));  
        if(sqrt%2 == 0) return sqrt + 1;
        else return sqrt;
    }
    
    public int calculateManhattanDistance(int input){
        int width = calculateMemoryWidth(input);
        int[] q = new int[]{(int)Math.floor(width/2),(int) Math.floor(width/2)};  //q = square 1, always located in the middle
        int[] p = new int[]{width-1, 0}; //p will always lay on the edge of the square, so p1 or p2 will always be 0 or width-1
        boolean found = false;
        int current_number = (int)Math.pow(width, 2);
        for(int rot = 0; rot < 4; rot++){ //we rotate the square as the precise location of the input doesnt matter, only its location compared to the center
            for(int i = 0; i < width -1; i++){
                if(current_number == input){
                    p[1] = width -1 -i;
                    found = true;
                    break;
                }else{
                    current_number--;
                }
            }
            if(found){
                break;
            }
        }
        return ((int)Math.abs(p[0]-q[0])) + ((int)Math.abs(p[1]-q[1]));
    }
   
    public int part2(int input){   //brute force
        ArrayList<ArrayList<Integer>> list = new ArrayList<>();
        String direction = "right";
        int[] coordinates = new int[]{0,0};
        ArrayList<Integer> templist = new ArrayList<>();
        templist.add(1);
        list.add(templist);
        while(true){
            switch(direction){
                case "right":
                    if(coordinates[1] == list.get(coordinates[0]).size()-1){    //on the edge of the memory
                        expand(list);
                        coordinates[0]++; coordinates[1]++;
                    }
                    coordinates[1]++;
                    list.get(coordinates[0]).set(coordinates[1], calculateValue(list, coordinates));
                    if(list.get(coordinates[0]).get(coordinates[1]) > input){
                        return list.get(coordinates[0]).get(coordinates[1]);
                    }
                    if(list.get(coordinates[0]-1).get(coordinates[1]) == 0){
                        direction = "up";
                    }
                    break;
                case "left":
                    if(coordinates[1] == 0){    //on the edge of the memory
                        expand(list);
                        coordinates[0]++; coordinates[1]++;
                    }
                    coordinates[1]--;
                    list.get(coordinates[0]).set(coordinates[1], calculateValue(list, coordinates));
                    if(list.get(coordinates[0]).get(coordinates[1]) > input){
                        return list.get(coordinates[0]).get(coordinates[1]);
                    }                    
                    if(list.get(coordinates[0]+1).get(coordinates[1]) == 0){
                        direction = "down";
                    }
                    break;
                case "up":
                    if(coordinates[0] == 0){    //on the edge of the memory
                        expand(list);
                        coordinates[0]++; coordinates[1]++;
                    }
                    coordinates[0]--;
                    list.get(coordinates[0]).set(coordinates[1], calculateValue(list, coordinates));
                    if(list.get(coordinates[0]).get(coordinates[1]) > input){
                        return list.get(coordinates[0]).get(coordinates[1]);
                    }                    
                    if(list.get(coordinates[0]).get(coordinates[1]-1) == 0){
                        direction = "left";
                    }
                    break;
                case "down":
                    if(coordinates[0] == list.size()-1){    //on the edge of the memory
                        expand(list);
                        coordinates[0]++; coordinates[1]++;
                    }
                    coordinates[0]++;
                    list.get(coordinates[0]).set(coordinates[1], calculateValue(list, coordinates));
                    if(list.get(coordinates[0]).get(coordinates[1]) > input){
                        return list.get(coordinates[0]).get(coordinates[1]);
                    }
                    
                    if(list.get(coordinates[0]).get(coordinates[1]+1) == 0){
                        direction = "right";
                    }
                    break;
            }
        }
    }
    
    private int calculateValue(ArrayList<ArrayList<Integer>> list, int[]coordinates){
        int sum = 0;
        for(int i = -1; i<2; i++){
            for(int j = -1; j<2; j++){
                if(!(i == 0 && j == 0) && coordinates[0] + i >= 0 && coordinates[1] + j >= 0 && list.size() > coordinates[0] + i && list.get(coordinates[0] + i).size()>coordinates[1] + j){
                    sum+= list.get(coordinates[0] + i).get(coordinates[1] + j);
                }
            }
        }
        return sum;
    }
    
    private void expand(ArrayList<ArrayList<Integer>> lists){   //expand the memory by 1 on each side
        for(ArrayList<Integer> list : lists){
            list.add(0, 0);     //add 2 empty elements in the memory
            list.add(0);
        }
        ArrayList<Integer> templist = new ArrayList<>();
        ArrayList<Integer> templist2 = new ArrayList<>();
        for(int i: lists.get(0)){
            templist.add(0);
            templist2.add(0);
        }
        lists.add(0, templist);
        lists.add(templist2);
        
    }
}

