puts "Введи коэффициенты a,b и c через пробел"
coefficients = gets.chomp.split(" ").map{|el| el.to_i}
discriminant = coefficients[1]**2 - 4*coefficients[0] * coefficients[2]
if discriminant < 0
  puts  "Решение отсутсвует, корней нет"
elsif discriminant == 0
  result1 = -coefficients[1]/(2 * coefficients[0])
  puts "D = 0, корень1 = #{result1}"
else
  result1 = (-coefficients[1] + Math.sqrt(discriminant))/(2*coefficients[0])
  result2 = (-coefficients[1] - Math.sqrt(discriminant))/(2*coefficients[0])
  puts "D = #{discriminant}, корень1 = #{result1.round(2)}, корень2 = #{result2.round(2)}"
end
