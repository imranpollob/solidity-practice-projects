import os

def print_files_and_directories(current_dir, depth = 1):
    if depth == 3:
        return
    print(depth)
    depth += 1
    
    # Iterate over items in the directory
    for item in os.listdir(current_dir):
        # Check if it's a file or directory
        new_dir = os.path.join(current_dir, item)
        
        if os.path.isfile(new_dir):
            print(f"{'  ' * depth}📄 {item}")
        elif not item.strip().startswith(".") and os.path.isdir(new_dir):
            print(f"{'  ' * depth}🗂 {item}")
            print_files_and_directories(new_dir, depth)
            

            

if __name__ == "__main__":
    print_files_and_directories(os.getcwd())
