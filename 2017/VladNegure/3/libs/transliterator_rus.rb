class String
  DICTIONARY = {
    'а' => 'a',
    'б' => 'b',
    'в' => 'v',
    'г' => 'g',
    'д' => 'd',
    'е' => 'ye',
    'ё' => 'yo',
    'ж' => 'zh',
    'з' => 'z',
    'и' => 'y',
    'й' => 'i',
    'к' => 'k',
    'л' => 'l',
    'м' => 'm',
    'н' => 'n',
    'о' => 'o',
    'п' => 'p',
    'р' => 'r',
    'с' => 's',
    'т' => 't',
    'у' => 'u',
    'ф' => 'f',
    'х' => 'kh',
    'ц' => 'ts',
    'ч' => 'ch',
    'ш' => 'sh',
    'щ' => 'shch',
    'ы' => 'y',
    'э' => 'e',
    'ю' => 'yu',
    'я' => 'ya'
  }.freeze

  def from_rus_to_eng
    eng_string = ''
    downcase.each_char do |char|
      eng_string += if DICTIONARY.key? char
                      DICTIONARY[char]
                    else
                      char
                    end
    end
    eng_string
  end
end
