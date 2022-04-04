module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    #rubocop:disable all
    def validate(*args)
      return raise "Значение пустое" if args[1] == :presence && (args[0].nil? || args[0].empty?)
      return raise "Неверный формат" if args[1] == :format && args[0] !~ args[2]
      return raise "Нет соответсвия классу" if args[1] == :type && !(args[0].is_a?(args[2]))
    end

    #rubocop:enable all
  end

  module InstanceMethods
    def valid?(*args)
      validate!(*args)
      true
    rescue Exception
      false
    end

    private

    def validate!(*args)
      self.class.validate(*args)
    end
  end
end

