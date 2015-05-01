module Validators
  OPTIONS = ['<', '>', '<=', '>=', '~>']

  class NameValidator
    def self.validate_name(name, found_exact_name)
      unless found_exact_name && name == found_exact_name
        puts 'Gem with this name was not found'
        return false
      end
      true
    end
  end

  class VersionValidator
    def self.get_versions(name)
      gem_url = GEM_URL + name
      gem_page = Nokogiri::HTML(RestClient.get(gem_url))
      versions = gem_page.css(VERSION_WRAP_NODE).css(VERSION_ITEM_NODE).map { |x| x.text }
      versions
    end

    def self.validate_parsed_version(version_in_number, parsed_options)
      version_fit = true
      parsed_options.each do |parsed_option|
        diff = version_in_number - parsed_option[1]
        case OPTIONS[parsed_option[0]]
        when '<'
          if diff >= 0
            version_fit = false
            break
          end
        when '>'
          if diff <= 0
            version_fit = false
            break
          end
        when '>='
          if diff < 0
            version_fit = false
            break
          end
        when '<='
          if diff > 0
            version_fit = false
            break
          end
        when '~>'
          if diff < 0 || diff / 10 > 1
            version_fit = false
            break
          end
        end
      end
      version_fit
    end

    def self.validate_versions(versions_in_numbers, parsed_options)
      fit_versions, other_versions = [], []
      versions_in_numbers_count = versions_in_numbers.count
      (0...versions_in_numbers_count).each do |i|
        version_fit = validate_parsed_version(versions_in_numbers[i], parsed_options)
        if version_fit
          fit_versions.push(i)
        else
          other_versions.push(i)
        end
      end
      return fit_versions, other_versions
    end
  end
end
