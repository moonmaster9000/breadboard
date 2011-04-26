Feature: Configuring Breadboard
  As a programmer
  I want to be able to configure breadboard in ruby (not YAML)
  So that my engines can each update the breadboard configuration

  Scenario: Configure Breadboard with Ruby, not YAML
    Given I have required breadboard
    Then I should be able to configure breadboard via Ruby blocks
