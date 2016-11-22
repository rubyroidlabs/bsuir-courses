require "rspec"
require_relative "commands.rb"
require_relative "logic.rb"

RSpec.describe Base do
  it "should check if 2nd date bigger then today date" do
    d2 = Date.new(2020, 12, 15)
    expect(countdown(Date.today, d2)).to eq true
  end

  it "should check if 2nd date bigger then today date" do
    d1 = Date.new(2016, 10, 15)
    d2 = Date.new(2015, 12, 15)
    expect(countdown(d1, d2)).to eq false
  end

  it "should check if parameter is correct calendar date" do
    expect(v_date?("2015-1-2")).to eq true
  end

  it "should check if parameter is correct calendar date" do
    expect(v_date?("2015-13-2")).to eq false
  end

  it "shoul be 5" do
    @eta = 5
    @sum_of_days = 10
    expect(taskcalc(4)).to eq 2
  end
end
