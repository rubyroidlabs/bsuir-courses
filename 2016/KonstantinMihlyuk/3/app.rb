require 'sinatra'
require 'erb'
require 'mongo'
require 'json'

require 'thin'
require 'sinatra/base'
require 'em-websocket'

require_relative 'Models/user.rb'
require_relative 'Models/word.rb'
require_relative 'Models/phrase.rb'

EventMachine.run do
  class App < Sinatra::Base
    enable :sessions

    get '/' do
      @user = session[:user]
      @phrases = Phrase.new.find_all

      erb :index
    end

    post '/add_phrase' do
      erb :index, :layout => false
    end

    post '/sign_in' do
      username = request.params['username']
      password = request.params['password']

      if User.new.is_exist(username) && User.new.check_password(username, password)
        user = User.new.find_by_username(username)

        session['user'] = {
            username: username,
            name: user[:name]
        }

        return {result: true}.to_json
      else
        return {result: false}.to_json
      end

    end

    get '/logout' do
      session[:user] = nil

      redirect '/'
    end

    post '/sign_up' do
      name = request.params['name']
      username = request.params['username']
      password = request.params['password']

      if User.new.is_exist(username)
        return {result: false}.to_json
      else
        User.new.insert_one(name, username, password)
        session[:user] = {
            name: name,
            username: username,
            password: password
        }

        return {result: true}.to_json
      end
    end
  end

  # our WebSockets server logic will go here

  App.run! :port => 3000

  @clients = []

  EM::WebSocket.start(:host => '0.0.0.0', :port => '3001', :secure_proxy => true) do |ws|
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

      case message['type']
        when 'create_phrase' then
          create_phrase(message['data'])
        when 'add_word' then
          add_word(message['data'])
      end
    end

    def create_phrase(data)
      text = data['text']
      username = data['username']

      date = Time.now

      user = User.new
      word = Word.new(client: user.get_client)
      phrase = Phrase.new(client: user.get_client)

      user = user.find_by_username(username)

      if user
        word_id = word.insert_one(user[:_id], text, date)
        phrase_id = phrase.insert_one(user[:_id], date)
        phrase.add_word(BSON::ObjectId(phrase_id), word_id)
        word_model = word.find_by_id(word_id)

        @clients.each do |socket|
          result = {
              type: 'create_phrase',
              data: {
                  phrase_id: phrase_id.to_s,
                  word_id: word_id.to_s,
                  word_text: text,
                  username: user[:username],
                  name: user[:name],
                  time: word_model[:date]
              }
          }.to_json

          socket.send result
        end
      end

    end

    def add_word(data)
      text = data['text']
      phrase_id = data['phrase_id']
      username = data['username']

      date = Time.now

      user = User.new
      word = Word.new(client: user.get_client)
      phrase = Phrase.new(client: user.get_client)

      user = user.find_by_username(username)

      if user
        word_id = word.insert_one(user[:_id], text, date)
        phrase.add_word(BSON::ObjectId(phrase_id), word_id)
        word_model = word.find_by_id(word_id)

        @clients.each do |socket|
          result = {
              type: 'add_word',
              data: {
                  phrase_id: phrase_id.to_s,
                  word_id: word_id.to_s,
                  word_text: text,
                  username: user[:username],
                  name: user[:name],
                  time: word_model[:date]
              }
          }.to_json

          socket.send result
        end
      end
    end
  end
end
