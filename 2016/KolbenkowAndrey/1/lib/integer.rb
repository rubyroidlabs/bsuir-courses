require 'colorize'
class Integer
  define_method(:!) do |arg|
    bin_number = to_s(2).reverse
    count_of_bits_for_null = arg
    count_of_bits_for_null = bin_number.size if count_of_bits_for_null > bin_number.size

    0.upto(bin_number.size - 1) do |bit|
      if bin_number[bit] == '1'
        bin_number[bit] = '0'
        count_of_bits_for_null -= 1
      end
      break if count_of_bits_for_null == 0
    end
    puts "!: Source number: #{self} => #{to_s(2)}".blue
    puts "!: Bit's to nil: => #{arg}".cyan
    puts "!: Output number: #{bin_number.reverse.to_i(2)} => #{bin_number.reverse}".green
    bin_number.reverse.to_i(2)
  end
end
