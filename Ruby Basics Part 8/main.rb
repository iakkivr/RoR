require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_pass'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'
require_relative 'railway'

class Interface
  @command_info = "Список досутпных команд:
  create_railway - создать железную дорогу.
  create_station - создать станцию.
  create_train - создать поезд.
  create_route - создать маршрут.
  edit_route - редактировать маршрут.
  assign_route - назначить маршрут поезду.
  attach_wagon - прицепить вагон.
  unhook_wagon - отцепить вагон.
  next_station - отправить поезд на следующую станцию по маршруту.
  previous_station - отправить поезд на предыдущую станцию маршрута.
  list_trains_on_stations - получить список станций и поездов на них.
  trains_at_station - подробная информация о поездах на станции.
  wagons_at_train - информация о вагонах поезда.
  fill_wagon - заполнить грузовой или пассажирский вагоны.
  list_trains_on_stations_detail - подробная информация о поездах на станции.
  list_wagons_in_trains - подробная информация о вагонах поезда
  info - получить список команд
  stop - для выхода"
  def self.start
    puts @command_info
    wait_command
  end
  # rubocop:disable all
  def self.generate
    wagon_c1 = CargoWagon.new(500)
    wagon_c2 = CargoWagon.new(400)
    wagon_c3 = CargoWagon.new(300)
    wagon_c2.take_volume(200)
    wagon_p1 = PassengerWagon.new(200)
    5.times { wagon_p1.take_seat }
    wagon_p2 = PassengerWagon.new(150)
    wagon_p3 = PassengerWagon.new(100)
    train_p1 = PassengerTrain.new('pas-01')
    train_c1 = CargoTrain.new('crg-01')
    train_c1.attach_wagon(wagon_c1)
    train_c1.attach_wagon(wagon_c2)
    train_c1.attach_wagon(wagon_c3)
    train_p1.attach_wagon(wagon_p1)
    train_p1.attach_wagon(wagon_p2)
    train_p1.attach_wagon(wagon_p3)
    station1 = Station.new('Евпатория')
    station2 = Station.new('Симферополь')
    station1.take_train(train_p1)
    station1.take_train(train_c1)
    Route.new(station1, station2, 'City1 - City2 speed')
    train_c1.
  end

  def self.wait_command
    loop do
      case gets.chomp
      when 'create_railway'
        @railway = Railway.new
        puts 'Железная дорога создана.'
      when 'create_train'
        @railway.create_train
      when 'create_route'
        @railway.create_route
      when 'edit_route'
        @railway.edit_route
      when 'assign_route'
        @railway.assign_route
      when 'attach_wagon'
        @railway.attach_wagon
      when 'unhook_wagon'
        @railway.unhook_wagon
      when 'next_station'
        @railway.next_station
      when 'previous_station'
        @railway.previous_station
      when 'list_trains_on_stations'
        @railway.list_trains_on_stations
      when 'info'
        puts @command_info
      when 'list_trains_on_stations_detail'
        @railway.interface_train_on_station
      when 'list_wagons_in_trains'
        @railway.interface_wagons_in_train
      when 'fill_wagon'
        @railway.fill_wagon_interface
      when 'stop'
        break
      else
        'Команда не найдена. Попробуй ввести заново.'
      end
    end
  end
end

puts 'Программа управления железной дорогой. Для начала требуется создать железную дорогу.'
Interface.generate
Interface.start

# rubocop:enable all