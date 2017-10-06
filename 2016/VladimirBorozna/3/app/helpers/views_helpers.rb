module ViewsHelpers # :nodoc:
  def partial(name, _locals = {}, &block)
    path = "#{settings.path_views}/partials"
    slim(name, views: path, layout: false, &block)
  end
end
