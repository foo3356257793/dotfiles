#!/usr/bin/python3

import fileinput
import re

def proc_str(s):

    indent = re.match(r"\s*", s).group()
    entities = s.split()

    out = []

    for e in entities:
        e = e.rstrip(";");
        out.append(f"{indent}std::cout << \"{e} = \" << {e} << std::endl;")

    return "\n".join(out)

if __name__ == "__main__":

    for _ in fileinput.input():
        print(proc_str(_))

