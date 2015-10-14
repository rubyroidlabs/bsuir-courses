class Unzipper
  
  def self.unzip(file)
  	system("gzip -d #{file}")
  	Dir["./#{file.sub(/.gz/, '')}"]
  end
end