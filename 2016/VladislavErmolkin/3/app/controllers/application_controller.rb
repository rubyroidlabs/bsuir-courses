require "rack-flash"

# class ApplicationController
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    @quotes = Phrase.all
    slim :index
  end

  helpers do
    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
      redirect "/login" unless logged_in?
    end

    def redirect_to_home_page
      redirect to "/"
    end

    def redirect_to_categories
      redirect to "/categories"
    end
  end
end
