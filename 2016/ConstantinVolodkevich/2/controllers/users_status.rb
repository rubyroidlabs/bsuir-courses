class Users_Status
  attr_accessor :steps_semester, :steps_subject, :steps_submit, :steps_reset
  def initialize
    @steps_semester = {'set_ending_date' => false, 'got_ending_date' => false }
    @steps_subject = {'save_subject' => false, 'save_labs' => false, 'relevant_subj' => ''}
    @steps_submit = {'check_subject' => false, 'submit_lab' => false, 'relevant_subj' => ''}
    @steps_reset = {'user_is_sure' => false}
  end
end
