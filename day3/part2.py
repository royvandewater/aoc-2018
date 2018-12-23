#!/usr/bin/env python3

import fileinput
import itertools

class Fabric(object):
    def __init__(self):
        super(Fabric, self).__init__()
        self.sheet = dict()
        self.doubles = set()
        self.good_ids = set()

    def add_claim(self, id, column, row, width, height):
        overlap = False

        for x, y in itertools.product(range(width), range(height)):
            square_overlap = self.add_claim_square(id, x + column, y + row)
            overlap = overlap or square_overlap

        if not overlap:
            self.good_ids.add(id)

    def add_claim_square(self, id, x, y):
        if id == ' ':
            raise Error(f'id is nil! {x},{y}')

        if x not in self.sheet:
            self.sheet[x] = dict()

        if y not in self.sheet[x]:
            self.sheet[x][y] = set()

        self.sheet[x][y].add(id)

        if len(self.sheet[x][y]) > 1:
            self.doubles.add((x, y))
            return True

        return False

    def reset_good_ids(self):
        self.good_ids = set()

def parse_line(line):
    leading, _, value = line.strip().partition('@ ')
    id = leading.strip().strip('#')
    coordinates, _, dimensions = value.partition(': ')
    column, _, row = coordinates.partition(',')
    width, _, height = dimensions.partition('x')
    return id, int(column), int(row), int(width), int(height)

def main():
    fabric = Fabric()

    with fileinput.input() as input:
        parsed_lines = [parse_line(line) for line in input]

        for id, column, row, width, height in parsed_lines:
            fabric.add_claim(id, column, row, width, height)

        fabric.reset_good_ids()

        for id, column, row, width, height in parsed_lines:
            fabric.add_claim(id, column, row, width, height)

    count = len(fabric.doubles)
    print(f'doubles: {fabric.doubles}')
    print(f'good_ids: {fabric.good_ids}')

if __name__ == "__main__":
    main()
