require './commands/text_react'
require './models/user'

class Status_C < Text_React

  def execute_command(user)
    p user.status
    change_status(user) unless user.hash_of_subjects.empty?
    p user.status
    user
  end

  def change_status(user)
    a = "You need to pass:\n"
    count_all_labs = 0
    count_labs_to_pass = 0
    user.hash_of_subjects.each do |subj_name, subj|
      a += "#{subj_name} - "
      count_all_labs += subj.hash_of_labs.size
      subj.hash_of_labs.each do |lab_name, lab|
        unless lab.status
          a += "#{lab_name} "
          count_labs_to_pass += 1
        end
      end
      a += "\n"
    end
    z = "You got #{count_labs_to_pass} of #{count_all_labs} to pass. Hold on! Life will not last forever;)"
    user.status = a + z
    user
  end


end
