=begin
6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
(может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет
"стоп" в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end
puts "Введи название покупки, цену и количество"
list_of_purchases = {}
loop do
  print "Наименование:"
  name = gets.strip
  break if name == "стоп"
  print "Цена:"
  price = gets.strip
  print "Количество:"
  amount = gets.strip
  list_of_purchases[name] = {price: price, amount: amount}
end
total_summ = 0

  list_of_purchases.each do |key, value|
    puts "#{key}: #{value[:price]} шт #{value[:amount]} р - #{value[:price].to_i * value[:amount].to_f} р"
    total_summ += value[:price].to_i * value[:amount].to_f
  end

print "Итого: #{total_summ} р"

