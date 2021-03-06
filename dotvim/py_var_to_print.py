#!/usr/bin/python3

import fileinput
import re

def proc_str(s):

    indent = re.match(r"\s*", s).group()
    entities = s.split()

    return "\n".join([f"{indent}print(f\"{_} = {{{_}}}\")" for _ in entities])

if __name__ == "__main__":

    for _ in fileinput.input():
        print(proc_str(_))

