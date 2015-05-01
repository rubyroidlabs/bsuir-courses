module Parsers
  OPTIONS = ['<', '>', '<=', '>=', '~>']

  class VersionParser
    def self.parse_version(version)
      version_numbers = version.split('.').map { |x| x.to_i }
      if version_numbers.include? nil
        puts 'Invalid version'
        return nil
      end

      version_numbers_count = version_numbers.count
      version_in_number = 0
      (0...version_numbers_count).each do |i|
        version_in_number += version_numbers[version_numbers_count - i - 1] * 10**i
      end
      version_in_number
    end

    def self.parse_versions(versions)
      parsed_versions = []
      versions.each do |version|
        parsed_version = parse_version(version)
        unless parsed_version
          return nil
        end
        parsed_versions.push(parsed_version)
      end
      parsed_versions
    end
  end

  class OptionParser
    def self.parse_option(option)
      option = option.delete(' ')
      option_index = [OPTIONS.index(option[0..1]), OPTIONS.index(option[0])].compact[0]
      unless option_index
        puts 'Invalid option. Options can be ' + OPTIONS.to_s + ' version'
        return nil
      end

      option_version = option[1..-1]
      if option_index > 1
        option_version = option[2..-1]
      end
      option_version_in_number = VersionParser.parse_version(option_version)
      return option_index, option_version_in_number
    end

    def self.parse_options(options)
      parsed_options = []
      options.each do |option|
        parsed_option = parse_option(option)
        unless parsed_option
          return nil
        end
        parsed_options.push(parsed_option)
      end
      parsed_options
    end
  end
end
