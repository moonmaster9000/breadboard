Feature: Configuring Breadboard
  As a programmer
  I want to be able to configure breadboard in ruby (not YAML)
  So that my engines can each update the breadboard configuration

  Background:
    Given I have required breadboard

  Scenario: Configure Breadboard with Ruby, not YAML
    Then I should be able to configure breadboard via Ruby blocks

  Scenario: default configuration
    Then I should be able to create a default configuration via the "default" Config method

  Scenario: configuring a model by lowercase methods
    Then I should be able to configure models via their lowercased, underscored method equivalents

  Scenario: configuring a model via the "model" method
    Then I should be able to configure a model by passing the constant for the model to the "model" method

  Scenario: configuring multiple models via the "models" method
    Then I should be able to configure multiple models simultaneously by passing their constants to the "models" method
  
  Scenario: configuring the method for determining the Rails environment
    Then I should be able to override the default Rails.env environment retrieval in case I'm not in a rails app

  Scenario: Configure Breadboard with hash instead of url
    Then I should be able to configure breadboard with hash

  Scenario: Configure model with user, password
    Then I should be able to configure model with user, password

  Scenario: Configure model with block
    Then I should be able to configure a model with a block

  Scenario: Configure with a volatile lambda
    Then I should be able to configure a model with a volatile lambda
