require 'rspec'
require'./rpn_calculator'

def expression_of(line)
  line.tr(' ', "\n")
end

describe RPNCalculator do
  it '+' do
    expect(RPNCalculator.calculate(expression_of('12 2 +'))).to eq(14)
  end
  it '+ with float' do
    expect(RPNCalculator.calculate(expression_of('12.5 2 +'))).to eq(14.5)
  end
  it '+ with negative' do
    expect(RPNCalculator.calculate(expression_of('12 -2 +'))).to eq(10)
  end
  it '-' do
    expect(RPNCalculator.calculate(expression_of('12 2 -'))).to eq(10)
  end
  it '*' do
    expect(RPNCalculator.calculate(expression_of('12 2 *'))).to eq(24)
  end
  it '/' do
    expect(RPNCalculator.calculate(expression_of('12 2 /'))).to eq(6)
  end
  it '/ float result' do
    expect(RPNCalculator.calculate(expression_of('12 10 /'))).to eq(1.2)
  end
  it '!' do
    expect(RPNCalculator.calculate(expression_of('93 3 !'))).to eq(80)
  end
  it '! with float' do
    expect(RPNCalculator.calculate(expression_of('2.5 1 !'))).to eq(2)
    expect(RPNCalculator.calculate(expression_of('0.15625 1 !'))).to eq(0.125)
  end
end
