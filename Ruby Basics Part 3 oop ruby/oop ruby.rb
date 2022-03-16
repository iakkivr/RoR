class Train
  attr_reader :number, :type, :amount_of_wagons, :route, :type, :current_station
  attr_accessor :speed

  def initialize(number, type = 1, amount_of_wagons = 1)
    @number = number
    @type = type
    @amount_of_wagons = amount_of_wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def unhook_wagon
    @amount_of_wagons -= 1 if @amount_of_wagons > 1 && @speed.zero?
  end

  def attach_wagon
    @amount_of_wagons += 1 if @speed.zero?
  end

  def assign_route(route)
    @route = route
    set_station(@route.begin_station)
  end

  def set_station(station)
    @current_station.delete_train(self) unless @current_station.nil?
    @current_station = station
    station.take_train(self)
  end

  def move_to_next_station
    return "Последняя станция, движение дальше невозможно" if @current_station == @route.list_station.last
    set_station(next_station)
  end

  def move_to_previous_station
    return "Начальняя станция, движение на предыдущую невозможно" if @current_station == @route.list_station.first
    set_station(previous_station)
  end

  def nearby_station
    "Предыдущая станция: #{previous_station}
Текущая станция: #{@current_station.name}
Следующая станция: #{next_station}"
  end

  def next_station
    return "Отсутствует" if @current_station == @route.list_station.last
    @route.list_station[index_currently_station + 1]
  end

  def previous_station
    return "Отсутствует" if @current_station == @route.list_station.first
    @route.list_station[index_currently_station - 1]
  end

  private
  def index_currently_station
    @route.list_station.index(@current_station)
  end

end

class Route
  attr_reader :list_station
  def initialize(begin_station,finish_station)
    @list_station = [begin_station,finish_station]
  end

  def begin_station
    @list_station.first
  end

  def finish_station
    @list_station.last
  end

  def add_station(station,index=1)
    index = @list_station.count - 1 if index > @list_station.count - 2
    index = 1 if index < 1
    @list_station.insert(index,station)
  end


  def remove_station(station)
    @list_station.delete(station) if station != @list_station.first && station != @list_station.last
  end

  private

end


class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @train_list = []
  end

  def take_train(train)
    @train_list << train
  end

  def trains_at_station
    @train_list
  end

  def trains_by_type(type)
    "#{type}: #{@train_list.count { |elem| elem.type == type }} шт
#{@train_list.filter{ |element| element.type == type}.map(&:number)}"
  end

  def send_train(train)
    self == train.route.finish_station ? train.move_to_previous_station : train.move_to_next_station
    delete_train(train)
  end

  def delete_train(train)
    @train_list.delete(train)
  end
end
