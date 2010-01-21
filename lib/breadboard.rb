require 'active_resource'
require 'breadboard/breadboard'
Breadboard.new((File.open(RAILS_ROOT + "/config/breadboard.yml") rescue "")) if defined?(RAILS_ROOT)
