require 'spec_helper'
require_relative '../lib/life'

describe Life do
  it 'instance is class Life' do
    life = Life.new
    life.class.to_s.should == 'Life'
  end

  it 'correct default sizes' do
    life = Life.new
    life.matrix_h.should == 10 && life.matrix_w.should == life.matrix_h
  end

  it 'matrix is square' do
    life = Life.new(20)
    life.matrix_h.should == life.matrix_w
  end

  it 'can change params' do
    life = Life.new
    life.matrix_h = 100
    life.matrix_h.should != 100
  end

  it '== 42 ?' do
    Life.new.should == 42
  end

end