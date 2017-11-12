Feature: Bot command Subject
  As a Bot
  I want to execute command Subject
  In order to add subject name and labs amount for it
  
  Background: 
    Given a webhook message
    Given a user with id 123456789

  Scenario: Bot start execution of command Subject
    Given I have a message with text "/subject"
    When I try to start execute command
    Then I should send message for response
    And I should get confirming message with text "Какой предмет учим?"
