require 'mechanize'

class Celebrety
  def initialize(array_name, array_descript)
    @array_name = array_name
    @array_descript = array_descript
  end

  def slice_sym(doc)
    while doc.include? '>'
      start = doc.index '<'
      finish = doc.index '>'
      doc.slice! (start..finish)
    end
  end

  def pars(array_name, array_descript, page)
    doc_text = page.parser

    doc = doc_text.search('h1').to_s
    doc_descript = doc_text.search('article').to_s

    slice_sym(doc)
    slice_sym(doc_descript)

    doc.slice! (0..1)
    doc.chop!.chop!
    doc_descript.slice! (0...1)
    doc_descript.delete!("\n")

    if !doc.include? 'LONDON' and !doc.include? 'lebrities'
      array_name.push(doc)
    end
    array_descript.push(doc_descript)
  end

  def find_gays
    mechanize = Mechanize.new

    site_url = 'http://www.nydailynews.com/entertainment/gossip/celebrities-d'\
    'isclose-sexual-orientation-gender-identity-gallery-1.73963?pmSlide=1.355548'
    page = mechanize.get(site_url)

    pars(@array_name, @array_descript, page)

    trek_count = 0
    while trek_count != 71
      link_count = 0
      page.links.each do |link|
        if link.text == 'Next'
          link_count += 1
          if link_count == 2
            page = mechanize.get(link.uri)
            pars(@array_name, @array_descript, page)
            break
          end
        end
      end
      trek_count += 1
    end
  end
end
