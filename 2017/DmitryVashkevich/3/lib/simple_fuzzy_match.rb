require 'active_support/all' # mb_chars

def simple_fuzzy_match(s1, s2)
  levenshtein_distance(normalize_str(s1), normalize_str(s2)) < 3
end

def normalize_str(s)
  s.mb_chars.downcase.strip.split(/\s+/).sort.join(' ')
  # mb_chars - convert to multibyte string (ActiveSupport::Multibyte::Chars)
  # downcase - lower case for all characters
  # strip - remove whitespace from start and end
  # RegEx split by spaces into array of words
  # sort array of words alphabetically
  # join back to string by concatenating with space for
  # further comparison by Levenshtein distance
end

### Helper function

def levenshtein_distance(s, t)
  m = s.length
  n = t.length
  return m if n.zero?
  return n if m.zero?
  d = Array.new(m + 1) { Array.new(n + 1) }

  (0..m).each { |i| d[i][0] = i }
  (0..n).each { |j| d[0][j] = j }
  (1..n).each do |j|
    (1..m).each do |i|
      d[i][j] = if s[i - 1] == t[j - 1] # adjust index into string
                  d[i - 1][j - 1] # no operation required
                else
                  [d[i - 1][j] + 1, # deletion
                   d[i][j - 1] + 1, # insertion
                   d[i - 1][j - 1] + 1].min # substitution
                end
    end
  end
  d[m][n]
end
