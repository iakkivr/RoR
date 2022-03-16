vowels = {}

('a'..'z').to_a.each_with_index do |char, i|
  vowels[char] = i + 1 if char =~ /[aeiouy]/
end

temp = [1,2,3,4]
