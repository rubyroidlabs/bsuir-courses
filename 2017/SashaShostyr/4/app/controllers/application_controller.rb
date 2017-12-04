class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :nav_menu

  def nav_menu
    @data = JSON.parse(File.read('lib/tasks/data.json'))
    @posters = Poster.all
  end
end
