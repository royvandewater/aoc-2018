#!/usr/bin/env python

print("hello world!")

def main():
    total = 0

    with open("input") as f:
        for line in f.readlines():
            total += int(line)
    
    print("total: ", total)

if __name__ == "__main__":
    main()
