class Battle
  attr_writer :criteria

  def initialize(title, url, text)
    @title = title
    @url = url
    @text = text
  end

  def result
    run unless @result
    @result
  end

  def winner
    run unless @winner
    @winner
  end

  private

  def run
    opponent_names = parse_title(@title)
    # create opponent hash
    opponents = opponent_names.map { |name| { name: name, text: '' } }
    good_text = remove_trash(@text)

    loop do
      # check for [raper name] block
      /\[(?<block_title>[^\[\]]+)\](?<raper_text>[^\[\]]+)(\[|$)/ =~ good_text
      if block_title
        opponents.each do |opponent|
          next unless block_title.downcase.include?(opponent[:name].downcase)
          opponent[:text] << raper_text || ''
          break
        end
        good_text = good_text.sub("[#{block_title}]#{raper_text}", '')
      end

      # check for Round 1: raper name block
      /[^\[]Round \d: (?<raper_name>[^\n]+)\n/ =~ good_text
      break unless raper_name || block_title
      if raper_name
        good_text = good_text.sub(/Round \d: #{raper_name}\n/, '')
        raper_text = good_text.split(/Round/).first
        opponents.each do |opponent|
          if raper_name.casecmp(opponent[:name]).zero?
            opponent[:text] << raper_text
            break
          end
        end
        good_text = good_text.sub(raper_text, '')
      end
    end

    # end of check for raper texts
    @result = "#{@title} - #{@url}\n"
    @criteria = /\w/ if @criteria.nil?
    opponents.each do |opponent|
      opponent[:score] = opponent[:text].scan(@criteria).size
      @result << "#{opponent[:name]} - #{opponent[:score]}\n"
    end
    winner = opponents.max_by { |opponent| opponent[:score] }
    @result << "#{winner[:name]} WINS!"
    @winner = winner[:name]
  end

  def parse_title(title)
    title = title.gsub(/\s*\([^()]*\)/, '') # remove parentheses
    opponents = title.split(/\s+vs\.?\s+/)
    # divide pairs to single opponents
    opponents = opponents.map { |couple| couple.split(' & ') }
    opponents.flatten
  end

  def remove_trash(text)
    text = text.gsub(/\[([?…]|don't|unclear|incoherent|whale's)\]/, '')
    text = text.gsub('[...]', '')
    text.gsub(/\[\*[^*]*\*\]/, '')
  end
end
