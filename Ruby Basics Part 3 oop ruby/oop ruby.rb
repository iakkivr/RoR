class Train
  attr_reader :number, :type, :amount_of_wagons, :route, :type, :current_station

  def initialize(number, type = 1, amount_of_wagons = 1)
    @number = number
    @type = type
    @amount_of_wagons = amount_of_wagons
    @speed = 0
    @direction_of_travel = 1 # 1 - вперед, 0 - назад
    @route = []
  end

  def set_speed(speed)
    @speed = speed
  end

  def current_speed
    @speed
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

  def get_route(route)
    @route = route
    set_station(@route.begin_station)
  end

  def set_station(station)
    @current_station.delete_train(self) unless @current_station.nil?
    @current_station = station
    @direction_of_travel = if @current_station == @route.get_stations.last
                             0
                           elsif @current_station == @route.get_stations.first
                             1
                           else
                             @direction_of_travel
                           end
    station.take_train(self)
  end

  def move_to_next_station
    return "Последняя станция, движение дальше невозможно" if @current_station == @route.get_stations.last
    nearby_station
    set_station(@next_station)
  end

  def move_to_previous_station
    return "Начальняя станция, движение на предыдущую невозможно" if @current_station == @route.get_stations.first
    nearby_station
    set_station(@previous_station)
  end

  def nearby_station
    index_currently_station = @route.get_stations.index(@current_station)
    @next_station = @route.get_stations[index_currently_station + 1]
    @previous_station = @route.get_stations[index_currently_station - 1]
    print_previous = if @previous_station.nil?
                       'отсутствует'
                     else
                       @previous_station.name
                     end

    print_next = if @next_station.nil?
                       'отсутствует'
                     else
                       @next_station.name
                     end
    "Предыдущая станция: #{print_previous}
Текущая станция: #{@current_station.name}
Следующая станция: #{print_next}"
  end

  def send(train)
    @direction_of_travel == 1 ? train.move_to_next_station : train.move_to_previous_station
  end

end

class Route

  def initialize(begin_station,end_station)
    @list_station = [begin_station,end_station]
  end

  def begin_station
    @list_station.first
  end

  def add_station(station,index=1)
    index = @list_station.count - 1 if index > @list_station.count - 2
    index = 1 if index < 1
    @list_station.insert(index,station)
  end

  def get_stations
    @list_station
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
    @train_list.map(&:number)
  end

  def amount_trains_by_type
    "Грузовых: #{@train_list.count { |elem| elem.type == 1 }} шт
Пассажирских: #{@train_list.count { |elem| elem.type == 2 }} шт"
  end

  def send_train(train)
    train.send(train)
    delete_train(train)
  end

  def delete_train(train)
    @train_list.delete(train)
  end
end

train1 = Train.new('Train 1')
station_1 = Station.new('St1')
station_2 = Station.new('St2')
station_3 = Station.new('St3')
route_1 = Route.new(station_1,station_3)
route_1.add_station(station_2)
train1.get_route(route_1)

#
#
#
