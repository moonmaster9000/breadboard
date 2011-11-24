#Introduction

Change your ActiveResource service providers based on your environment.

##Install

Breadboard is available as a gem: 

    # gem install breadboard

##Usage

If you're using this in a Rails app, you'll want to configure `Breadboard` in an initializer.

In the simplest scenario, all of your `ActiveResource` models connect to the same service provider in all environments. 
In this case, you really don't need this gem, but if you're determined to use it just because you know it's the coolest thing ever, then we've got you covered:

    Breadboard.configure do
      default do
        all "http://my.universal.service.provider.com"
      end
    end

This means: for all ActiveResource models, in all environments, connect them to `http://my.universal.service.provider.com`

However, it's more likely that you're using this gem because you are in a situation where you need to connect your models to different 
services based on a rails environment. This is also trivial with breadboard:

    Breadboard.configure do
      default do
        all "http://my.universal.service.provider.com"
        production "http://my.production.service.provider.com"
      end
    end
 
Now suppose you have an 'Author' model that needs to connect to a completely different service from everything else, in all environments:

    Breadboard.configure do
      default do
        all "http://my.universal.service.provider.com"
        production "http://my.production.service.provider.com"
      end
      
      author do 
        all "http://my.author.service.provider"
      end
    end

You can use this alternate syntax, if you prefer:

    Breadboard.configure do
      default do
        all "http://my.universal.service.provider.com"
        production "http://my.production.service.provider.com"
      end
      
      model Author do 
        all "http://my.author.service.provider"
      end
    end

Now suppose you have a 'Book' model that needs to connect to a different service provider than the default when in 'production' mode:

    Breadboard.configure do
      default do
        all "http://my.universal.service.provider.com"
        production "http://my.production.service.provider.com"
      end
      
      model Author do 
        all "http://my.author.service.provider"
      end

      model Book do
        production "http://my.book.production.service.provider"
      end
    end

If you need to set user and password for a restful service, you can use hash instead of string

    Breadboard.configure do
      model Book do
        production Hash[:site => "http://my.book.production.service.provider",
                        :user => "user1",
                        :password => "password"]
      end
    end


## Configuring the environment

By default, Breadboard will check `Rails.env` to see what environment your app is in. 

If your using Breadboard in something other than a rails app, you can configure how Breadboard determines your app's environment:

    Breadboard.configure do
      env do
        # your app environment lookup logic here
      end
    end

## Mutiple models with the same configuration

Imagine you have several models that all share the same app configuration. There's two ways to about this configuration:

- Let all of your models inherit from the same parent class and configure the parent class in breadboard
- use the `models` method

### Inheritance

Let's imagine you have three models that should all share the same configuration: `Article`, `Author`, `Comment`. If they all inherited from the same parent, 
`Publishing`, then you could simply configure the parent class in breadboard:

    Breadboard.configure do
      model Publishing do 
        all "http://my.publishing.service.provider"
      end
    end

If any of the children needed some configuration override, that will take precedence

    Breadboard.configure do
      model Publishing do 
        all "http://my.publishing.service.provider"
      end

      model Article do
        production "http://my.article.production.service.provider"
      end
    end

### `models` Method

If your `Article`, `Author`, and `Comment` models couldn't all inherit from the same parent, you can still easily provide the same configuration for them 
via the `models` method:

    Breadboard.configure do
      models Article, Author, Comment do 
        all "http://my.publishing.service.provider"
        production "http://my.production.publishing.service.provider"
      end
    end
