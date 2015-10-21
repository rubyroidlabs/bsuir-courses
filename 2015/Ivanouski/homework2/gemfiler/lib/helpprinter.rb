class HelpPrinter
  def print_help
    print "Usage:\n"
    print "./gemfiler.rb gem_name 'option' version\n"
    print "option:\t\t '<'\n"
    print "\t\t '>'\n"
    print "\t\t '>='\n"
    print "\t\t '~>'\n\n"
    print "optional second option and version:\n"
    print "./gemfiler.rb gem_name 'option' version"
    print " 'other_option' other_version\n"
    print "option:\t\t '>'\n"
    print "\t\t '>='\n"
    print "second option:\t '<'\n\n"
    print "example: "
    print "./gemfiler.rb rails '>' 4 '<' 4.2\n"
    exit 0
  end

  def connection_error(error_messsage)
    error = "Connection error!"
    puts error.red
    puts error_messsage
    exit 0
  end

  def name_error
    error = "Check your input!"
    puts error.red
    print_help
  end
end
