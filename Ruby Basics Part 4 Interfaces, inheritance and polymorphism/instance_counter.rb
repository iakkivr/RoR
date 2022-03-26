module InstanceCounter
  
  def self.included(base)
    base.class_variable_set :@@instances, 0
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.class_variable_get :@@instances
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.class_variable_set :@@instances, (self.class.class_variable_get(:@@instances) + 1)
    end
  end
end

