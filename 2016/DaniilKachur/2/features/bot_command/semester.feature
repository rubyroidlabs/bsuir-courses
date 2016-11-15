Feature: Execute command /semester
  In order to finish execution of command /semester 
  A user
  Should be input valid data

  Scenario: Execute command /semester
    Given text "/semester"
    Then start execution of BotCommand::Semester
    And view message "Когда начинаем учиться?"
