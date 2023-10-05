import os

text = ""

def print_files_and_directories(current_dir, depth = 1):
    global text

    if depth == 3:
        return
    # print(depth)
    depth += 1
    
    for item in sorted(os.listdir(current_dir)):
        new_dir = os.path.join(current_dir, item)
        
        if item.strip().startswith("."):
            continue
        
        if os.path.isfile(new_dir):
            # print(f"{'  ' * depth}📄 {item}")
            text += f"{'  ' * depth}📄 {item}\n"
        elif os.path.isdir(new_dir):
            # print(f"{'  ' * depth}📂 {item}")
            text += f"{'  ' * depth}📂 {item}\n"
            print_files_and_directories(new_dir, depth)
                     

if __name__ == "__main__":
    print_files_and_directories(os.getcwd())

    with open("README.md", "r", encoding="utf-8") as f:
        content = f.read()
        
    start_index = content.find("```text")
    end_index = content.rfind("```")
    
    print(start_index, end_index)
    
    if start_index != -1:
        text = "```text\n" + text
        content = content[:start_index] + text + content[end_index:]
        
        with open("README.md", "w", encoding="utf-8") as f:
            f.write(content)
    
    