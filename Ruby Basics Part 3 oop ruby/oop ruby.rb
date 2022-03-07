class Train
  attr_reader :number, :type, :amount_of_wagons, :nearby_station, :route, :type, :current_station

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
    @amount_of_wagons -= 1  if @amount_of_wagons > 1 && @speed.zero?
  end

  def attach_wagon
    @amount_of_wagons += 1 if  @speed.zero?
  end

  def get_route(route, set = 1)
    @route = route
    set_station(@route.begin_station) if set.positive?
  end

  def move_to_next_station
    index_next_station = @route.get_stations.index(current_station) + 1
    set_station(@route.get_stations[index_next_station])
  end

  def move_to_previous_station
    index_previous_station = @route.get_stations.index(current_station) - 1
    set_station(@route.get_stations[index_previous_station])
  end

  def nearby_station
     @nearby_station
  end

  def send(train)
    @direction_of_travel = 1 ? train.move_to_next_station : train.move_to_previous_station
  end

  def update_routes

  end

  def set_station(station)
    @current_station.delete_train(self) unless @current_station.nil?
    @current_station = station
    station.take_train(self)
  end


end

class Route

  def initialize(begin_station,end_station)
    @list_station = [begin_station,end_station]
  end

  def begin_station
    @list_station.first
  end

  def add_station(station,index)
    index = @list_station.count - 1 if index > @list_station.count - 2
    index = 1 if index < 1
    puts @list_station.count
    @list_station.insert(index,station)
    #update_routes_for_trains(0)
  end

  def get_stations
    # @list_station.map(&:name)
    @list_station
  end

  def remove_station(index_station)
    @list_station.delete_at(index_station) if index_station.positive? && index_station < @list_station.count - 1
    update_routes_for_trains(1)
  end

  private

  def update_routes_for_trains(set_station = 0)
    @list_station.each do |station|
      train.get_route(self,set_station)
    end
  end
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



