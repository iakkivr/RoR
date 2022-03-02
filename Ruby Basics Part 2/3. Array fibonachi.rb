result_array = [0,1]
loop do
  next_value = result_array[-2] + result_array[-1]
  break if next_value > 100
  result_array.push next_value
end