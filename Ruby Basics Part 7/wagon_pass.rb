require_relative 'wagon'
class PassengerWagon < Wagon
  attr_reader :busy_seat

  def initialize(total_seat)
    super
    @busy_seat = 0
    @type = 'pass'
    @total_seat = total_seat
  end

  def take_seat
    @busy_seat += 1
  end

  def free_seat
    @total_seat - @busy_seat
  end
end
