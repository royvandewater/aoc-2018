#!/usr/bin/env python3

import fileinput
import itertools

class Fabric(object):
    def __init__(self):
        super(Fabric, self).__init__()
        self.sheet = dict()
        self.doubles = set()

    def add_claim(self, column, row, width, height):
        for x, y in itertools.product(range(width), range(height)):
            self.add_claim_square(x + column, y + row)

    def add_claim_square(self, x, y):
        if x not in self.sheet:
            self.sheet[x] = dict()

        if y in self.sheet[x]:
            self.doubles.add((x, y))
            self.sheet[x][y] += 1
        else:
            self.sheet[x][y] = 1

def parse_line(line):
    _, _, value = line.strip().partition('@ ')
    coordinates, _, dimensions = value.partition(': ')
    column, _, row = coordinates.partition(',')
    width, _, height = dimensions.partition('x')
    return int(column), int(row), int(width), int(height)

def main():
    fabric = Fabric()

    with fileinput.input() as input:
        for line in input:
            column, row, width, height = parse_line(line)
            fabric.add_claim(column, row, width, height)

    count = len(fabric.doubles)
    print(f'doubles: {count}')

if __name__ == "__main__":
    main()
