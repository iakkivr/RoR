require_relative 'wagon'
class PassengerWagon < Wagon
  def initialize
    @type = 'pass'
  end
end
