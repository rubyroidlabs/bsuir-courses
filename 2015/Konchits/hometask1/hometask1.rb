def cls # method cls
  puts "\e[H\e[2J"
end

def go # method go
  file1 = File.open('1.txt')
  file_arr1 = file1.to_a
  file2 = File.open('2.txt')
  file_arr2 = file2.to_a
  it = 0
  while it < 35
    if (it % 2 == 0)
      i = 0
      while i < 21
        cls
        file_arr1[i].insert(0, '─')
        i = i + 1
      end
      puts file_arr1
      sleep 0.2
      it = it + 1
    else
      i = 0
      while i < 21
        cls
        file_arr2[i].insert(0, '─')
        i = i + 1
      end
      puts file_arr2
      sleep 0.1
      it = it + 1
    end
  end
end
go
