require 'mechanize'
require 'pry'
require_relative 'simple_fuzzy_match'
require_relative 'translate'

class Parser
  def initialize
    @coming_outs = {}
  end

  def get_coming_outs
    a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
    url1 = 'http://www.imdb.com/list/ls072706884/?start=1&view=detail&sort=lis'\
           'torian:asc&scb=0.9953551686721389'
    url2 = 'https://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D0%BC%D0%B8%D0%BD%D0%B3'\
           '-%D0%B0%D1%83%D1%82#.D0.9A.D0.B0.D0.BC.D0.B8.D0.BD.D0.B3-.D0.B0.D1'\
           '.83.D1.82_.D0.B7.D0.BD.D0.B0.D0.BC.D0.B5.D0.BD.D0.B8.D1.82.D0.BE.D'\
           '1.81.D1.82.D0.B5.D0.B9_.D0.B7.D0.B0_.D0.BF.D1.80.D0.B5.D0.B4.D0.B5'\
           '.D0.BB.D0.B0.D0.BC.D0.B8_.D0.A0.D0.BE.D1.81.D1.81.D0.B8.D0.B8'
    url3 = 'https://marieclaire.ua/celebrity/samye-gromkie-kaming-auty-xxi-sto'\
           'letiya/'
    url4 = 'https://ua.tribuna.com/tribuna/blogs/gaysport/768277.html'
    parser_one(a.get(url1))
    parser_two(a.get(url2))
    parser_tree(a.get(url3))
    parser_four(a.get(url4))
    @coming_outs
  end

  private

  # Exclude repetition of a record
  # Overwrite data in case of a match
  def add_to_coming_outs(name, text)
    @coming_outs[name] = text
    @coming_outs.each_key do |key|
      next if key == name
      if simple_fuzzy_match(key, name)
        @coming_outs[key] = text
        @coming_outs.delete(name)
      end
    end
  end

  def parser_one(page)
    page.css('.info b a').each do |x|
      @coming_outs[x.text] = nil
    end
  end

  def parser_two(page)
    page.css('.mw-parser-output ul li').each do |li|
      parser_two_get_info(li)
    end
  end

  def parser_two_get_info(li)
    li.children.each do |a|
      a.children.each do |x|
        next unless a.name == 'a' && x.name == 'text' && x.text.index(/ [А-Я]/)
        name = Translate.new.translate(x.text)
        text = li.text.split(/\[..\]|\[...\]/).join
        add_to_coming_outs(name, text)
        return nil
      end
    end
  end

  def parser_tree(page)
    hash_coming_outs = parser_tree_get_info(page)
    hash_coming_outs.each do |name, text|
      add_to_coming_outs(name, text)
    end
  end

  def parser_tree_get_info(page)
    hash_coming_outs = {}
    name = nil
    page.css('.text-content').children.each do |element|
      if element.name == 'h3'
        name = Translate.new.translate(element.text)
        hash_coming_outs[name] = ''
      elsif element.name == 'p' || element.name == 'blockquote'
        if element.child.name == 'text' && name
          hash_coming_outs[name] << ' ' << element.text
        end
      end
    end
    hash_coming_outs
  end

  def parser_four(page)
    list_name = parser_four_get_name(page)
    list_text = parser_four_get_text(page)
    list_name.each_index do |i|
      add_to_coming_outs(Translate.new.translate(list_name[i]), list_text[i])
    end
  end

  def parser_four_get_name(page)
    list_name = []
    page.css('.material-item__content h3').each do |x|
      human = x.text.split(/[(«]/)[0]
      list_name << human.strip
    end
    list_name.pop
    list_name
  end

  def parser_four_get_text(page)
    list_text = []
    str_class = ''
    page.css('.material-item__content p').each do |x|
      next if x.child.name == 'strong'
      if x.child.name == 'text'
        str_class << x.text << ' '
      else
        list_text << str_class.strip
        str_class = ''
      end
    end
    list_text
  end
end
