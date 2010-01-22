class Breadboard
  attr_reader :config
  
  class EnvironmentUnknownError < StandardError; end
  
  def initialize(config_yml)
    @config = YAML.load config_yml
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
end

class ActiveResource::Base
  class << self
    def site_with_breadboard
      if defined?(BREAD_BOARD)
        unless @site 
          self.site = BREAD_BOARD.service_for(self.to_s)
        end
        @site
      else
        self.site_without_breadboard
      end
    end

    alias_method_chain :site, :breadboard
  end
end
