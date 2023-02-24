# Generates a matrix with the information about the input stacks
def build_matrix
  matrix = []
  File.foreach("input.txt") do |line|
      if line == "\r\n"
          break
      end
      matrix.push(line.gsub("\r\n", "").split(""))
  end
  matrix
end

# Generates a hash of the stacks and their numbers
def generate_stacks
  matrix = build_matrix
  matrix = matrix.transpose.map(&:reverse)
  lines = matrix.map { |array| array.join('').strip }
  lines = lines.select { |line| line =~ /\d/ }
  stacks = lines.map do |line|
    index = line.scan(/\d/).join('')
    crates = line.tr("0-9", "").split("")
    [index, crates]
  end
  stacks.to_h
end

def move_crates(stacks, quantity_to_move, from_stack, to_stack, behavior)
  stack = stacks[from_stack]
  half_index = stack.length - quantity_to_move
  crates_to_move = stack.slice(half_index, stack.length)
  stacks[from_stack] = stack.slice(0, half_index)
  stacks[to_stack] += behavior == "stack" ? crates_to_move.reverse : crates_to_move
end

def update_stacks(behavior)
  stacks = generate_stacks
  File.foreach("input.txt") do |line|
    next unless line.include? "move"
    values = line.split(" ")
    quantity_to_move = values[1].to_i
    from_stack = values[3]
    to_stack = values[5]
    move_crates(stacks, quantity_to_move, from_stack, to_stack, behavior)
  end
  stacks
end

def top_crates(behavior)
  top_crates = []
  stacks = update_stacks(behavior)
  stacks.each_value do |value|
    top_crates.push(value[value.length - 1])
  end
  top_crates.join("")
end

pp "Box on top of each stack with CrateMover 9000: #{top_crates("stack")}"
pp "Box on top of each stack with CrateMover 9001: #{top_crates("queue")}"