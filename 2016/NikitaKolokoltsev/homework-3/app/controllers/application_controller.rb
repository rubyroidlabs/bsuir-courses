# Application Controller
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    set :sockets, []
  end

  random_quotes = {
    "God is dead! He remains dead! And we have killed him." => "Friedrich Nietzsche",
    "I think therefore I am." => "Rene Descartes",
    "Leisure is the mother of philosophy." => "Thomas Hobbes",
    "I still think I am the greatest" => "Kanye West",
    "SAY HELLO TO MY LITTLE FRIEND!" => "Tony Montana",
    "First they ignore you, then they laugh at you, then they fight you, then you win." => "Mahatma Gandi",
    "I have a great relationship with the Mexican people." => "Donald Trump",
    "The difference between stupidity and genius is that genius has its limits." => "Albert Einstein",
    "No man has a good enough memory to be a successful liar." => "Abraham Lincoln"
  }

  get "/" do
    if !request.websocket?
      @quotes = Quote.all.includes(:words).order(created_at: :desc)
      @random_quote = random_quotes.keys.sample
      @random_quote_author = random_quotes[@random_quote]
      slim :main_page
    else
      create_web_socket_connection
    end
  end

  helpers do
    def redirect_to_root_path
      redirect to "/"
    end

    def user_signed_in?
      !session[:user_id].nil?
    end

    def current_user
      @user ||= User.find(session[:user_id])
      @user
    end
  end

  protected

  def create_web_socket_connection
    request.websocket do |ws|
      ws.onopen { settings.sockets << ws }
      ws.onmessage { |msg| EM.next_tick { settings.sockets.each { |s| s.send(msg) } } }
      ws.onclose { settings.sockets.delete(ws) }
    end
  end
end
