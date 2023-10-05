import os

text = ""
base_dir = os.getcwd()


def print_files_and_directories(prev_dir="", current_dir="", depth=0):
    global text

    if depth == 2:
        return

    depth += 1

    for item in sorted(os.listdir(current_dir)):
        new_dir = os.path.join(current_dir, item)

        if item.strip().startswith("."):
            continue

        if os.path.isfile(new_dir):
            temp = current_dir.replace(base_dir, "")
            a = f"{'  ' * depth}- [📄 {item}]({temp}/{item.replace(" ", "%20")})\n"
            print(a)
            text += a
        elif os.path.isdir(new_dir):
            temp = current_dir.replace(base_dir, "")
            b = f"{'  ' * depth}- [📂 {item}]({temp}/{item.replace(" ", "%20")})\n"
            print(b)
            text += b
            print_files_and_directories(current_dir, new_dir, depth)


if __name__ == "__main__":
    print_files_and_directories("", base_dir, 0)

    with open("readme.md", "r", encoding="utf-8") as f:
        content = f.read()

    start_index = content.find("## Folder Structure")
    end_index = content.rfind("### Helpful resources:")

    if start_index != -1:
        text = "## Folder Structure\n" + text + "\n\n"
        content = content[:start_index] + text + content[end_index:]

        with open("readme.md", "w", encoding="utf-8") as f:
            f.write(content)
