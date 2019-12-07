def filter_input(file):
    result = ""
    garbage = False
    while True:
        c = file.read(1)
        if not c:
            break
        if c == "!":
            file.read(1)
        if c == "<" and not garbage:
            garbage = True
        if c == ">" and garbage:
            garbage = False
        if (c == "}" or c == "{") and not garbage:
            result += c

    return count_score(result)


def count_score(input):  # can be done inside filter_input, will be more efficient
    sum = 0
    parent_score = 0
    for c in input:
        if c == "{":
            parent_score += 1
            sum += parent_score
        if c == "}":
            parent_score -= 1
    return sum


def solve_1(filepath):
    with open(filepath, 'r') as file:
        return filter_input(file)


def count_garbage(file):
    garbage = 0
    is_garbage = False
    while True:
        c = file.read(1)
        if not c:
            break
        if c == "!":
            file.read(1)
        elif c == "<" and not is_garbage:
            is_garbage = True
        elif c == ">" and is_garbage:
            is_garbage = False
        elif is_garbage:
            garbage += 1
    return garbage


def solve_2(filepath):
    with open(filepath, 'r') as file:
        return count_garbage(file)


print(solve_1("day9_input.txt"))
print(solve_2("day9_input.txt"))
