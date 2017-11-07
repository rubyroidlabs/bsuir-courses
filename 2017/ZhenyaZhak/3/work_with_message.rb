require 'translit'

class WorkWithMessage
  NAME = 0

  def self.tree_hells(name_p)
    mas_name = Array.new
    # [0] and [0..1] partition of the first triad
    mas_name << name_p[0]
    mas_name << name_p[0..1]
    name_p.length.times do |i|
      # [i..(i + 2)] size of a triad
      mas_name << name_p[i..(i + 2)]
    end
    mas_name
  end

  def self.get_count(baza_name, mas_name)
    count = 0
    mas_name.map do |el|
      if baza_name.include? el
        count += 1
      end
    end
    count
  end

  def self.get_name(name_p, baza_n)
    # == 1 this is a check for the last name
    if name_p.split(' ').size == 1
      baza_name = baza_n.split(' ')
      baza_name = baza_name[baza_name.size - 1]
    else
      baza_name = baza_n
    end
    baza_name
  end

  def self.find_index(count_mas)
    max_el = 0
    max_i = 0
    count_mas.length.times do |i|
      if count_mas[i] > max_el
        max_el = count_mas[i]
        max_i = i
      end
    end
    max_i
  end

  def self.find_by_name(name_p, baza)
    count_mas = Array.new
    baza.length.times do |i|
      if baza[i][NAME] == name_p
        return i
      else
        name_p = Translit.convert(name_p, :english)
        baza_name = get_name(name_p, baza[i][NAME])
        mas_name = tree_hells(name_p)
        count_mas << get_count(baza_name, mas_name)
      end
    end
    baza.size + find_index(count_mas)
  end
end
