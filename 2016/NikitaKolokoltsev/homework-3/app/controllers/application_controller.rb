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
    redirect to "/ban" if user_banned?
    if !request.websocket?
      @quotes = Quote.all.includes(:words).order(created_at: :desc)
      @random_quote = random_quotes.keys.sample
      @random_quote_author = random_quotes[@random_quote]
      slim :main_page
    else
      create_web_socket_connection
    end
  end

  get "/ban" do
    if user_banned?
      slim :ban
    else
      redirect_to_root_path
    end
  end

  helpers do
    def redirect_to_root_path
      redirect to "/"
    end

    def user_signed_in?
      unless session[:user_id].nil?
        # Instance variable for optimizing DB queries
        @user_exists ||= User.find(session[:user_id])
        true
      end
    rescue ActiveRecord::RecordNotFound
      session.clear
      false
    end

    def current_user
      # DB optimize
      @current_user ||= @user_exists
      @current_user
    end
  end

  protected

  def create_web_socket_connection
    request.websocket do |ws|
      ws.onopen { add_websocket(ws) }
      ws.onmessage { |msg| send_message(msg) }
      ws.onclose { delete_websocket(ws) }
    end
  end

  def send_message(msg)
    EM.next_tick { settings.sockets.each { |s| s.send(msg) } }
  end

  def add_websocket(ws)
    settings.sockets << ws
  end

  def delete_websocket(ws)
    settings.sockets.delete(ws)
  end

  def user_banned?
    user_signed_in? ? current_user.ban : false
  end
end
