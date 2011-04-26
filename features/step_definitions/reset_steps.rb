Given /^I have configured breadboard$/ do
  Breadboard.configure do
    default do
      all "http://test.com"
    end
  end
end

When /^I call the method Breadboard\.reset$/ do
  Breadboard.config.default.all.should == "http://test.com"
  Breadboard.reset
end

Then /^the Breadboard configuration should be reset to an empty configuration$/ do
  Breadboard.config.default.all.should be_nil
end
