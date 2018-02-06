require 'mechanize'

class Actors
  def search
    mechanize = Mechanize.new

    page = mechanize.get('http://www.imdb.com/list/ls072706884/')

    doc_text = page.parser

    doc = doc_text.search('div').search('b').search('a').to_s

    while doc.include? 'href'
      start = doc.index ' href'
      finish = doc.index '/"'
      doc.slice! (start..finish)
      doc.slice! '<a">'
    end

    arr_actors = []

    arr_actors = doc.split('</a>')
    arr_actors.pop(5)

    arr_actors
  end
end
