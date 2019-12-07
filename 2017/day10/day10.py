def solve(inputs, amount, loops):
    elements = list(range(amount))
    skip_size = 0
    current = 0
    while loops > 0:
        for number in inputs:
            if (current + int(number)) > amount:
                sublist = elements[current:amount] + elements[0:(current + int(number)) % amount]
                sublist = sublist[::-1]
                elements[current:amount] = sublist[0:amount - current]
                elements[0:(current + int(number)) % amount] = sublist[amount - current:int(number)]
            else:
                elements[current:current + int(number)] = elements[current:current + int(number)][::-1]
            current = (current + int(number) + skip_size) % amount
            skip_size += 1
        loops -= 1
    return elements


def solve_1(pathname, amount):
    with open(pathname, 'r') as file:
        inputs = file.readline().split(',')
        elements = solve(inputs, amount, 1)
        return elements[0] * elements[1]


def solve_2(pathname, amount):
    with open(pathname, 'r') as file:
        c = file.read(1)
        inputs = []
        while c:
            inputs.append(ord(c))
            c = file.read(1)
        inputs.extend([17, 31, 73, 47, 23])
        elements = solve(inputs, amount, 64)
        hashed = ""
        for i in range(0, 16):
            result = elements[i*16]
            for j in range(1, 16):
                result = result ^ elements[i*16 + j]
                j += 1
            print(hex(result))
            hashed += (str(hex(result))).split('x')[1]  #does not write leading zero's, still wrong
            i += 1
        return hashed


# print(solve_1("day10_input.txt", 256))
print(solve_2("day10_input.txt", 256))
