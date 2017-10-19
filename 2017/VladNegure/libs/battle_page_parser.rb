require 'mechanize'

module BattlePageParser
  module_function

  def title(page)
    page.search('.header_with_cover_art-primary_info-title').text
  end

  def left_mc(page)
    title(page).split(/\svs\.?\s/i).first
  end

  def right_mc(page)
    title(page).split(/\svs\.?\s/i).last.gsub(/\s*\(.*\)/, '')
  end

  def texts(page)
    page.search('.lyrics p').text.split(/\[.*\]/).drop(1)
  end

  def left_mc_texts(page)
    texts = texts(page)
    texts.values_at(* texts.each_index.select(&:even?))
  end

  def right_mc_texts(page)
    texts = texts(page)
    texts.values_at(* texts.each_index.select(&:odd?))
  end
end

