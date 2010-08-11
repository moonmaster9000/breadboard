require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Breadboard do
  before do
    @yml = 
      "default:\n  all:  http://services.com\n\n" +
      "article:\n  production: http://article.services.com\n\n" +
      "author:\n  development: http://development.author.services.com\n\n" + 
      "book:\n  all: http://all.book.services.com\n\n" +
      "genre:\n  all: http://all.genre.services.com\n\n" +
      "sub_genre:\n  production: http://all.sub.genre.services.com"
  end
  
  describe "#initialize" do
    it "should accept a yml file string" do
      proc { Breadboard.new(@yml) }.should_not raise_error
    end
    
    it "should require that the yml be valid" do
      proc { Breadboard.new(true) }.should raise_error
    end
    
    it "should parse the configuration and store it internally" do
      Breadboard.new(@yml).config["default"]["all"].should == "http://services.com"
    end
    
    it "should configure any ActiveResource::Base derived class with the appropriate site" do
      define_const "RAILS_ENV", "development"
      class Book < ActiveResource::Base; end
      class Author < ActiveResource::Base; end
      class Article < ActiveResource::Base; end
      class Genre < ActiveResource::Base; end
      class SubGenre < Genre; end
      define_const "BREAD_BOARD", Breadboard.new(@yml)
      Book.site.host.should == "all.book.services.com"
      Author.site.host.should == "development.author.services.com"
      Article.site.host.should == "services.com"
      Genre.site.host.should == "all.genre.services.com"
      SubGenre.site.host.should == "all.genre.services.com"
    end
  end
  
  describe "#environment" do
    before do
      define_const "RAILS_ENV", 'breadboard_test'
    end
    
    it "should return the rails environment if it is set" do
      Breadboard.new(@yml).environment.should == 'breadboard_test'
    end
    
    it "should return UNKNOWN_ENVIRONMENT if the rails environment isn't set" do
      undefine_const "RAILS_ENV"
      proc {Breadboard.new(@yml).environment}.should raise_error(Breadboard::EnvironmentUnknownError)
    end
  end
  
  describe "#service_for" do
    before do
      @s = Breadboard.new(@yml)
      define_const "RAILS_ENV", 'production'
    end
    
    it "should require a class name" do
      proc { @s.service_for }.should raise_error(ArgumentError)
    end
    
    it "should return the appropriate service for that class" do
      @s.service_for(Article).should == 'http://article.services.com'
      @s.service_for(Author).should == 'http://services.com'
      @s.service_for(Book).should == 'http://all.book.services.com'
      @s.service_for(Genre).should == 'http://all.genre.services.com'
      @s.service_for(SubGenre).should == 'http://all.sub.genre.services.com'
    end
  end
end