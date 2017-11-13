class BattleMc
  attr_accessor :name, :text, :flank

  def left_mc(title, result_text, flank)
    @name = title.split(/\svs\.?\s/i).first
    @text = result_text.select.with_index { |_val, index| index.even? }
    @flank = flank
  end

  def right_mc(title, result_text, flank)
    @name = title.split(/\svs\.?\s/i).last
    @text = result_text.select.with_index { |_val, index| index.odd? }
    @flank = flank
  end

  def mc_text_letters_count
    text.inject(0) do |c, w|
      c += w.length
      c
    end
  end
end
