#!/usr/bin/env python3

import sys

print("hello world!")

def readinput():
    with open("input") as f:
        return f.readlines()

def main():
    total = 0
    frequencies = set()

    input = readinput()

    while True:
        for line in input:
            total += int(line)
            if total in frequencies:
                print(f'duplicate: {total}')
                sys.exit(0)
            frequencies.add(total)

if __name__ == "__main__":
    main()
