Feature: Resetting Breadboard

  Scenario: Resetting Breadboard should clear out all configuration data
    Given I have required breadboard
    And I have configured breadboard
    When I call the method Breadboard.reset
    Then the Breadboard configuration should be reset to an empty configuration
