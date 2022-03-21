require_relative 'train'
class CargoTrain < Train
  def initialize(number)
    super
    @type = 'cargo'
  end

  def attach_wagon
    @array_wagon << CargoWagon.new
  end
end
