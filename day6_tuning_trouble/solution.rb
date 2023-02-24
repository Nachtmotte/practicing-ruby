text = File.read("input.txt")

def index_start_marker(text, marker_size)
  marker = []
  start_of_packet = -1
  text.each_char.with_index(1) do |letter, index|
    marker = marker.push(letter)
    next unless marker.length == marker_size
    if marker.uniq.length == marker_size
      start_of_packet = index
      break
    else
      marker = marker.slice(1, marker.length)
    end
  end
  start_of_packet
end

pp "#{index_start_marker(text, 4)} characters had to be processed before the first packet start marker was detected."
pp "#{index_start_marker(text, 14)} characters had to be processed before the first message start marker was detected."