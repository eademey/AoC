/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adventofcode;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Edward
 */
public class day7 {

    private Set<String> children;
    private HashMap<String, Set<String>> parents;
    private HashMap<String, Integer> values;
    private HashMap<String, Integer> total_values;
    private int corrected_weight;

    public day7(String input_file_path) {
        total_values = new HashMap<>();

        children = new HashSet();
        parents = new HashMap<>();
        values = new HashMap<>();
        try {
            Files.lines(Paths.get(input_file_path)).forEach((line) -> {
                String[] output = line.split("->");
                Set<String> current_children = new HashSet();
                if (output.length > 1) {
                    for (String str : output[1].split(",")) {
                        current_children.add(str.trim());
                    }
                    children.addAll(current_children);
                }
                String node = output[0].split(" ")[0];
                parents.put(node, current_children);
                values.put(node, Integer.parseInt(output[0].split(" ")[1].trim().replaceAll("\\p{P}", "")));
            });
        } catch (IOException ex) {
            Logger.getLogger(day7.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int solvePart2() {
        String root = findRoot();
        calculateValue(root);
        correctValue(root, true);
        return corrected_weight;
    }

    public String findRoot() {       //solution for part 1
        Set<String> nodes = new HashSet(parents.keySet());
        nodes.removeAll(children);
        for (String str : nodes) {
            return str;
        }
        return "";
    }

    public int calculateValue(String node) {
        if (!parents.get(node).isEmpty()) {
            String[] node_children = parents.get(node).toArray(new String[parents.get(node).size()]);
            int sum = 0;
            for (String node_child : node_children) {
                sum += calculateValue(node_child);
            }
            total_values.put(node, values.get(node) + sum);
            return values.get(node) + sum;
        } else {
            total_values.put(node, values.get(node));
            return values.get(node);
        }
    }

    private void correctValue(String node, boolean lower) {
        String[] node_children = (String[]) parents.get(node).toArray(new String[parents.get(node).size()]);
        if (node_children.length > 2) {
            if (total_values.get(node_children[0]).intValue() != total_values.get(node_children[1]).intValue()) {       //there's a mistake in these 2
                if (total_values.get(node_children[0]).intValue() != total_values.get(node_children[2]).intValue()) {   //[0] is the wrong one
                    correctValue(node_children[0], lower);
                } else {                      //[1] is the wrong one
                    correctValue(node_children[1], lower);
                }
            } else {
                boolean mistake_found = false;
                for (int i = 2; i < node_children.length; i++) {
                    if (total_values.get(node_children[i]).intValue() != total_values.get(node_children[0]).intValue()) {
                        mistake_found = true;
                        correctValue(node_children[i], lower);
                    }
                }
                if (!mistake_found) {       //mistake in this node
                    String sibling = findSibling(node);
                    System.out.println("Wrong node: " + node + " its value: " + total_values.get(node));
                    
                    corrected_weight = this.values.get(node)-(total_values.get(node) - total_values.get(sibling));
                }
            }
        } else if (node_children.length == 2) {
            if (total_values.get(node_children[0]).intValue() == (total_values.get(node).intValue() - this.values.get(node).intValue()) / 2) { //first one wrong
                correctValue(node_children[0], lower);
            } else if (total_values.get(node_children[1]).intValue() == (total_values.get(node).intValue() - this.values.get(node).intValue()) / 2) {
                correctValue(node_children[1], lower);
            } else {    //node itself wrong
                String sibling = findSibling(node);
                corrected_weight = this.values.get(node)-(total_values.get(node) - total_values.get(sibling));
            }
        } else {      //no children, mistake here
            String sibling = findSibling(node);
            corrected_weight =  this.values.get(node)-(total_values.get(node) - total_values.get(sibling));;
        }
    }

    private String findSibling(String node) {
        for (Set<String> children : parents.values()) {
            if (children.contains(node)) {
                String[] siblings = (String[]) children.toArray(new String[children.size()]);
                for(String str:siblings){
                    if(!str.equals(node)){
                        return str;
                    }
                }
            }
        }
        return "";
    }
}
