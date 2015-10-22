require 'colorize'

class Printer
  def pretty_print(arr, new_arr)
    arr.each do |version_str|
      new_arr.include?(version_str) ? (puts version_str.colorize(:red)) : (puts version_str)
    end
  rescue => e
    abort(e.inspect)
  end
end
