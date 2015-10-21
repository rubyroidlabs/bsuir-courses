class Checker
  def check_name_version(name, conditions)
  text_string = ''
    name_pattern = /\w/
    version_pattern = /((~>)|(>=)|(>)|(<=)|(<)) \d\.\d(\.\d)?.*/
    if !(name_pattern.match(name))
      text_string = 'Wrong gem name!'
    end
    conditions.each do |condition|
      if !(version_pattern.match(condition))
        text_string = 'Wrong version!'
      end
    end
    text_string
  end
end
