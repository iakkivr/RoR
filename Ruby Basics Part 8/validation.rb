module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
     attr_reader :types
    def validate(name, type_method, *args)
      @types ||= []
      @types << { name: name, type_method: type_method, args: args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.types.each do |variable|
        value = instance_variable_get("@#{variable[:name]}")
        presence(value) if variable[:type_method] == :presence
        format(value, variable[:args]) if variable[:type_method] == :format
        type(value, variable[:args].first) if variable[:type_method] == :type
        #   send variable[:type_method], variable[:name], value, variable[:args]
      end
    end

    def valid?
      validate!
      true
    rescue Exception
      false
    end

    def presence(value)
      raise "Presence Error" if value.nil? || value.to_s.empty?
    end

    def format(value, format)
      raise "Format error" if value !~ format[0]
    end

    def type(name, type_class)
      raise "Class Error" unless name.is_a?(type_class)
    end
  end
end
