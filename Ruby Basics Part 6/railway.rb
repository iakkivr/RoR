require_relative 'train'
class Railway
  def create_station
    puts 'Введи наименование станции'
    Station.new(name_station = gets.chomp)
    "Станция #{name_station} успешно создана!"
  end

  def create_train
    begin
      puts 'Введи номер поезда (формат строки ###-##)'
      number_train = gets.chomp
      puts 'Введи тип поезда <pass> - пассажирский, <cargo> - грузовой. '
      type_train = gets.chomp
      Train.new(number_train, type_train)
    rescue Exception => e
      puts e.message
      retry
    end
    puts "Поезд #{type_train} с номером #{number_train} создан"
  end

  def create_route
    puts 'Введи название маршрута'
    name = gets.chomp

    puts 'Введи номер начальной станции маршрута: (порядковый номер начиная с 1'
    puts Station.all.map(&:name)
    start_station = gets.chomp.to_i - 1

    puts 'Введи номер конечной станции маршрута:'
    puts Station.all.map(&:name)
    end_station = gets.chomp.to_i - 1
    Route.new(Station.all[start_station], Station.all[end_station], name)
  end

  def edit_route
    puts 'Выберите маршрут для редактирования: (введите порядковый номер в списке)'
    puts Route.list_routes.map(&:name)
    route = Route.list_routes[gets.chomp.to_i - 1]
    puts 'Введите delete - для удаления станции или add для добавления станции'
    case gets.chomp
    when 'delete'
      puts 'Выберите станцию для удаления'
      puts route.list_station.map(&:name)
      route.remove_station(route.list_station[gets.chomp.to_i - 1])
    when 'add'
      puts 'Выберите станцию для добавления'
      available_stations = Station.all - route.list_station
      puts(available_stations.map(&:name))
      route.add_station(available_stations[gets.chomp.to_i - 1])
    else
      puts 'Неверная команда'
    end
  end

  def assign_route
    train_selection
    train = Train.list_trains[take_number]
    puts 'Выберите маршрут'
    puts Route.list_routes.map(&:name)
    train.assign_route(Route.list_routes[take_number])
  end

  def attach_wagon
    train_selection
    train = Train.list_trains[take_number]
    wagon = train.type == 'pass' ? PassengerWagon.new : CargoWagon.new
    train.attach_wagon(wagon)
  end

  def unhook_wagon
    train_selection
    Train.list_trains[take_number].unhook_wagon
  end

  def next_station
    train_selection
    Train.list_trains[take_number].move_to_next_station
  end

  def previous_station
    train_selection
    Train.list_trains[take_number].move_to_previous_station
  end

  def list_trains_on_stations
    Station.all.each do |station|
      puts station.name
      puts station.trains_at_station
    end
  end

  def train_selection
    puts 'Выберите поезд:'
    puts Train.list_trains.map(&:number)
  end

  def take_number
    gets.chomp.to_i - 1
  end
end
