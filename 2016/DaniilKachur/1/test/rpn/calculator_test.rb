require 'rspec'
require './lib/rpn'

def result_from
  RPN::Calculator.solve(yield.tr(' ', "\n"))
end

describe RPN::Calculator do
  it '+' do
    expect(result_from { '12 2 +' }).to eq(14)
  end
  it '+ with float' do
    expect(result_from { '12.5 2 +' }).to eq(14.5)
  end
  it '+ with negative' do
    expect(result_from { '12 -2 +' }).to eq(10)
  end
  it '-' do
    expect(result_from { '12 2 -' }).to eq(10)
  end
  it '*' do
    expect(result_from { '12 2 *' }).to eq(24)
  end
  it '/' do
    expect(result_from { '12 2 /' }).to eq(6)
  end
  it '/ float result' do
    expect(result_from { '12 10 /' }).to eq(1.2)
  end
  it '!' do
    expect(result_from { '93 3 !' }).to eq(80)
  end
  it '! with float' do
    expect(result_from { '2.5 1 !' }).to eq(2)
    expect(result_from { '0.15625 1 !' }).to eq(0.125)
  end
end
