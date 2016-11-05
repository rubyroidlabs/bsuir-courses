class Users_Status
  attr_accessor :steps_semester, :steps_subject, :steps_submit, :steps_reset, :steps_reminder
  def initialize
    @steps_semester = {'set_ending_date' => false, 'got_ending_date' => false }
    @steps_subject = {'save_subject' => false, 'save_labs' => false, 'relevant_subj' => ''}
    @steps_submit = {'check_subject' => false, 'submit_lab' => false, 'relevant_subj' => ''}
    @steps_reset = {'user_is_sure' => false}
    @steps_reminder = {'user_wanna_remind' => false, 'remind_on' => false}
  end
end

user_status = Users_Status.new
p user_status