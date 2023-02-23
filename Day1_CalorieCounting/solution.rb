sum = 0
max = 0
values = []

File.foreach("input.txt") do |line|
  if line != "\r\n"
    sum += line.to_i
  else
    values.push sum
    max = sum > max ? sum : max
    sum = 0
  end
end

pp "The Elf with the most Calories has #{max}"

sorted_values = values.sort.reverse
p "The three elves that carry the most calories: #{sorted_values[0]}, #{sorted_values[1]}, #{sorted_values[2]}"
p "and the total is #{sorted_values[0] + sorted_values[1] + sorted_values[2]}"