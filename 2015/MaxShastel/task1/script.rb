require './animation.rb'

train =
	[
        '      ____                           ',
        ' _||__|  |  ______   ______   ______ ',
        '(        | |      | |      | |      |',
        '/-()---() ~ ()--() ~ ()--() ~ ()--() '
	]

a = Animation.new(train)
a.paint
