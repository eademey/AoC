firewall = {}


def make_firewall(filepath):
    with open(filepath, 'r') as file:
        for line in file:
            splitted = line.split(':')
            firewall[int(splitted[0])] = int(splitted[1])
    return firewall


def solve(filepath, delay):
    make_firewall(filepath)
    package_position = -1
    severity = 0
    max_val = max(firewall, key=int)
    while package_position <= max_val:
        package_position += 1
        if package_position in firewall.keys() and (package_position + delay) % ((firewall[package_position]-1) *2) == 0:
            severity += firewall[package_position] * package_position +1
    return severity



print(solve("day13_input.txt",0))
offset = 0
while solve("day13_input.txt", offset) != 0:
    offset += 1
print(offset)
