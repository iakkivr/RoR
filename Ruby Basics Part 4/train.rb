# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :route, :type, :current_station
  attr_accessor :speed

  @@list_trains = []

  def initialize(number)
    @number = number
    @speed = 0
    @array_wagon = []
    @@list_trains << self
    register_instance
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
    set_station(@route.begin_station)
  end

  def move_to_next_station
    return unless next_station

    set_station(next_station)
  end

  def move_to_previous_station
    return unless previous_station

    set_station(previous_station)
  end

  def next_station
    return 'Отсутствует' if @current_station == @route.list_station.last

    @route.list_station[index_currently_station + 1]
  end

  def previous_station
    return 'Отсутствует' if @current_station == @route.list_station.first

    @route.list_station[index_currently_station - 1]
  end

  def self.find(number)
    @@list_trains.find { |train| train.number == number }
  end

  protected # данные методыд не должны вызываться из вне. Использую их только для работы публичных методов

  def set_station(station)
    @current_station&.delete_train(self)
    @current_station = station
    station.take_train(self)
  end

  def index_currently_station
    @route.list_station.index(@current_station)
  end
end
