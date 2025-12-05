import os

def main(path=".", values = {}):
    if path == ".":
        path = os.getcwd()

    for file in os.listdir(path):
        full_path = os.path.join(path, file)
        
        if os.path.isdir(full_path):
           main(path+"\\"+file, values)

        else:
            values[file] = os.path.getsize(full_path)

    return values

def draw_values(values: dict):
    largest_len = max(len(k) for k in values)

    print(f"||{"-"*(largest_len+1)}|{"-"*(largest_len+1)}||")
    print(f"||{'Name':^{largest_len}} |{'Size (in bytes)':^{largest_len}} ||")
    print(f"||{"-"*(largest_len+1)}|{"-"*(largest_len+1)}||")
    
    for key, value in sorted(values.items(), key=lambda item: item[1], reverse=True):
        print(f"||{key:<{largest_len}} |{value:<{largest_len}} ||")
    
    print(f"||{"-"*(largest_len+1)}|{"-"*(largest_len+1)}||")

values = main()
draw_values(values)
