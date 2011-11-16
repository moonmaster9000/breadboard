class Particle; end
class Yarticle; end
class Article; end
class Smarticle; end

Given /^I have required breadboard$/ do
  require 'breadboard'
end

Then /^I should be able to configure breadboard via Ruby blocks$/ do
  Breadboard.config.default.all.should == nil
  
  Breadboard.configure do
    default do
      all "http://localhost:3000"
      production "http://test.com"
    end
  end

  Breadboard.config.default.all.to_s.should == "http://localhost:3000"
  Breadboard.config.default.production.to_s.should == "http://test.com"
end

Then /^I should be able to create a default configuration via the "default" Config method$/ do
  Breadboard.config.default.all.should == nil
  
  Breadboard.configure do
    default do
      all "http://localhost:3000"
      production "http://test.com"
    end
  end

  Breadboard.config.default.all.to_s.should == "http://localhost:3000"
  Breadboard.config.default.production.to_s.should == "http://test.com"
end

Then /^I should be able to configure models via their lowercased, underscored method equivalents$/ do
  Breadboard.config.Article.production.should == nil
  
  Breadboard.configure do
    article do
      production "http://haha"
    end
  end
  
  Breadboard.config.Article.production.to_s.should == "http://haha"
end

Then /^I should be able to configure a model by passing the constant for the model to the "model" method$/ do
  Breadboard.config.Smarticle.production.should == nil
  
  Breadboard.configure do
    model Smarticle do
      production "http://haha"
    end
  end
  
  Breadboard.config.Smarticle.production.to_s.should == "http://haha"
end

Then /^I should be able to configure multiple models simultaneously by passing their constants to the "models" method$/ do
  Breadboard.config.Particle.production.should == nil
  Breadboard.config.Yarticle.production.should == nil
  
  Breadboard.configure do
    models Particle, Yarticle do
      production "http://haha"
    end
  end
  
  Breadboard.config.Particle.production.to_s.should == "http://haha"
  Breadboard.config.Yarticle.production.to_s.should == "http://haha"
end

Then /^I should be able to override the default Rails\.env environment retrieval in case I'm not in a rails app$/ do
  unless defined? Rails
    Rails = double "Rails"
  end
  Rails.stub(:env).and_return "rails-breadboard-test"
  Rails.env.should == "rails-breadboard-test"
  Breadboard.env.should == "rails-breadboard-test"
  Breadboard.configure do
    env do
      "override!"
    end
  end
  Breadboard.env.should == "override!"
end
