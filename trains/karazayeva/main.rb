# TRAIN
require'./train'

train = Train.new

loop do
  3.times do
    10.times do
      train.move_right
    end
    train.move_your_eyes
    14.times do
      train.move_right
    end
    3.times do
      train.wink_your_eyes
      train.raise_your_hands
    end
  end

  3.times do
    10.times do
      train.move_left
    end
    train.move_your_eyes
    14.times do
      train.move_left
    end
    3.times do
      train.wink_your_eyes
      train.raise_your_hands
    end
  end
end



 


