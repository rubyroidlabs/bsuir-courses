require_relative 'rapper'

class Restorator
  attr_accessor :text, :title, :first_mc, :second_mc, :rapper, :skip
  FIRST_ROUND = 1
  LAST_ROUND = 3

  def initialize(text, title, criteria, rapper = nil)
    @text = text.downcase
    @title = title.downcase
    @rapper = rapper
    @criteria = criteria
    @skip = false
  end

  def names
    rappers = if @title.index(' vs.').nil?
                @title.split(' vs ')
              else
                @title.split(' vs. ')
              end
    unless rappers.last.index(' (').nil?
      rappers.last.slice!(rappers.last.index(' (')...rappers.last.size)
    end
    rappers
  end

  def create_rappers
    rappers = names
    @first_mc = Rapper.new(rappers.first)
    @second_mc = Rapper.new(rappers.last)
    unless @rapper.nil?
      if @first_mc.name.eql? @rapper.name
        @first_mc = @rapper
      else
        @second_mc = @rapper
      end
    end
    self
  end

  def lyrics
    FIRST_ROUND.upto(LAST_ROUND) do |item|
      begin
        @text.slice!("[round #{item}: #{@first_mc.name}]")
        index = @text.index("[round #{item}: #{@second_mc.name}]")
        @first_mc.count += @text.slice!(0..index - 1).scan(@criteria).count
        @text.slice!("[round #{item}: #{@second_mc.name}]")
        index2 = @text.index("[round #{item + 1}: #{first_mc.name}]")
        if index2.nil?
          index2 = @text.size
        end
        @second_mc.count += @text.slice!(0..index2 - 1).scan(@criteria).count
      rescue NoMethodError
        @skip = true
      end
    end
    self
  end

  def result
    if @skip
      puts 'Can\'t process this battle. Invalid text format.'
    else
      info(@first_mc)
      info(@second_mc)
      if @first_mc.count > @second_mc.count
        @first_mc.won += 1
        @second_mc.lost += 1
        puts "#{first_mc.name.capitalize} wins!"
      else
        @second_mc.won += 1
        @first_mc.lost += 1
        puts "#{second_mc.name.capitalize} wins!"
      end
    end
    @first_mc.count = 0
    @second_mc.count = 0
    self
  end

  def info(mc)
    puts "#{mc.name.capitalize} - #{mc.count}"
  end

  def statistics
    print "\n#{@rapper.name.capitalize} won "
    print "#{@rapper.won} times and lost #{@rapper.lost} times.\n"
  end
end
