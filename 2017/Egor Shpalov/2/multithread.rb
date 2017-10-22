class Multithread

  def self.get_pagination_pages(pagination, battles)
    threads = []
    pagination.count.times do |n|
      threads << Thread.new(pagination[n]) do |link|
        battles << Parse.get_battle_page(link)
      end
    end 
    threads.each { |t| t.join }
  end

  def self.multiparse(battles)
    total_results = []
    total_links = []
    if ENV["NAME"].nil?
      battles.each_slice(10) do |group|
        threads = []
        10.times do |n|
          if group[n] != nil
            threads << Thread.new(group[n]) do |link|
              put_info_to_structs(total_results, total_links, link)
            end
          end
        end
        threads.each { |t| t.join }
      end
    else
      battles.each do |link|
        if link.text.include? "#{ENV['NAME']}"
          put_info_to_structs(total_results, total_links, link)
        end
      end
    end
    [total_results, total_links]
  end

  private

    def self.put_info_to_structs(total_results, total_links, link)
      result = Parse.get_result(link)
      total_results << result
      total_links << link.href
      puts link.href
    end
end
