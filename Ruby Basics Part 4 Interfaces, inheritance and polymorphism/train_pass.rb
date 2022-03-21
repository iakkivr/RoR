require_relative 'train'
class PassengerTrain < Train
  def initialize(number)
    super
    @type = 'pass'
  end

  def attach_wagon
    @array_wagon << PassengerWagon.new
  end

end
