class Parse
  def get_page_doc
    main_page = Curl::Easy.perform(MAIN_URL)
    @page_doc = Nokogiri::HTML(main_page.body)
  end

  def get_list
    names = @page_doc.xpath(NAME_XPATH).map(&:text)
    descs = @page_doc.xpath(DESC_XPATH).map do |item|
      item.text.split(' - ').first
    end
    puts 'Data was successfully downloaded...'
    Hash[names.zip(descs)].to_a
  end
end
