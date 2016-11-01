require "../commands/text_react"
class Start_C < Text_React
  @@greetings = "Konichiwa! I'm your personal assistant created by Constantin Volodkevich.
Here is some sample commands to run:
/start - Greetings text and commands list
/semester - set a date for the end of semester/tracks the remaining time befor the end of semester
/reset_semester - reset a date for the end of semester
/subject - set new subject and number of labs you need to pass
/submit - sumit specific lab
/status - list of labs you need to pass
/reset - reset all user data"

  def execute_command()
   @@greetings
  end

end