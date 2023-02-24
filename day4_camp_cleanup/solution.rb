def duplicated_sections? (array1, array2)
  (array1 - array2).length == 0 || (array2 - array1).length == 0
end

def build_array range
  values = range.split("-")
  (values[0]..values[1]).to_a
end

counter = 0
File.foreach("input.txt") do |line|
  assigned_sections = line.strip.split(",")
  first_elf_sections = build_array(assigned_sections[0])
  second_elf_sections = build_array(assigned_sections[1])
  if duplicated_sections?(first_elf_sections, second_elf_sections)
    counter += 1  
  end
end

pp "One range completely contains the other #{counter} times"

# Part Two

def overlapping_sections? (array1, array2)
  array1.intersection(array2).length > 0
end

counter = 0
File.foreach("input.txt") do |line|
  assigned_sections = line.strip.split(",")
  first_elf_sections = build_array(assigned_sections[0])
  second_elf_sections = build_array(assigned_sections[1])
  if overlapping_sections?(first_elf_sections, second_elf_sections)
    counter += 1  
  end
end

pp "Overlap in #{counter} pairs of assignments"