Dir['../lib/*.rb'].each { |f| require_relative(f) }
require 'colorize'
begin
  tf = TeacherListFetcher.new(ARGV[0])
  list = tf.get_list
  cf = CommentFetcher.new

  list.each do |o|
    puts o.blue
    puts '====='
    puts cf.get_comments(o)
  end

  all_comments = Array.new
end
