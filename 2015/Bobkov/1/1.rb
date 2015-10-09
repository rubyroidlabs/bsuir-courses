#Bobkov Andrey 
#9.10.2015

def n_spase(n)
  n.times { print " " }
end

def trucs(n)
 if n%2==0 
  n_spase(n)
  puts "                  _______________________________________ "
  n_spase(n)
  puts "                  | XXXXX    XX   XX  XXXXX    XX    XX  |"
  n_spase(n)
  puts "             /    | XX  XX   XX   XX  XX  XX    XX  XX   |"
  n_spase(n)
  puts "            /---, | XXXXX    XX   XX  XXXXX       XX     |"
  n_spase(n)
  puts "       -----# ==| | XX XX    XX   XX  XX   XX     XX     |"
  n_spase(n)
  puts "       | :) # ==| | XX  XX    XXXXX   XXXXXXX     XX     |"
  n_spase(n)
  puts "  -----'----#   | |______________________________________|"
  n_spase(n)
  puts "  |)___()  '#   |____====____   \____________________    |"
  n_spase(n)
  puts "   (0)|    ===***** (0)(0)| -  o              '(0)(0)(0)| "
 else 
   n_spase(n)
   puts "                  _______________________________________ "
   n_spase(n)
   puts "                  | XXXXX    XX   XX  XXXXX    XX    XX  |"
   n_spase(n)
   puts "             /    | XX  XX   XX   XX  XX  XX    XX  XX   |"
   n_spase(n)
   puts "            /---, | XXXXX    XX   XX  XXXXX       XX     |"
   n_spase(n)
   puts "       -----# ==| | XX XX    XX   XX  XX   XX     XX     |"
   n_spase(n)
   puts "       | :) # ==| | XX  XX    XXXXX   XXXXXXX     XX     |"
   n_spase(n)
   puts "  -----'----#   | |_________________________THE_BEST!!!__|"
   n_spase(n)
   puts "  |)___()  '#   |____====____   \____________________    |"
   n_spase(n)
   puts "   (0)|    ===***** (0)(0)| -  o              '(0)(0)(0)| "
 end
end


puts "\e[H\e[2J"
i = 21
21.times {
  trucs(i)
  sleep(0.2)
  puts "\e[H\e[2J"
  i -= 1  
}
