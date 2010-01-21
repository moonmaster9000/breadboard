class Breadboard
  attr_reader :config
  
  class EnvironmentUnknownError < StandardError; end
  
  def initialize(config_yml)
    @config = YAML.load config_yml
    configure_services
  end
  
  def environment
    begin
      RAILS_ENV
    rescue 
      raise EnvironmentUnknownError, "RAILS_ENV environment unknown" 
    end
  end
  
  def service_for(klass)
    klass = klass.downcase
    (@config[klass][environment] rescue nil)      || 
    (@config[klass]['all'] rescue nil)            ||
    (@config['default'][environment] rescue nil)  || 
    (@config['default']['all'] rescue nil)        || 
    ''
  end
  
  private
  def configure_services
    classes = ActiveResource::Base.send(:subclasses)
    classes.each do |klass|
      klass.constantize.site = service_for(klass) if klass.constantize.site == nil
    end
  end
end