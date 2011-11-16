Feature: Configuring Breadboard
  As a programmer
  I want to be able to configure breadboard in ruby (not YAML)
  So that my engines can each update the breadboard configuration

  Scenario: Configure Breadboard with Ruby, not YAML
    Given I have required breadboard
    Then I should be able to configure breadboard via Ruby blocks

  Scenario: default configuration
    Given I have required breadboard
    Then I should be able to create a default configuration via the "default" Config method

  Scenario: configuring a model by lowercase methods
    Given I have required breadboard
    Then I should be able to configure models via their lowercased, underscored method equivalents

  Scenario: configuring a model via the "model" method
    Given I have required breadboard
    Then I should be able to configure a model by passing the constant for the model to the "model" method

  Scenario: configuring multiple models via the "models" method
    Given I have required breadboard
    Then I should be able to configure multiple models simultaneously by passing their constants to the "models" method
  
  Scenario: configuring the method for determining the Rails environment
    Given I have required breadboard
    Then I should be able to override the default Rails.env environment retrieval in case I'm not in a rails app
