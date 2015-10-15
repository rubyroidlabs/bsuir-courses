# рисуем машинку
root_car = "#{' ' * 11}" + "#{'-' * 15}"
str1_car = "#{' ' * 10}" + '/' + "#{' ' * 7}" + '|' + "#{' ' * 7}" + '|'
str2_car = "#{' ' * 9}" + '/' + "#{' ' * 8}" + '|' + "#{' ' * 7}" + '|'
str3_car = "#{' ' * 8}" + '/' + "#{' ' * 9}" + '|' + "#{' ' * 7}" + '|'
srt4_car = "#{'-' * 38}"
srt51_car = '|' + "#{' ' * 10}" + '--' + "#{' ' * 5}"
srt52_car = '|' + "#{' ' * 5}" + '--' + "#{' ' * 12}" + '||'
srt5_car = srt51_car + srt52_car
srt6_car = '|' + "#{' ' * 17}" + '|' + "#{' ' * 19}" + '|'
srt71_car = "#{'-' * 4}" + "#{'=' * 5}"
str72_car = "#{'-' * 18}" + "#{'=' * 5}" + "#{'-' * 6}"
srt7_car = srt71_car + str72_car
srt71chg_car = "#{'-' * 4}" + "#{'‖' * 5}"
srt72chg_car = "#{'-' * 18}" + "#{'‖' * 5}" + "#{'-' * 6}"
srt7chg_car = srt71chg_car + srt72chg_car
srt81_car = "#{' ' * 4}" + "#{'=' * 5}" + "#{' ' * 18}"
srt82_car = "#{'=' * 5}" + "#{' ' * 6}"
srt8_car = srt81_car + srt82_car
srt81chg_car = "#{' ' * 4}" + "#{'‖' * 5}"
srt82chg_car = "#{' ' * 18}" + "#{'‖' * 5}" + "#{' ' * 6}"
srt8chg_car = srt81chg_car + srt82chg_car
space = ' '
i = 0
# вывод на экран
loop do
  system 'clear'
  space += ' '
  puts space + root_car
  puts space + str1_car
  puts space + str2_car
  puts space + str3_car
  puts space + srt4_car
  puts space + srt5_car
  puts space + srt6_car
  if (i % 2 == 0)
    puts space + srt7_car
    puts space + srt8_car
  end
  if (i % 2 != 0)
    puts space + srt7chg_car
    puts space + srt8chg_car
  end
  sleep 0.05
  i += 1
  if i == 35
    system 'clear'
    break loop
  end
end
