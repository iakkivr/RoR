require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :route, :type, :current_station, :array_wagon
  attr_accessor :speed

  @@list_trains = []

  def initialize(number, type = 'pass')
    @number = number
    @type = type
    validate!
    @speed = 0
    @array_wagon = []
    @@list_trains << self
    register_instance
  end

  def count_wagon
    @array_wagon.count
  end

  def receive_wagons(&block)
    @array_wagon.each do |wagon|
      block.call(wagon)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.list_trains
    @@list_trains
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    @array_wagon << wagon
  end

  def unhook_wagon
    @array_wagon.pop(1)
  end

  def assign_route(route)
    @route = route
    indicate_station(@route.begin_station)
  end

  def move_to_next_station
    return unless next_station

    indicate_station(next_station)
  end

  def move_to_previous_station
    return unless previous_station

    indicate_station(previous_station)
  end

  def next_station
    return if @current_station == @route.list_station.last

    @route.list_station[index_currently_station + 1]
  end

  def previous_station
    return  if @current_station == @route.list_station.first

    @route.list_station[index_currently_station - 1]
  end

  def self.find(number)
    @@list_trains.find { |train| train.number == number }
  end

  protected # данные методыд не должны вызываться из вне. Использую их только для работы публичных методов

  def indicate_station(station)
    @current_station&.delete_train(self)
    @current_station = station
    station.take_train(self)
  end

  def validate!
    raise 'Номер поезда имеет неправильный формат. Введи ###-##' if number !~ /^[а-яА-Яa-zA-Z\d]{3}-?[a-zA-Z\d]{2}$/
    raise 'Неправильный тип поезда. Пассажирский - <pass>. Грузовой - <cargo>.' unless %w[pass cargo].include?(type)
  end

  def index_currently_station
    @route.list_station.index(@current_station)
  end
end
