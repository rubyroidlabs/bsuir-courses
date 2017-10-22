require_relative('user')
require 'mechanize'
require 'date'
require 'json'

class Fight
  attr_accessor :first_user, :second_user, :winner, :battle

  def start_figth(name, criteria)
    i = name.downcase.sub(' ', '-')
    page_list = found_page_list(i)
    user = User.new(name, 'nil')
    page_list.each do |item|
      @battle = item.text.split(' ').join(' ').delete('["').split(' (').shift
      @battle = @battle.sub(' vs ', '-1')
      @battle = @battle.sub(' Vs ', '-1')
      @battle = @battle.sub(' vs. ', '-1')
      name2 = @battle.split('-1').last.to_s
      if name2.include?(name)
        name2 = @battle.split('-1').shift
      end
      @battle = @battle.sub('-1', ' vs ') + ' - ' + item.href
      text = item.click.search('.lyrics p').text.to_s
      text_parse(text, name, name2, criteria, user)
    end
    print user.name + ' wins ' + user.wins.to_s + ' times, loses '
    i = page_list.length - user.wins
    puts i.to_s + ' times.'
  end

  def start_figths(name, criteria)
    page_list = found_page_list(name)
    page_list.each do |item|
      @battle = item.text.split(' ').join(' ').delete('["').split(' (').shift
      @battle = @battle.sub(' vs ', '-1')
      @battle = @battle.sub(' Vs ', '-1')
      @battle = @battle.sub(' vs. ', '-1')
      name1 = @battle.split('-1').shift
      name2 = @battle.split('-1').last.to_s
      @battle = @battle.sub('-1', ' vs ') + ' - ' + item.href
      text = item.click.search('.lyrics p').text.to_s
      text_parse_n(text, name1, name2, criteria)
    end
  end

  def text_parse_n(text, first_name, second_name, criteria)
    text1 = ''
    text2 = ''
    authors_of_rounds = text.to_s.scan(/\[[^?\]]+\]/)
    text.to_s.split(/\[[^?\]]+\]/).each do |item|
      if item == ''
        next
      else
        part = authors_of_rounds.shift.to_s
        if part.include?(first_name)
          text1 += item
        elsif part.include?(second_name)
          text2 += item
        end
      end
    end
    puts @battle
    user1 = User.new(first_name, text1)
    user1.found_criteria(criteria)
    user2 = User.new(second_name, text2)
    user2.found_criteria(criteria)
    if user1.points >= user2.points
      user1.wins += 1
      puts user1.name + ' WINS!'
    elsif user2.points > user1.points
      user2.wins += 1
      puts user2.name + ' WINS!'
    end
    puts '=====' * 20
  end

  def found_page_list(name)
    agent = Mechanize.new
    page = agent.get 'https://genius.com/artists/songs?for_artist_page=117146'
    if name.nil?
      name = 'lyrics'
    end
    review_page = page.links_with(href: /#{name}/)
    hidden_page = page.links_with(href: /pagination=true/)
    hidden_page.delete(hidden_page.last)
    hidden_page.each do |item|
      review_page += item.click.links_with(href: /#{name}/)
    end
    review_page
  end

  def text_parse(text, first_name, second_name, criteria, user1)
    text1 = ''
    text2 = ''
    authors_of_rounds = text.to_s.scan(/\[[^?\]]+\]/)
    text.to_s.split(/\[[^?\]]+\]/).each do |item|
      if item == ''
        next
      else
        part = authors_of_rounds.shift.to_s
        if part.include?(first_name)
          text1 += item
        else
          text2 += item
        end
      end
    end
    puts @battle
    user1.text = text1
    user1.found_criteria(criteria)
    user2 = User.new(second_name, text2)
    user2.found_criteria(criteria)
    if user1.points >= user2.points
      user1.wins += 1
      puts user1.name + ' WINS!'
    elsif user2.points > user1.points
      user2.wins += 1
      puts user2.name + ' WINS!'
    end
    puts '=====' * 20
  end
end
