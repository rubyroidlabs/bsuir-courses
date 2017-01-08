# Add method that converts hash keys to symbols
class Hash
  def keys_to_syms
    Hash[map { |k, v| [k.to_sym, v.is_a?(Hash) ? v.keys_to_syms : v] }]
  end
end
