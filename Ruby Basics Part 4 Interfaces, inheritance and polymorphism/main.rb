require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'train_cargo.rb'
require_relative 'train_pass.rb'
require_relative 'wagon.rb'
require_relative 'wagon_cargo.rb'
require_relative 'wagon_pass.rb'

puts 'Программа управления железной дорогой. Для получения списка команд введите: info'

def info
  puts "  create_station - создать станцию.
  create_train - создать поезд.
  create_route - создать маршрут.
  edit_route - редактировать маршрут.
  assign_route - назначить маршрут поезду.
  attach_wagon - прицепить вагон.
  unhook_wagon - отцепить вагон.
  next_station - отправить поезд на следующую станцию по маршруту.
  previous_station - отправить поезд на предыдущую станцию маршрута.
  list_trains_on_stations - получить список станций и поездов на них."
end

def create_station
  puts "Введи наименование станции"
    $list_stations << Station.new(name_station = gets.chomp)
    "Станция #{name_station} успешно создана!"
end

def create_train
  puts "Введи номер поезда (произвольная строка)"
  number_train = gets.chomp
  puts "Введи тип поезда pass - пассажирский, cargo - грузовой. "
  type_train = gets.chomp

  if type_train == "pass"
    $list_trains << PassengerTrain.new(number_train)
  elsif type_train == "cargo"
    $list_trains << CargoTrain.new(number_train)
  else
    return puts "Указан неправильный тип поезда"
  end

  puts "Поезд #{type_train} с номером #{number_train} создан"
end

def create_route
  puts "Введи название маршрута"
  name = gets.chomp

  puts "Введи номер начальной станции маршрута: (порядковый номер начиная с 1"
  puts $list_stations.map(&:name)
  start_station = gets.chomp.to_i - 1

  puts "Введи номер конечной станции маршрута:"
  puts $list_stations.map(&:name)
  end_station = gets.chomp.to_i - 1
  $list_routes << Route.new($list_stations[start_station],$list_stations[end_station],name)
end

def edit_route
  puts "Выберите маршрут для редактирования: (введите порядковый номер в списке)"
  puts $list_routes.map(&:name)
  route = $list_routes[gets.chomp.to_i - 1 ]
  puts "Введите delete - для удаления станции или add для добавления станции"
  case gets.chomp
    when "delete"
      puts "Выберите станцию для удаления"
      puts route.list_station.map(&:name)
      route.remove_station(route.list_station[gets.chomp.to_i - 1 ])
    when "add"
      puts "Выберите станцию для добавления"
      available_stations = $list_stations - route.list_station
      puts (available_stations.map(&:name))
      route.add_station(available_stations[gets.chomp.to_i - 1 ])
    else
      puts "Неверная команда"
  end
end

def assign_route
  train_selection
  train = $list_trains[take_number]
  puts "Выберите маршрут"
  puts $list_routes.map(&:name)
  train.assign_route($list_routes[take_number])
end

def attach_wagon
  train_selection
  $list_trains[take_number].attach_wagon
end

def unhook_wagon
  train_selection
  $list_trains[take_number].unhook_wagon
end

def next_station
  train_selection
  $list_trains[take_number].move_to_next_station
end

def previous_station
  train_selection
  $list_trains[take_number].move_to_previous_station
end

def list_trains_on_stations
  $list_stations.each do |station|
    puts station.name
    puts station.trains_at_station
  end
end

def train_selection
  puts "Выберите поезд:"
  puts  $list_trains.map(&:number)
end


def take_number
  gets.chomp.to_i - 1
end

# def generate
#   train_1 = PassengerTrain.new("train_1")
#   train_2 = PassengerTrain.new("train_2")
#   train_3 = PassengerTrain.new("train_3")
#   train_4 = CargoTrain.new("train_4")
#   train_5 = CargoTrain.new("train_5")
#   st_1 = Station.new("Евпатория")
#   st_2 = Station.new("Саки")
#   st_3 = Station.new("Симферополь")
#   st_4 = Station.new("Севастополь")
#   st_5 = Station.new("Ялта")
#   route_1 = Route.new(st_1,st_5,'Евпатория-Ялта')
#   train_1.assign_route(route_1)
# end