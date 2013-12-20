Given /^an ActiveResource model with a site attribute$/ do
  class SomeModel < ActiveResource::Base
    self.site = "http://set.on.model.com"
  end
end

Given /^a Breadboard configuration for that model$/ do
  Breadboard.configure do
    model SomeModel do
      all "http://set.in.breadboard.com"
    end
  end
end

When /^I call the model's site method$/ do
  @site = SomeModel.site
end

Then /^I should recieve the value configured directly on the model$/ do
  @site.to_s.should == "http://set.on.model.com"
end

Then /^ActiveResource should ignore the configuration in Breadboard$/ do
end

Given /^an ActiveResource model without a site attribute$/ do
  class Parent < ActiveResource::Base; end
  class NoSiteAttribute < Parent; end
end

Given /^a Breadboard configuration with 'production' environment settings for that model$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      production "http://set.in.breadboard.exact.match.com"
    end

    model Parent do
      production "http://set.in.breadboard.on.parent.com"
    end

    default do
      production "http://default.production.com"
      all "http://default.all.com"
    end
  end
end

Given /^a Breadboard configuration with 'all' environment settings for that model$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      all "http://set.in.breadboard.exact.match.com"
    end

    model Parent do
      production "http://set.in.breadboard.on.parent.com"
    end

    default do
      production "http://default.production.com"
      all "http://default.all.com"
    end
  end
end

Given /^a Breadboard configuration with 'production' environment settings for an ancestor of that model$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      test "http://set.in.breadboard.exact.match.test.com"
    end

    model Parent do
      production "http://set.in.breadboard.on.parent.com"
    end

    default do
      production "http://default.production.com"
      all "http://default.all.com"
    end
  end
end

Given /^a Breadboard configuration with 'all' environment settings for an ancestor of that model$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      test "http://set.in.breadboard.exact.match.test.com"
    end

    model Parent do
      all "http://set.in.breadboard.on.parent.com"
    end

    default do
      production "http://default.production.com"
      all "http://default.all.com"
    end
  end
end

Given /^a Breadboard configuration with 'production' environment settings in the breadboard defaults section$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      test "http://set.in.breadboard.exact.match.test.com"
    end

    model Parent do
      preview "http://set.in.breadboard.on.parent.com"
    end

    default do
      production "http://default.production.com"
      all "http://default.all.com"
    end
  end
end

Given /^a Breadboard configuration with 'all' environment settings in the breadboard defaults section$/ do
  Breadboard.configure do
    model NoSiteAttribute do
      test "http://set.in.breadboard.exact.match.test.com"
    end

    model Parent do
      preview "http://set.in.breadboard.on.parent.com"
    end

    default do
      all "http://default.all.com"
    end
  end
end

Given /^my Rails environment is "([^"]*)"$/ do |environment|
  unless defined? Rails
    Rails = double "Rails"
  end
  Rails.stub(:env).and_return environment
end

Then /^I should recieve the value configured in the Breadboard "([^"]*)" environment settings for that model$/ do |environment|
  NoSiteAttribute.site.should == Breadboard.config.NoSiteAttribute.send(environment.to_sym).site
end

Then /^I should recieve the value configured in the Breadboard "([^"]*)" environment settings for the ancestor of that model$/ do |environment|
  NoSiteAttribute.site.should == Breadboard.config.Parent.send(environment.to_sym).site
end

Then /^I should recieve the value configured in the Breadboard "([^"]*)" environment settings in the breadboard defaults section$/ do |environment|
  NoSiteAttribute.site.should == Breadboard.config.default.send(environment.to_sym).site
end

Then /^ActiveResource should ignore more generic configurations in Breadboard$/ do
end

Given /^an empty Breadboard configuration$/ do
end

Then /^I should recieve nil$/ do
  NoSiteAttribute.site.should be_nil
end
