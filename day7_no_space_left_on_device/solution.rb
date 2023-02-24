class Node
  attr_reader :name, :parent, :children, :type

  def initialize(name, parent = nil, size = nil)
    @parent = parent
    @name = name
    @children = []
    @size = size
    @type = size == nil ? :dir : :file
  end

  def insert(node)
    @children.push(node)
    self
  end

  def size
    @children.length > 0 ? @children.map(&:size).sum : @size
  end

  def child_exist? name
    @children.any? { |child| child.name == name }
  end

  def find_child name
    @children.find { |child| child.name == name }
  end
end

def update_tree(tree, line)
  case line
  when  "cd .."
    tree.parent
  when /^cd\s/
    tree.find_child(line.split(" ")[1])
  when /^dir\s/
    dir_name = line.split(" ")[1]
    tree.child_exist?(dir_name) ? tree : tree.insert(Node.new(dir_name, tree))
  else
    file_name = line.split(" ")[1]
    file_size = line.split(" ")[0]
    tree.child_exist?(file_name) ? tree : tree.insert(Node.new(file_name, tree, file_size.to_i))
  end
end

def generate_tree
  original_tree = Node.new("/")
  tree = original_tree
  File.foreach("input.txt").with_index do |line, index|
    cleaned_line = line.strip
    cleaned_line = line.start_with?("$ ") ? cleaned_line[2..] : cleaned_line 
    next if index == 0 || cleaned_line == "ls"
    tree = update_tree(tree, cleaned_line)
  end
  original_tree
end


def find_sizes(tree, sizes)
  if (tree.type == :dir && tree.children.length > 0)
    tree.children.each { |child| find_sizes(child, sizes) }
    size = tree.size
    if (size <= 100000)
      sizes.push(size)
    end
  end
end

sizes = []
generated_tree = generate_tree
find_sizes(generated_tree, sizes)
pp "The sum of the total sizes of the directories with a maximum total size of 100000 is #{sizes.sum}"

total_space = 70000000
used_space = generated_tree.size
space_required = 30000000
available_space = total_space - used_space
@free_space_required = space_required - available_space

@best_fit = generated_tree
def find_best_fit_directory(tree)
  if (tree.type == :dir && tree.children.length > 0)
    tree.children.each { |child| find_best_fit_directory(child) }
    size = tree.size
    if (size < @best_fit.size && size >= @free_space_required)
      @best_fit = tree
    end
  end
end

find_best_fit_directory(generated_tree)
pp "The directory called '#{@best_fit.name}' is the smallest directory that, if deleted, would free up enough space in the filesystem to run the upgrade, with a size of #{@best_fit.size}"

