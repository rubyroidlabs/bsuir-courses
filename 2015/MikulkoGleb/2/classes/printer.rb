require 'colorize'

class Printer
  def pretty_print(arr, new_arr)
    arr.each do |version_str|
      if new_arr.include?(version_str)
        (puts version_str.colorize(:red))
      else (puts version_str)
      end
    end
  rescue => e
    abort(e.inspect)
  end
end
