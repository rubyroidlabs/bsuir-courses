class User
  def initialize(name, surname, chat_id)
    @name = name
    @surname = surname
    @id = chat_id
  end

  def getid
    @id
  end

  def getname
    @name
  end

  def getsurname
    @surname
  end
end
