Dir['../lib/*.rb'].each { |f| require_relative f }

MATRIX_SIZE = 30

Life.new(MATRIX_SIZE).go
