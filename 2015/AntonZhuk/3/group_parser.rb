require 'mixlib/cli'

class GroupParser
  include Mixlib::CLI

  option :help,
         :short => "-h",
         :long => "--help",
         :description => "Take this example of input: 'bsuir-reviews.rb 322401'",
         :on => :head,
         :boolean => true,
         :show_options => true,
         :exit => 0
end
