require "life"

RSpec.describe Life::Board do
  describe "#initialize" do
    it "takes width and height as arguments" do
      Life::Board.new(4, 5)
    end

    it "initializes the board with false" do
      expect(Life::Board.new(3, 3).to_a).to eq([
        [false, false, false],
        [false, false, false],
        [false, false, false]
      ])
    end

    it "checks that width and height are bigger than 3" do
      expect { Life::Board.new(2, 2) }.to raise_exception(ArgumentError)
    end
  end

  describe " #width, #height" do
    it "equal the provided dimensions" do
      board = Life::Board.new(20, 10)
      expect(board.width).to eq(20)
      expect(board.height).to eq(10)
    end
  end

  describe " #[], #[]=" do
    it "can be used to access cells inside dimensions" do
      board = Life::Board.new(5, 4)
      board[2, 3] = true
      expect(board[2, 3]).to eq(true)
      expect(board[3, 3]).to eq(false)
    end

    it "can be used to access cells outside dimensions by wrapping indexes" do
      board = Life::Board.new(5, 4)
      board[5, 4] = true
      expect(board[5, 4]).to eq(true)
      expect(board[0, 0]).to eq(true)
      expect(board[3, 3]).to eq(false)
      expect(board[8, 7]).to eq(false)
    end
  end

  describe "#to_a" do
    it "returns a representation of the board as an array of arrays" do
      board = Life::Board.new(3, 3)
      board[1, 1] = true
      arr = board.to_a
      expect(arr).to eq([
        [false, false, false],
        [false, true, false],
        [false, false, false]
      ])

      arr[0][0] = true
      expect(board[0, 0]).to eq(false)
    end
  end

  describe "#update_from_array" do
    it "sets the cells to the ones taken from an array of arrays" do
      arr = [
        [false, true, false],
        [false, false, false],
        [false, false, false]
      ]
      board = Life::Board.new(3, 3)
      board.update_from_array(arr)
      expect(board.to_a).to eq([
        [false, true, false],
        [false, false, false],
        [false, false, false]
      ])
    end
  end

  describe "#clone" do
    it "Correctly clones" do
      board = Life::Board.from_array([
        [true, false, true, true],
        [false, true, false, false],
        [true, true, true, true],
        [true, false, false, false]
      ])
      board2 = board.clone()
      board[0, 0] = false
      expect(board2[0, 0]).to eq(true)
    end
  end

  describe "#tick" do
    it "Changes the board to the next state" do
      board = Life::Board.from_array([
        [true, false, true, true],
        [false, true, false, false],
        [false, false, true, true],
        [true, false, false, false]
      ])
      board.tick()
      expect(board.to_a).to eq([
        [true, false, true, true],
        [false, true, false, false],
        [true, true, true, true],
        [true, false, false, false]
      ])
    end
  end

  describe "#each" do
    it "Enumerates cells with their coordinates" do
      board = Life::Board.from_array([
        [true, false, true],
        [false, true, false],
        [false, false, true],
      ])

      args = []
      board.each do |x, y, alive|
        args << [x, y, alive]
      end

      expect(args).to eq([
        [0, 0, true],
        [1, 0, false],
        [2, 0, true],
        [0, 1, false],
        [1, 1, true],
        [2, 1, false],
        [0, 2, false],
        [1, 2, false],
        [2, 2, true]
      ])
    end
  end

  describe "#each_neighbor" do
    it "Enumerates cell's neigbors with their coordinates" do
      board = Life::Board.from_array([
        [true, false, true, false],
        [false, true, false, false],
        [false, false, true, false],
        [false, false, true, false]
      ])

      args = []
      board.each_neighbor(1, 1) do |x, y, alive|
        args << [x, y, alive]
      end

      expect(args).to eq([
        [0, 0, true],
        [1, 0, false],
        [2, 0, true],
        [0, 1, false],
        [2, 1, false],
        [0, 2, false],
        [1, 2, false],
        [2, 2, true]
      ])
    end
  end

  describe "#count_neighbors" do
    it "counts the number of trues around given coordinates" do
      board = Life::Board.from_array([
        [true, false, true, true],
        [false, true, false, false],
        [false, false, true, true],
        [true, false, false, false]
      ])

      expect(board.count_neighbors(1, 1)).to eq(3)
      expect(board.count_neighbors(0, 0)).to eq(3)
      expect(board.count_neighbors(2, 2)).to eq(2)
      expect(board.count_neighbors(1, 3)).to eq(4)
    end
  end

  describe ".from_array" do
    it "returns a board with cells taken from an array of arrays" do
      arr = [
        [false, true, false],
        [false, false, false],
        [false, false, false]
      ]
      board = Life::Board.from_array(arr)
      expect(board.to_a).to eq([
        [false, true, false],
        [false, false, false],
        [false, false, false]
      ])
    end
  end

  describe ".from_text" do
    it "returns a board with cells taken from an array of arrays" do
      text = [
          " # ",
          "## ",
          "  #"
      ].join("\n")

      board = Life::Board.from_text(text)
      expect(board.to_a).to eq([
        [false, true, false],
        [true, true, false],
        [false, false, true]
      ])
    end
  end
end
