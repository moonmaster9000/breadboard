#Introduction

breadboard.yml is to ActiveResource as database.yml is to ActiveRecord, taking the data source configuration out of the models and putting it where it belongs, in a configuration file. If the services you connect your ActiveResource models to depends on your RAILS_ENV, then breadboard is for you.

##Install

Breadboard is available as a gem: 

  # gem install breadboard

If you'd like to use this in your rails project, add the following to your config/environment.rb:

  config.gem 'breadboard'

##Usage

All you have to do is create a breadboard.yml file in your RAILS_ROOT/config directory. 

In the simplest scenario, all of your ActiveResource models connect to the same service provider in all environments. In this case, you really don't need this gem, but if you're determined to use it just because you know it's the coolest thing ever, then we've got you covered:

  default:
    all: http://my.universal.service.provider.com

This means: for all ActiveResource models, in all environments, connect them to http://my.universal.service.provider.com

However, it's more likely that you're using this gem because you are in a situation where you need to connect your models to different services based on a rails environment. This is also trivial with breadboard:

  default:
    production: http://my.production.service.provider.com
    development: http://my.development.service.provider
  
Now suppose you have an 'Author' model that needs to connect to a completely different service from everything else, in all environments:
  
  default:
    production: http://my.production.service.provider.com
    development: http://my.development.service.provider

  author:
    all: http://my.author.service.prodiver

Now suppose you have a 'Book' model that needs to connect to a different service provider than the default when in 'production' mode:

  default:
    production: http://my.production.service.provider.com
    development: http://my.development.service.provider

  author:
    all: http://my.author.service.prodiver
  
  book:
    production: http://my.book.production.service.provider

I think you can see where this is going...
