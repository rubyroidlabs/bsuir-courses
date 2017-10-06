require "sinatra"
require "erb"
require "mongo"
require "json"

require "thin"
require "sinatra/base"
require "em-websocket"

require_relative "Models/user.rb"
require_relative "Models/word.rb"
require_relative "Models/phrase.rb"

EventMachine.run do
  # class App Sinatra Base
  class App < Sinatra::Base
    enable :sessions

    get "/" do
      @user = session[:user]
      @phrases = Phrase.new.find_all

      erb :index
    end

    post "/add_phrase" do
      erb :index, layout: false
    end

    post "/sign_in" do
      username = request.params["username"]
      password = request.params["password"]

      if User.new.exist?(username) && User.new.check_password(username, password)
        user = User.new.find_by_username(username)

        session["user"] = {
          username: username,
          name: user[:name]
        }

        { result: true }.to_json
      else
        { result: false }.to_json
      end
    end

    get "/logout" do
      session[:user] = nil

      redirect "/"
    end

    post "/sign_up" do
      name = request.params["name"]
      username = request.params["username"]
      password = request.params["password"]

      if User.new.exist?(username)
        { result: false }.to_json
      else
        User.new.insert_one(name, username, password)
        session[:user] = {
          name: name,
          username: username,
          password: password
        }

        { result: true }.to_json
      end
    end
  end

  # our WebSockets server logic will go here

  App.run! port: 3000

  @clients = []

  def create_word(username, text)
    user = User.new
    word = Word.new(client: user.client)

    user.find_by_username(username)
    word.insert_one(user[:_id], text, Time.now)
  end

  def create_phrase(user_id, word_id)
    user = User.new
    phrase = Phrase.new(client: user.client)

    phrase_id = phrase.insert_one(user_id, Time.now)
    phrase.add_word(BSON::ObjectId(phrase_id), word_id)

    phrase_id
  end

  def add_word(phrase_id, word_id)
    user = User.new
    phrase = Phrase.new(client: user.client)

    phrase.add_word(BSON::ObjectId(phrase_id), word_id)
  end

  def send_data(type, data, phrase_id, word_id)
    user = User.new
    word = Word.new(client: user.client)
    user = user.find_by_username(data["username"])

    send_data(type,
              phrase_id: phrase_id.to_s,
              word_id: word_id.to_s,
              word_text: data["text"],
              username: user[:username],
              name: user[:name],
              time: word.find_by_id(word_id)[:date])
  end

  EM::WebSocket.start(host: "0.0.0.0", port: "3001", secure_proxy: true) do |ws|
    enable :sessions

    ws.onopen do |handshake|
      @clients << ws

      ws.send "Connected to #{handshake.path}."
    end

    ws.onclose do
      ws.send "Closed."
      @clients.delete ws
    end

    ws.onmessage do |message|
      message = JSON.parse(message)
      data = message["data"]

      case message["type"]
      when "create_phrase" then
        word_id = create_word(data[:username], data[:text])
        phrase_id = create_phrase(message["data"])
        send_data(message["type"], message["data"], phrase_id, word_id)
      when "add_word" then
        word_id = create_word(data[:username], data[:text])
        add_word(data["phrase_id"], word_id)
        send_data(message["type"], message["data"], data["phrase_id"], word_id)
      end
    end
  end
end
