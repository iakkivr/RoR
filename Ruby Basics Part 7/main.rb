# frozen_string_literal: true

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

  def self.generate
    wagon_c_1 = CargoWagon.new(500)
    wagon_c_2 = CargoWagon.new(400)
    wagon_c_3 = CargoWagon.new(300)
    wagon_c_2.take_volume(200)
    wagon_p_1 = PassengerWagon.new(200)
    5.times { wagon_p_1.take_seat }
    wagon_p_2 = PassengerWagon.new(150)
    wagon_p_3 = PassengerWagon.new(100)
    train_p_1 = PassengerTrain.new('pas-01')
    train_c_1 = CargoTrain.new('crg-01')
    train_c_1.attach_wagon(wagon_c_1)
    train_c_1.attach_wagon(wagon_c_2)
    train_c_1.attach_wagon(wagon_c_3)
    train_p_1.attach_wagon(wagon_p_1)
    train_p_1.attach_wagon(wagon_p_2)
    train_p_1.attach_wagon(wagon_p_3)
    station_1 = Station.new('Евпатория')
    station_2 = Station.new('Симферополь')
    station_1.take_train(train_p_1)
    station_1.take_train(train_c_1)
    Route.new(station_1, station_2, 'Evpa - Simf speed')
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
