puts 'Введи 3 стороны треугольника через пробел'
triangle_sides = gets.chomp.split(' ').map(&:to_i).sort
result =  if (triangle_sides[0]**2 + triangle_sides[1]**2) == triangle_sides[2]**2
            'Прямоугольный'
          elsif triangle_sides[0] == triangle_sides[1] && triangle_sides[0] == triangle_sides[2]
            'Равносторонний'
          elsif triangle_sides[0] == triangle_sides[1] || triangle_sides[1] == triangle_sides[2]
            'Равнобедренный'
          else
            'Треугольник не является равносторонним, равнобедренным или прямоугольным'
          end
puts result
