require_relative 'instance_counter'

class Station
  include InstanceCounter
  @@list_stations = []
  attr_reader :name

  def initialize(name)
    @name = name
    @train_list = []
    @@list_stations << self
    self.register_instance
  end

  def self.all
    @@list_stations
  end


  def take_train(train)
    @train_list << train
  end

  def trains_at_station
    @train_list
  end

  def trains_by_type(type)
    @train_list.filter { |elem| elem.type == type }
  end

  def send_train(train)
    self == train.route.finish_station ? train.move_to_previous_station : train.move_to_next_station
    delete_train(train)
  end

  protected
  def delete_train(train)
    @train_list.delete(train)
  end
end
st1 = Station.new '1'
st2 = Station.new '2'
st3 = Station.new '3'
st4 = Station.new '4'

puts Station.instances