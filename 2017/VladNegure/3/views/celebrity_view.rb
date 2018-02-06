module CelebrityView
  module_function

  def info(celebrity)
    info = celebrity['name']
    # rubocop maximum symbols in line evasion
    has_orientation = celebrity['orientation'] != ''
    has_description = celebrity['description'] != ''
    info += " is #{celebrity['orientation']}" if has_orientation
    info += "\n#{celebrity['description']}" if has_description
    info
  end
end
