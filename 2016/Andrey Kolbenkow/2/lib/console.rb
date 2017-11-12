require 'colorize'

class Console
  def start
    puts 'Bot started'.green
  end

  def db_detected
    puts 'Database is here'.blue
  end

  def db_not_found
    puts 'Database not found'.red
    puts 'Creating database...'.blue
  end

  def ok
    puts 'OK'.green
  end

  def task(task, name)
    puts "#{task} running to #{name}".blue
  end
end
