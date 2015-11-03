class InputParser
  def initialize(filename)
    @filename = filename
    @doc = <<EOF
    Usage:
      #{@filename} <group_id>

      Option:
      -h         Show this help
EOF
  end

  def get_group_id
    begin
      arguments = Docopt::docopt(@doc)
    rescue Docopt::Exit => err
      puts err.message
      exit 1
    end
    @group_id = arguments['<group_id>']
  end
end
