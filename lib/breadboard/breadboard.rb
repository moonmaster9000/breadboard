module Breadboard
  extend self

  def config
    Config
  end

  def configure(&block)
    Config.instance_eval &block
  end

  def reset
    Config.reset
  end
end

# 
# 
# class Breadboard
#   attr_reader :config
#   
#   class EnvironmentUnknownError < StandardError; end
#   
#   def initialize(config_yml)
#     @config = YAML.load config_yml
#   end
#   
#   def environment
#     begin
#       RAILS_ENV
#     rescue 
#       raise EnvironmentUnknownError, "RAILS_ENV environment unknown" 
#     end
#   end
#   
#   def service_for(klass)
#     serv = nil
#     while serv.nil? && klass != ActiveResource::Base do
#       table = klass.to_s.tableize.singularize
#       serv = (@config[table][environment] rescue nil) || 
#         (@config[table]['all'] rescue nil) || 
#         nil
#       klass = klass.superclass
#     end
#     serv                                          ||
#     (@config['default'][environment] rescue nil)  || 
#     (@config['default']['all'] rescue nil)        || 
#     ''
#   end
# end
# # 
# # class ActiveResource::Base
# #   class << self
# #     def site_with_breadboard
# #       if defined?(BREAD_BOARD)
# #         unless @site 
# #           self.site = BREAD_BOARD.service_for(self)
# #         end
# #         @site
# #       else
# #         self.site_without_breadboard
# #       end
# #     end
# # 
# #     alias_method_chain :site, :breadboard
# #     
# #     def connection_with_breadboard(refresh = false)
# #       # setting @connection = nil would trigger Connection.new(site...
# #       # @connection is set to nil when calling self.site = 'url' as well
# #       @connection = nil
# #       connection_without_breadboard
# #     end
# #     
# #     alias_method_chain :connection, :breadboard
# #   end
# # end
