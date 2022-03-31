# frozen_string_literal: true

require_relative 'manufacturer'
class Wagon
  include Manufacturer
  def initialize(type)
    @type = type
  end
end
