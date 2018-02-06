class Responser
  attr_accessor :message, :list_of_names

  def initialize(message, list_of_names)
    @message = message
    @list_of_names = list_of_names
  end

  def response
    if @list_of_names.include? @message
      true
    else
      false
    end
  end
end
