class Station
  $list_stations = []
  attr_reader :name
  def initialize(name)
    @name = name
    @train_list = []
    $list_stations << self
  end

  def list_station
    @@list_station
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
