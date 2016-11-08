# Class for better structure representation
class BotCommand < Bot
  START_TEXT = "
  Hello! It is LabScheduleBot and it will help you with your labs!
  List of all available commands:
  /semester - set the start date and the end date of the semester
  /subject - add subject and set number of labs on it
  /status - show remaining labs
  /submit - delete labs after you passed them
  /reset - reset ALL (!) data
  ".freeze

  LABS_COUNT_REGEXP = /^[0-9]+$/

  ADD_SUBJECT = "
  How is subject called?
  ".freeze

  ADD_LABS_COUNT = "
  How many labs you should pass?
  ".freeze

  OK = "OK".freeze

  RESET_DATA = "
  All your data was deleted.
  ".freeze

  SEMESTER_START_DATE_SET = "
  When your semester starts?
  ".freeze

  SEMESTER_END_DATE_SET = "
  When your semester ends?
  ".freeze

  NO_SUBJECTS = "
  Sorry, seems like you don't have any subjects added.
  You can add them with /subject command.
  ".freeze

  SEMESTER_NOT_STARTED = "
  Your semester has not started yet. Relax.
  ".freeze

  SEMESTER_ENDED = "
  Seems like your semester has already ended.
  ".freeze

  NO_SEMESTER = "
  No information about semester.
  You can add it with /semester command.
  ".freeze

  NO_SUBJECTS = "
  Sorry, seems like you don't have any subjects added.
  You can add them with /subject command.
  ".freeze

  ALL_LABS_DONE = "
  No labs left. Good job.
  ".freeze

  CHOOSE_SUBJECT = "
  What subject?
  ".freeze

  CHOOSE_LAB = "
  What lab?
  ".freeze
end
