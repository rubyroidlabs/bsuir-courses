require 'rspec'
require_relative "../lib/user.rb"

RSpec.describe User, "database_test" do
  user = User.new
  user.id = '203963435'
  it "should be waiting" do
    expect(user.get_command).to eq('waiting')
  end
  it "should be false" do
    user.id = '23124132'
    expect(user.not_exist?).to eq(true)
  end
  it "should be true" do
    user.id = '203963435'
    user.set_executed('true')
    expect(user.dead_line_executed?).to eq(true)
  end
  it "should be false" do
    user.id = '203963435'
    user.set_executed('false')
    expect(user.dead_line_executed?).to eq(false)
  end
  it "should be trololo" do
   user.set_submit_subject('trololo')
   expect(user.get_submit_subject).to eq ('trololo')
  end
end
