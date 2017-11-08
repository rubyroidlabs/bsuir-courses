# Usefull methods for Array class
module OddAndEven
  def odd_values
    values_at(* each_index.select(&:odd?))
  end

  def even_values
    values_at(* each_index.select(&:even?))
  end
end
