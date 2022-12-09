import sys
def main():
    inp = [line.strip() for line in sys.stdin]

    dirs = []

    root = Directory("/")
    working_directory = root
    dirs.append(root)

    for line in inp:
        if "$ ls" in line:
            continue
        
        if "$ cd" in line:
            _, _, dir = line.split()
            if ".." in dir:
                working_directory = working_directory.parent
            elif "/" in dir:
                working_directory = root
            else:
                working_directory = working_directory.children[dir]
            continue
        
        first, second = line.split()
        if "dir" in first:
            name = second
            add = Directory(second, working_directory)
            working_directory.extend(second, add)
            dirs.append(add)
        else:
            size, name = int(first), second
            working_directory.extend(name, File(name, size))
        continue
    sizes = [dir.size for dir in dirs]

    step_one = sum(filter(lambda x : x < 100000, sizes))
    largest = max(sizes)
    step_two = min(filter(lambda x: (70000000 - largest + x) > 30000000,  sizes))

    return (step_one, step_two)


class Directory:
    def __init__(self, name:str, parent: "Directory | File | None"  =None):
        self.name = name
        if parent is not None:
            self.parent = parent
        else:
            self.parent = self
        self.children: dict[str, Directory |File] = {}
    
    @property
    def size(self):
        return sum([x.size for x in self.children.values()])
    
    def extend(self, name:str, value:"Directory |File"):
        self.children[name] = value

    def __repr__(self) -> str:
        return self.name 


class File:
    def __init__(self,name: str, size:int):
        self.size = size
        self.name = name
        self.children = {}
        self.parent = Directory("/")
    
    def extend(self, name:str, value:"Directory |File"):
        pass

    def __repr__(self) -> str:
        return str(self.size) + ", " + self.name
    
    def __str__(self) -> str:
        return str(self.size) + ", " + self.name

if __name__ == "__main__":
    print(main())
    