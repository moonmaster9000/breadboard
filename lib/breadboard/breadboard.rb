module Breadboard
  extend self

  def config
    Config
  end

  def env
    Config.env
  end

  def configure(&block)
    Config.instance_eval &block
  end
  
  def service_for(model, environment=nil)
    environment ||= Config.env.to_s.to_sym rescue :all
    model_superclass_chain = [model] + model.ancestors
    model_superclass_chain.each do |klass|
      klass_symbol = klass.to_s.to_sym
      site = config.send(klass_symbol).send(environment) || config.send(klass_symbol).send(:all)
      if site and !site.empty?
        return site
      end
    end
    return config.default.send(environment) || config.default.send(:all)
  end

  def reset
    Config.reset
  end
end
