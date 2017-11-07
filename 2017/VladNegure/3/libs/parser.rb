module Parser
  class NotImplementedError < NoMethodError
  end

  def parse
    celebrities = []
    celebrities_list.each do |celebrity|
      next if celebrity['name'] == ''
      # not using symbols because json will overwrite them as a string anyway
      celebrities << { 'name' => name(celebrity),
                       'orientation' => orientation(celebrity),
                       'description' => description(celebrity) }
    end
    celebrities
  end

  private

  def page
    raise NotImplementedError, 'Not implemented'
  end

  def celebrities_list
    raise NotImplementedError, 'Not implemented'
  end

  def name
    raise NotImplementedError, 'Not implemented'
  end

  def orientation
    raise NotImplementedError, 'Not implemented'
  end

  def description
    raise NotImplementedError, 'Not implemented'
  end
end
