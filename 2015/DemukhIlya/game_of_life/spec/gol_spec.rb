require 'gol'

RSpec.describe GameOfLife do

  context 'passing field with different number of rows and columns' do
    it 'raises ArgumentError' do
      expect { GameOfLife.new(2, 2, [[0, 0, 1],
                                     [1, 0, 0]]) }.to raise_error(ArgumentError)
    end
  end

  context 'passing field with equal number of rows and columns' do
    it 'succeeds' do
      expect(GameOfLife.new(2, 2, [[0, 1],
                                   [1, 0]])).to be_an_instance_of(GameOfLife)
    end
  end

  it 'returns next state of the game' do
    game = GameOfLife.new(4, 4, [[1, 0, 0, 1],
                                 [0, 1, 1, 1],
                                 [1, 0, 1, 0],
                                 [1, 1, 0, 0]])

    expect(game.next_state).to eql([[0, 0, 0, 0],
                                    [0, 0, 0, 0],
                                    [0, 0, 0, 0],
                                    [0, 0, 1, 0]])
  end
end
