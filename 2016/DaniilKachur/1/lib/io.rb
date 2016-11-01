require_relative "io/immediately_io"

# adding immediately output
class IO
  include ImmediatelyIO
end
