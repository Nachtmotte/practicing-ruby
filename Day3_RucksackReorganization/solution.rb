priorities = (("a".."z").to_a + ("A".."Z").to_a).map.with_index{|letter, index| [letter, index + 1] }.to_h

sum = 0
File.foreach("input.txt") do |line|
  first_half = line[0, line.size / 2].strip.split("")
  second_half = line[line.size / 2, line.size].strip.split("")
  priority = first_half.intersection(second_half)[0]
  sum += priorities[priority]
end

pp "The sum of the priorities is #{sum}"

# Part Two

sum = 0
group = []
File.foreach("input.txt") do |line|
  group.push(line.strip.split(""))
  if (group.length == 3)
    badge = group[0].intersection(group[1])
    badge = badge.intersection(group[2])[0]
    sum += priorities[badge]
    group = []
  end
end

pp "The sum of the priorities of those item types is #{sum}"