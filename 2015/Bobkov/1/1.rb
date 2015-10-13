def n_spase(n)
  n.times { print ' ' }
end

def trucs(n)
  n_spase(n)
  puts '                  _______________________________________ '
  n_spase(n)
  puts '                  | XXXXX    XX   XX  XXXXX    XX    XX  |'
  n_spase(n)
  puts '             /    | XX  XX   XX   XX  XX  XX    XX  XX   |'
  n_spase(n)
  puts '            /---, | XXXXX    XX   XX  XXXXX       XX     |'
  n_spase(n)
  puts '       -----# ==| | XX XX    XX   XX  XX   XX     XX     |'
  n_spase(n)
  puts '       | :) # ==| | XX  XX    XXXXX   XXXXXXX     XX     |'
  n_spase(n)
  if n%2==0 
  puts '  ----- ----#   | |______________________________________|'
  else
  puts '  ----- ----#   | |_________________________THE_BEST!!!__|'
  end 
  n_spase(n)
  puts '  |)___()   #   |____====____   \____________________    |'
  n_spase(n)
  puts '   (0)|    ===***** (0)(0)| -  o               (0)(0)(0)| '
end

system ('clear')
i = 21
21.times do
  trucs(i)
  sleep(0.2)
  system ('clear')
  i -= 1  
end
