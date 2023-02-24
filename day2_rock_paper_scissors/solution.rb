shape_name = {
  A: :rock,
  B: :paper,
  C: :scissors,
  X: :rock,
  Y: :paper,
  Z: :scissors,
}

shape_points = {
  rock: 1,
  paper: 2,
  scissors: 3,
}

@shape_winner = {
  rock: :paper,
  paper: :scissors,
  scissors: :rock,
}

def round_points (shape_one, shape_two)
  if @shape_winner[shape_one] == shape_two
    [0, 6]
  elsif shape_one == shape_two
    [3, 3]
  else
    [6, 0]
  end
end

def needed_shape (char, oponent_shape)
  case char
  when :X
    @shape_winner.key(oponent_shape)
  when :Y
    oponent_shape
  when :Z
    @shape_winner[oponent_shape]
  end
end

sum_points = 0
File.foreach("input.txt") do |line|
  round = line.split " "
  oponent_shape = shape_name[round[0].to_sym]
  my_shape = shape_name[round[1].to_sym]
  match_points = round_points(my_shape, oponent_shape)
  sum_points += match_points[0] + shape_points[my_shape]
end

pp "The total is #{sum_points}"

# Part Two

sum_points = 0
File.foreach("input.txt") do |line|
  round = line.split " "
  oponent_shape = shape_name[round[0].to_sym]
  my_shape = needed_shape(round[1].to_sym, oponent_shape)
  match_points = round_points(my_shape, oponent_shape)
  sum_points += match_points[0] + shape_points[my_shape]
end

pp "The new total is #{sum_points}"