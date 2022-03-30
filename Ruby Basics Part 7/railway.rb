require_relative 'train'
class Railway
  def create_station
    puts "Введи наименование станции"
    Station.new(name_station = gets.chomp)
    "Станция #{name_station} успешно создана!"
  end

  def create_train
    begin
      puts "Введи номер поезда (формат строки ###-##)"
      number_train = gets.chomp
      puts "Введи тип поезда <pass> - пассажирский, <cargo> - грузовой. "
      type_train = gets.chomp
      Train.new(number_train, type_train)
    rescue Exception => e
      puts e.message
      retry
    end
    puts "Поезд #{type_train} с номером #{number_train} создан"
  end

  def create_route
    puts "Введи название маршрута"
    name = gets.chomp

    puts "Введи номер начальной станции маршрута: (порядковый номер начиная с 1"
    puts Station.all.map(&:name)
    start_station = gets.chomp.to_i - 1

    puts "Введи номер конечной станции маршрута:"
    puts Station.all.map(&:name)
    end_station = gets.chomp.to_i - 1
    Route.new(Station.all[start_station],Station.all[end_station],name)
  end

  def edit_route
    puts "Выберите маршрут для редактирования: (введите порядковый номер в списке)"
    puts Route.list_routes.map(&:name)
    route = Route.list_routes[gets.chomp.to_i - 1 ]
    puts "Введите delete - для удаления станции или add для добавления станции"
    case gets.chomp
      when "delete"
        puts "Выберите станцию для удаления"
        puts route.list_station.map(&:name)
        route.remove_station(route.list_station[gets.chomp.to_i - 1 ])
      when "add"
        puts "Выберите станцию для добавления"
        available_stations = Station.all - route.list_station
        puts (available_stations.map(&:name))
        route.add_station(available_stations[gets.chomp.to_i - 1 ])
      else
        puts "Неверная команда"
    end
  end

  def assign_route
    train = train_selection
    puts "Выберите маршрут"
    puts Route.list_routes.map(&:name)
    train.assign_route(Route.list_routes[take_number])
  end

  def attach_wagon
    train = train_selection
    wagon = if train.type == "pass"
              puts 'Введи количество меств вагоне'
              PassengerWagon.new(gets.chomp)
            else
              puts 'Введи объем грузового вагона'
              CargoWagon.new(gets.chomp)
            end
    train.attach_wagon(wagon)
  end

  def unhook_wagon
    train_selection.unhook_wagon
  end

  def next_station
    train_selection.move_to_next_station
  end

  def previous_station
    train_selection.move_to_previous_station
  end

  def list_trains_on_stations
    Station.all.each do |station|
      puts station.name
      puts station.trains_at_station
    end
  end

  def fill_wagon_interface
    train = train_selection
    wagon = wagon_selection(train)
    fill_wagon(wagon)
  end

  def train_selection
    puts "Выберите поезд:"
    puts  Train.list_trains.map(&:number)
    Train.list_trains[take_number]
  end

  def interface_train_on_station
    print_trains_on_station(station_selection)
  end

  def interface_wagons_in_train
    print_wagons_in_train(train_selection)
  end

  def wagon_selection(train)
    puts "Выберите вагон:"
    puts  train.array_wagon
    train.array_wagon[take_number]
  end

  def station_selection
    puts "Выберите станцию"
    puts Station.all.map(&:name)
    Station.all[take_number]
  end

  def fill_wagon(wagon)
    if wagon.type == "pass"
      wagon.take_seat
      puts "Было занято одно место"
    else
      puts "Введи какой объем занять. Доступно: #{wagon.free_volume}"
      volume = gets.chomp.to_i
      wagon.take_volume(volume)
      puts "Был занят объем: #{volume}"
    end
  end

  def take_number
    gets.chomp.to_i - 1
  end


  def print_trains_on_station(station)
      station.receive_trains do |train|
        puts "  #{train.number} #{train.type} #{train.count_wagon}"
      end
  end

  def print_wagons_in_train(train)
    index_wagon = 1
    train.receive_wagons do |wagon|
      puts "    #{index_wagon} #{wagon.type} #{wagon.type == "cargo" ? wagon.free_volume : wagon.free_seat} / #{wagon.type == "cargo" ? wagon.fill_volume : wagon.busy_seat}"
      index_wagon += 1
    end
  end

end

