def is_binary_match(nr1, nr2):
    bin1 = format(nr1, 'b')
    bin2 = format(nr2, 'b')
    return bin1[-16:] == bin2[-16:]


def solve_1(input1, input2, amount):
    judge = 0
    while amount > 0:
        input1 = round((input1 * 16807) % 2147483647)
        input2 = round((input2 * 48271) % 2147483647)
        if is_binary_match(input1, input2):
            judge += 1
        amount -= 1
    return judge


def solve_2(input1, input2, amount):
    judge = 0
    while amount > 0:
        input1 = round((input1 * 16807) % 2147483647)
        while input1 % 4 != 0:
            input1 = round((input1 * 16807) % 2147483647)
        input2 = round((input2 * 48271) % 2147483647)
        while input2 % 8 != 0:
            input2 = round((input2 * 48271) % 2147483647)
        if is_binary_match(input1, input2):
            judge += 1
        amount -= 1
    return judge

print(solve_2(516, 190, 5000000))
