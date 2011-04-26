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

  Breadboard.config.default.all.should == "http://localhost:3000"
  Breadboard.config.default.production.should == "http://test.com"
end

Then /^I should be able to create a default configuration via the "default" Config method$/ do
  Breadboard.config.default.all.should == nil
  
  Breadboard.configure do
    default do
      all "http://localhost:3000"
      production "http://test.com"
    end
  end

  Breadboard.config.default.all.should == "http://localhost:3000"
  Breadboard.config.default.production.should == "http://test.com"
end

Then /^I should be able to configure models via their lowercased, underscored method equivalents$/ do
  Breadboard.config.Article.production.should == nil
  
  Breadboard.configure do
    article do
      production "haha"
    end
  end
  
  Breadboard.config.Article.production.should == "haha"
end

Then /^I should be able to configure a model by passing the constant for the model to the "model" method$/ do
  Breadboard.config.Smarticle.production.should == nil
  
  Breadboard.configure do
    model Smarticle do
      production "haha"
    end
  end
  
  Breadboard.config.Smarticle.production.should == "haha"
end

Then /^I should be able to configure multiple models simultaneously by passing their constants to the "models" method$/ do
  Breadboard.config.Particle.production.should == nil
  Breadboard.config.Yarticle.production.should == nil
  
  Breadboard.configure do
    models Particle, Yarticle do
      production "haha"
    end
  end
  
  Breadboard.config.Particle.production.should == "haha"
  Breadboard.config.Yarticle.production.should == "haha"
end
