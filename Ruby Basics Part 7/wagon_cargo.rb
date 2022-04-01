require_relative 'wagon'
class CargoWagon < Wagon
  attr_reader :fill_volume

  def initialize(total_volume)
    super
    @type = 'cargo'
    @total_volume = total_volume
    @fill_volume = 0
  end

  def take_volume(volume)
    @fill_volume += volume
  end

  def free_volume
    @total_volume - @fill_volume
  end
end
