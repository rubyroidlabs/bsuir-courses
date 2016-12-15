require 'test/unit'
require '../lib/golife'

describe GOLife, "cells and table" do

  def calc(life)
    ans = 0
    3.times do |i|
      3.times do |j|
        ans += life.field[i][j] / 10
      end
    end
    ans -= life.field[1][1] / 10
    ans
  end

  before(:each) do
    @life = GOLife.new(20, 20)
    @life.generate
    @life.recalc
  end

  it "should return true if cell changed" do
    @life.cell_changed?(0, 0) == (@life.field[0][0] != @life.temp[0][0])
  end

  it "should update cells correctly" do
    @life.temp[1][1] > 10 if calc(@life) == 2 || calc(@life) == 3
  end
end
