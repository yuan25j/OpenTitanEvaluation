#!/usr/bin/env python3
import ast
import sys
from collections import OrderedDict

def convert_file(input_path, output_path):
    # Read all nonblank lines
    with open(input_path, 'r') as f:
        lines = [ln.strip() for ln in f if ln.strip()]

    entries = []
    for ln in lines:
        # split off the trailing module name
        try:
            list_part, module = ln.rsplit(maxsplit=1)
        except ValueError:
            print(f"Skipping malformed line: {ln!r}", file=sys.stderr)
            continue

        # parse the Python literal for ['name', ['x','278']] 
        try:
            san = list_part.replace("\\", r"\\")               # escape every backslash
            name, size_info = ast.literal_eval(san)
        except Exception as e:
            print(f"Error parsing {list_part!r}: {e}", file=sys.stderr)
            continue

        entries.append((module, name, size_info))

    # Group by module in insertion order
    modules = OrderedDict()
    for module, name, size_info in entries:
        modules.setdefault(module, []).append((name, size_info))

    if not modules:
        print("No valid entries found.", file=sys.stderr)
        return

    # Take only the first module encountered
    first_module, signals = next(iter(modules.items()))

    # Build the dictionary
    store_dict = OrderedDict()
    for name, (x_or_num, width) in signals:
        if x_or_num == 'x':
            store_dict[name] = "init_symbol()"
        else:
            # assume numeric string, convert to int
            try:
                store_dict[name] = int(x_or_num)
            except ValueError:
                # fallback: keep as string literal
                store_dict[name] = x_or_num

    # Write out the Python file
    with open(output_path, 'w') as out:
        out.write("state.store = {\n")
        out.write(f"    '{first_module}': {{\n")
        for name, val in store_dict.items():
            # if init_symbol(), we want it unquoted; else show the integer
            if val == "init_symbol()":
                out.write(f"        '{name}': init_symbol(),\n")
            else:
                out.write(f"        '{name}': {val},\n")
        out.write("    }\n")
        out.write("}\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <input.txt> <output.py>", file=sys.stderr)
        sys.exit(1)
    convert_file(sys.argv[1], sys.argv[2])