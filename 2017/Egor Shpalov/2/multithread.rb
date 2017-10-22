class Multithread
  def self.get_pagination_pages(pagination, battles)
    threads = []
    pagination.count.times do |n|
      threads << Thread.new(pagination[n]) do |link|
        battles << Parse.get_battle_page(link)
      end
    end
    threads.each(&:join)
  end

  def self.threads_iter(group, threads, total_links, total_results)
    10.times do |n|
      unless group[n].nil?
        threads << Thread.new(group[n]) do |link|
          put_info(total_results, total_links, link)
        end
      end
    end
  end

  def self.multithread_iter(battles, total_links, total_results)
    battles.each_slice(10) do |group|
      threads = []
      threads_iter(group, threads, total_links, total_results)
      threads.each(&:join)
    end
  end

  def self.simple_iter(battles, total_links, total_results)
    battles.each do |link|
      if link.text.include? ENV['NAME'].to_s
        put_info(total_results, total_links, link)
      end
    end
  end

  def self.multiparse(battles)
    total_results = []
    total_links = []
    if ENV['NAME'].nil?
      multithread_iter(battles, total_links, total_results)
    else
      simple_iter(battles, total_links, total_results)
    end
    [total_results, total_links]
  end

  def self.put_info(total_results, total_links, link)
    result = Parse.get_result(link)
    total_results << result
    total_links << link.href
    puts link.href
  end
end
