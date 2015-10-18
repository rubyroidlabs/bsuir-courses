system 'clear'
a = Array.new
a[0] = '                                                                                     HBBB                 '
a[1] = 'BBBBBBBBBBBB                                 BBBHBBBBH                                ABB                 '
a[2] = '     BB                                       BB2   BB                                ABB                 '
a[3] = '     BB      BHHBHBBA HHB2  BBB2   HBH HBB    BB2   BB  BBB  SHBH   BBBHHBBBB BBBBB   ABHHBBBBH   BBBBBBB '
a[4] = '     BB        BB      BB2   BB2   BB   BB9   BB2 BBBH   BB    BB    BBB   BBH   BB   ABB    HB        BB '
a[5] = '     BB        BB      BB2   BB2  HBBBBBBBH   BB2        BB    BB    BBH   BB    BB   ABB    BBH   BBBBBB '
a[6] = '     BB        BB      BB2   BB2  3BB         BB2        BB    BB    BBH   BB    BB   ABB    BBs HBB   BB '
a[7] = '     BB        BB      BBB BBBB2   BBB    H   BB2        BBB BBBB    BBH   BB    BB   ABBB  BBB  HBB  BBBs'
a[8] = '   XBBBBH    BBBBB      ABB  BBBH     BBBB   BBBBB        BBH  BBBH BBBBA BBBB  BBBBr HBH BBB      BB   BB'
i = 0
while i<60
  for n in 0..8
    puts a[n] = ' ' + a[n]
  end
  sleep(0.08)
  system 'clear'
  i = i + 1
end
i=0
while i<60
  for n in 0..8
    a[n][0] = ''
    puts a[n]
  end
  sleep(0.08)
  system 'clear'
  i = i+1
end