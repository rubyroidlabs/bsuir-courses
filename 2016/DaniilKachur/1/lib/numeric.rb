require_relative "numeric/new_operator"

# adding ! operator
class Numeric
  include NewOperator
end
