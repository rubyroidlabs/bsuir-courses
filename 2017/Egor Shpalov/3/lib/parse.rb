class Parse
  def get_page_doc(main_url)
    main_page = Curl::Easy.perform(main_url)
    @page_doc = Nokogiri::HTML(main_page.body)
    puts "Source: #{main_url}"
  end

  def get_list(name_xpath, desc_xpath)
    names = @page_doc.xpath(name_xpath).map(&:text)
    descs = @page_doc.xpath(desc_xpath).map do |item|
      item.text.split(' - ').first.strip
    end
    Hash[names.zip(descs)].to_a
  end
end
