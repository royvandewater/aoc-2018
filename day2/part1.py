#!/usr/bin/env python3

import fileinput

def contains_doubles(line):
    for char in set(line):
        if line.count(char) == 2:
            return True
    return False

def contains_tripples(line):
    for char in set(line):
        if line.count(char) == 3:
            return True
    return False

def main():
    doubles = 0
    tripples = 0

    with fileinput.input() as input:
        for line in input:
            if contains_doubles(line):
                doubles += 1
            if contains_tripples(line):
                tripples += 1

    checksum = doubles * tripples

    print(f'doubles: {doubles}, tripples: {tripples}, checksum: {checksum}')

if __name__ == "__main__":
    main()
