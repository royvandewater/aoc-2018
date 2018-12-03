#!/usr/bin/env python3

import fileinput
import itertools

def similar_enough(a, b):
    diffs = 0
    for i in range(len(a)):
        if a[i] != b[i]:
            diffs += 1
        if diffs > 1:
            return False
    return True

def common_letters(a, b):
    common = []

    for i in range(len(a)):
        if a[i] == b[i]:
            common += a[i]

    return common


def main():
    doubles = 0
    tripples = 0

    with fileinput.input() as f:
        lines = [line.strip() for line in f]
        for a, b in itertools.combinations(lines, 2):
            if similar_enough(a, b):
                print("".join(common_letters(a,b)))

if __name__ == "__main__":
    main()
