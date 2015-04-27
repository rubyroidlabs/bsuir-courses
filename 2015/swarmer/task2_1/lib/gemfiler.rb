require 'optparse'
require 'colorize'
require 'gems'

module Gemfiler
  class FetchError < StandardError; end
  class MatchError < StandardError; end
end

require 'gemfiler/ui'
require 'gemfiler/version_matcher'
require 'gemfiler/version_fetcher'
