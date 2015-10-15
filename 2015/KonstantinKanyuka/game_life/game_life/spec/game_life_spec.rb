require_relative '../lib/game_life'

RSpec.describe GameOfLife do
  gof = GameOfLife.new(4, 4)
  gof.field = [
    [1, 0, 1, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 1],
    [1, 1, 0, 1]
  ]
  it "number of neigbours" do
    expect(gof.neighbors(0, 2)).to eq(3)
    expect(gof.neighbors(3, 1)).to eq(4)
    expect(gof.neighbors(1, 3)).to eq(4)
  end

  it "apply rules to cell" do
    expect(gof.rules(0, 2)).to eq(1)
    expect(gof.rules(3, 1)).to eq(0)
    expect(gof.rules(1, 3)).to eq(0)
  end

  it "next step" do
    gof.field = [
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 0, 0]
    ]    
    res = [
      [0, 0, 0, 0],
      [1, 1, 1, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ]
    temp = gof.field
    gof.step
    expect(gof.field).to eq(res)
    gof.step
    expect(gof.field).to eq(temp)
  end

end
