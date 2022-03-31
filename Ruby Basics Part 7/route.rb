# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'station'
class Route
  include InstanceCounter

  def self.list_routes
    @@list_routes
  end

  attr_reader :list_station, :name

  @@list_routes = []
  def initialize(begin_station, finish_station, name)
    @list_station = [begin_station, finish_station]
    @name = name.to_s
    register_instance
    validate!
    @@list_routes << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def begin_station
    @list_station.first
  end

  def finish_station
    @list_station.last
  end

  def add_station(station, index = 1)
    index = @list_station.count - 1 if index > @list_station.count - 2
    index = 1 if index < 1
    @list_station.insert(index, station)
  end

  def remove_station(station)
    @list_station.delete(station) if station != @list_station.first && station != @list_station.last
  end

  protected

  def validate!
    unless begin_station.is_a?(Station) && finish_station.is_a?(Station)
      raise 'Для создания маршрута требуется указать станции'
    end
    raise 'Имя должно быть длинее 3 символов' if name.length < 3
  end
end
