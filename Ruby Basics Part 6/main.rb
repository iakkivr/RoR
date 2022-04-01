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
  info - получить список команд
  stop - для выхода"

  def self.start
    puts @command_info
    wait_command
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
      when 'stop'
        break
      else
        'Команда не найдена. Попробуй ввести заново.'
      end
    end
  end
end

puts 'Программа управления железной дорогой. Для начала требуется создать железную дорогу.'
Interface.start
