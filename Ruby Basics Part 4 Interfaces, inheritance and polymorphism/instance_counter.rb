module InstanceCounter

  def self.included(base)
    base.instance_variable_set :@instances, 0
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      self.instance_variable_get :@instances
    end

  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_variable_set :@instances, (self.class.instance_variable_get(:@instances) + 1)
    end
  end
end

