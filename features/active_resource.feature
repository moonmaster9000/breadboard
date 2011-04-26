Feature: ActiveResource::Base looks up site config in breadboard
  
  Scenario: Site configuration on the model itself takes highest precedence
    Given an ActiveResource model with a site attribute
    And a Breadboard configuration for that model
    When I call the model's site method
    Then I should recieve the value configured directly on the model
    And ActiveResource should ignore the configuration in Breadboard
  
  Scenario: Specific environment configuration for an exact model match in Breadboard should take the next highest precedence
    Given an ActiveResource model without a site attribute
    And a Breadboard configuration with 'production' environment settings for that model
    And my Rails environment is "production"
    When I call the model's site method
    Then I should recieve the value configured in the Breadboard "production" environment settings for that model
    And ActiveResource should ignore more generic configurations in Breadboard
 
