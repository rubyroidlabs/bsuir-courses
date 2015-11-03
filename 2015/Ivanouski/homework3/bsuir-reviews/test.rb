#!/usr/bin/env ruby

require 'yaml'
require 'colorize'


@comments = ["Пидр плохой",
           "Никто лох ненавижу",
           "Весьма милый 1",
           "чотка метка расставляем хуй",
           "11222 22 3",
           "Он хороший человек",
           "очень хорош"]

@keywords = YAML.load_file('./keywords.yml')
#@keywords['positive'].each_index
#puts keywords.inspect
#puts keywords['negative']
#puts @keywords['positive']
@comments.each do |comment|
  @pos = @neg = 0
  @keywords['positive'].each do |keyword|
    @pos += (comment).scan(keyword).count
  end
  @keywords['negative'].each do |keyword|
    @neg += (comment).scan(keyword).count
  end
    p rating = (@pos - @neg)
    if rating > 0
      puts comment.green
    elsif rating < 0
      puts comment.red
    else
        puts comment
    end
end
