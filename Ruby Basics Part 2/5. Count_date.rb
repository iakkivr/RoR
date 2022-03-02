puts "Введи день, месяц и год через пробел в формате дд мм гггг."
day,month,year = gets.chomp.split(" ").map(&:to_i)
day_in_month = [0,31,28,31,30,31,30,31,31,30,31,30,31]

if month > 12
  puts "Слишком большое значение месяца, расчет будет произведен для декабря."
  month = 12
end

if day > day_in_month[month.to_i]
  puts "Слишком большое значение дней, будет посчитано максимальное количество дней в месяце"
  day = day = day_in_month[month]
end

leap_year = ((year % 400).zero? || (year % 100).positive? && (year % 4).zero?) && month > 2 ? 1 : 0
result = day_in_month[0..month - 1].inject(:+) + day + leap_year
puts result
