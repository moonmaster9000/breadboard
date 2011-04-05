require 'active_resource'
require 'active_support'
require 'breadboard/breadboard'
BREAD_BOARD = Breadboard.new((File.open(RAILS_ROOT.to_s + "/config/breadboard.yml") rescue "")) if defined?(RAILS_ROOT)

# if used in a plain ruby app. you have to specify BREAD_BOARD manually, for exmaple:
#   BREAD_BOARD = Breadboard.new(YOUR_YAML_STR, :env => "development")
