def solve(filename):
    input_file = open(filename, "r")
    lines = input_file.read().split("\n")
    registers = {}
    for line in lines:
        registers[line.split(" ")[0]] = 0
    highest_value = 0;
    for line in lines:
        if eval(str(registers[line.split(" ")[4]]) + line.split(" ")[5] + str(line.split(" ")[6])):
            if line.split(" ")[1] == "inc":
                registers[line.split(" ")[0]] += int(line.split(" ")[2])
            else:
                registers[line.split(" ")[0]] -= int(line.split(" ")[2])
            if registers[line.split(" ")[0]] > highest_value:
                highest_value = registers[line.split(" ")[0]]
    print(max(registers, key=registers.get) + " : " + str(registers[max(registers, key=registers.get)]))
    print("The highest value ever was: " + str(highest_value    ))
    input_file.close()


solve("day8_input.txt")
