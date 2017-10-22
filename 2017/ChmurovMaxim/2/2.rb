def my_split(text)
  text = text.split(/[a-z,A-Z,0-9]*/)
  text1 = text[0], text[2], text[4]
  text2 = text[1], text[3], text[5]
end
