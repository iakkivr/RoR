=begin
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные
 указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает
количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только
на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end
class Train
  #  attr_accessor
  attr_reader :number, :type, :amount_of_wagons, :speed, :nearby_station, :route
# attr_writer
  def initialize(number, type = 1, amount_of_wagons = 1)
    @number = number
    @type = type
    @amount_of_wagons = amount_of_wagons
  end

  def set_speed=(speed)
    @speed = speed
  end
  def stop
    @speed = 0
  end
  def unhook_wagon
    @amount_of_wagons -= 1  if @amount_of_wagons > 1 && @speed == 0
  end
  def attach_wagon
    @amount_of_wagons += 1 if  @speed == 0
  end

  def move_to_next_station
    @index_station += 1
  end
  def move_to_previous_station
    @index_station -= 1
  end

  def get_route(route)
    @route = route.list_station
    @index_station = 0
  end

  def nearby_station
     @nearby_station = { "Предыдущая" => @route[@index_station - 1 ],"Текущая" => @route[@index_station],"Следующая" =>@route[@index_station + 1] }
  end
end

class Route
  # attr_accessor :route_station
  attr_reader :list_station
  def initialize(begin_station,end_station)
    @list_station = [begin_station,end_station]
  end
  def add_station(station)
    @route_station.insert(1,station)
  end

  def remove_station(index_station)
    @list_station.delete_at(index_station) if index_station.positive? && index_station < @list_station.count - 1
  end
end

train = Train.new("First", 1, 10)
route_first = Route.new('First','Last')
train.get_route(route_first)
puts train.nearby_station
