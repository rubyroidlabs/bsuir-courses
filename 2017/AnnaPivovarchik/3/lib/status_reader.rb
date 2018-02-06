require_relative 'parser'
require 'pry'
# class for detect coming out
class StatusReader
  def initialize
    @information = File.read('infofile').split("\n")
  end

  def comes_out?(name)
    @information.include?(name)
  end
end
