require_relative 'train'
require_relative 'instance_counter'
class CargoTrain < Train
  include InstanceCounter
  def initialize(number)
    super
    @type = 'cargo'
  end
end

