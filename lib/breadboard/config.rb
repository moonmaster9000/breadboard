module Breadboard
  module Config
    extend self

    def config
      @config ||= {}
    end
    
    def env(&block)
      @env ||= proc { Rails.env }
      return @env.call unless block
      @env = block 
    end
    
    def default(&block)
      config_or_access :default, &block
    end

    def model(model_name, &block)
      config_or_access model_name, &block
    end

    def reset
      @config = {}
    end

    def models(*model_classes, &block)
      raise "You must pass a block to the `models` method" if block.nil?
      
      model_classes.each do |model_class|
        config_or_access model_class, &block
      end
    end

    def method_missing(method_name, *args, &block)
      config_or_access method_name, &block
    end

    private
    def config_or_access(model, &block)
      model = model.to_s.camelize.to_sym
      config[model] ||= Environment.new
      if block
        config[model].instance_eval &block
      else
        config[model]
      end
    end
  end
end
