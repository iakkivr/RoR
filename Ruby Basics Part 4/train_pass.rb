# frozen_string_literal: true

require_relative 'train'
require_relative 'instance_counter'
class PassengerTrain < Train
  include InstanceCounter
  def initialize(number)
    super
    @type = 'pass'
  end
end
