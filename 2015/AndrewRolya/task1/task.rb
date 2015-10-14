require "colorize"

def colorization(inputText,indicator)
    inputText.size.times do |i|
        case indicator
        when 1
            if inputText[i]=="%"
                print inputText[i].red
            else
                print inputText[i]
            end
        when 2
            if inputText[i]=="@"
                print inputText[i].yellow
            else
                print inputText[i]
            end
        when 3
            if inputText[i]=="&"
                print inputText[i].green
            else
                print inputText[i]
            end
        when 4
            if inputText[i]=="@"
                print inputText[i].yellow
            else
                print inputText[i]
            end
        else
            print inputText[i]
        end
    end
end

inputSource = File.open("./inputForTask.txt").read
counter = 0
50.times do |i|
    counter +=1
    colorization(inputSource,counter)
    sleep(0.3)
    if counter==4
        counter=0
    end
    puts "\e[H\e[2J"
end
