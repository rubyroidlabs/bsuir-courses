require_relative 'rapper'

class Restorator
  attr_accessor :text, :title, :first_mc, :second_mc, :rapper, :skip

  def initialize(text, title, rapper = nil)
    @text = text.downcase
    @title = title.downcase
    @rapper = rapper
    @skip = false
    names
  end

  def names
    vs_index = @title.index(' vs')
    @first_mc = Rapper.new(@title[0..vs_index - 1])
    @title.slice!(0..vs_index + 3)
    if @title[0].eql? ' '
      @title.slice!(0)
    end
    unless @title.index(' (').nil?
      @title.slice!(@title.index(' (')..@title.size - 1)
    end
    @second_mc = Rapper.new(@title)
    unless @rapper.nil?
      if @first_mc.name.eql? @rapper.name
        @first_mc = @rapper
      else
        @second_mc = @rapper
      end
    end
    lyrics
  end

  def lyrics
    if ENV['CRITERIA'].nil?
      criteria = /\w/
    else
      criteria = ENV['CRITERIA']
    end
    1.upto(3) do |item|
      begin
        @text.slice!("[round #{item}: #{@first_mc.name}]")
        index = @text.index("[round #{item}: #{@second_mc.name}]")
        @first_mc.count += @text.slice!(0..index - 1).scan(criteria).count
        @text.slice!("[round #{item}: #{@second_mc.name}]")
        index2 = @text.index("[round #{item + 1}: #{first_mc.name}]")
        if index2.nil?
          index2 = @text.size
        end
        @second_mc.count += @text.slice!(0..index2 - 1).scan(criteria).count
      rescue NoMethodError
        @skip = true
      end
    end
    result
  end

  def result
    if @skip
      puts 'Can\'t process this battle. Invalid text format.'
    else
      puts "#{first_mc.name.capitalize} - #{first_mc.count}"
      puts "#{second_mc.name.capitalize} - #{second_mc.count}"
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
  end

  def statistics
    print "\n#{@rapper.name.capitalize} won "
    print "#{@rapper.won} times and lost #{@rapper.lost} times.\n"
  end
end
