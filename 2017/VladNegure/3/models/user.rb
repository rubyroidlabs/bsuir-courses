class User
  attr_reader :denied_names, :id, :suggested_name, :name
  attr_accessor :search_request

  def initialize(id, name)
    @name = name
    @id = id
    @search_request = nil
    @suggested_name = nil
    @denied_names = []
  end

  def suggest(name)
    @suggested_name = name
  end

  def suggestion_dinied
    @denied_names << @suggested_name
    @suggested_name = nil
  end

  def suggestion_accepted
    @denied_names = []
    @suggested_name = nil
    @search_request = nil
  end
end
