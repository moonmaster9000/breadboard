require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "breadboard"
    gemspec.summary     = "breadboard.yml is to ActiveResource as database.yml is to ActiveRecord"
    gemspec.description = "Breadboard allows you to define what services your ActiveResource derived classes" + 
                          " connect to based on your rails environment. " 
    gemspec.email       = "moonmaster9000@gmail.com"
    gemspec.files       = FileList['lib/**/*.rb', 'README.rdoc']
    gemspec.homepage    = "http://github.com/moonmaster9000/breadboard"
    gemspec.authors     = ["Matt Parker", "Steve Koppelman"]
    gemspec.add_dependency('rails', '>= 2.3.3')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
