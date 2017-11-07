module ApplicationView
  module_function

  def hello
    'Hello there🖐'
  end

  def i_dont_know
    'I dont know this person 😔'
  end

  def first_suggestion(celebrity)
    "Did you mean #{celebrity['name']}?"
  end

  def suggestion(celebrity)
    "So may be  #{celebrity['name']}?"
  end

  def out_of_suggestions
    'I dont know then 😔'
  end

  def help
    "Try 'yes', 'no' or 'stop'"
  end

  def ok
    '👌'
  end
end
