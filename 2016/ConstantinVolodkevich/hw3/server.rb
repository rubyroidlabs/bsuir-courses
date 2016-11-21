require 'sinatra'
require 'mongoid'
require 'json'
require 'jwt'
require_relative 'user'
require_relative 'phrase'
require_relative 'word'
require_relative 'middleware'
require 'pusher'

Mongoid.load! "mongoid.config"
Pusher.app_id = '271330'
Pusher.key = '1404da432444b8f9e7aa'
Pusher.secret = '0483c6ea972392cdbd14'
Pusher.host = "api-eu.pusher.com"


class Api < Sinatra::Base

  use Auth

  post '/phrases' do
    data = JSON.parse(request.body.read.to_s)
    phrase = Phrase.create(user: data['user'], last_user: data['user'])
    unless data['phrase']['first'].nil?
    word = Word.create(text: data['phrase']['first'], username: data['user'],  time: Time.new.to_s)

    phrase.push(words: word.as_json)
    phrase.save!
    Pusher.trigger('messages', 'my_event', {
        text: "LOOOOL"
    })
    Phrase.all.to_json
    end
  end

  get '/users' do
    User.all.to_json
  end

  get '/phrases/:id/words' do
    phrase = Phrase.find(params['id'])
    phrase.words.to_json
  end

  post '/phrases/:id/words' do
      data = JSON.parse(request.body.read.to_s)
      phrase = Phrase.find(params['id'])
      if phrase.last_user != data['user'] && data['word']['text'] != 'null'
        phrase.last_user = data['user']
        word = Word.create(text: data['word']['text'], username: data['user'],  time: Time.new.to_s)
        phrase.push(words: word.as_json)
        phrase.save!
        Pusher.trigger('messages', 'my_event', {
            text: "LOOOOL"
        })
      end
      Phrase.all.to_json
  end

  end

class Public < Sinatra::Base

  get '/' do
    send_file File.expand_path('new_index.html', settings.public_folder)
  end



  post '/users' do
    data = JSON.parse(request.body.read.to_s )
    user = User.create(username: data['name'], password: data['password'])
    user.save!

  end

  get '/phrases' do
   phrases = Phrase.all.sort_by { |phrase| phrase.words.size }.reverse!
   phrases.to_json
  end

  get '/phrases/:id' do
    phrase = Phrase.find(params['id'])
    phrase.to_json
  end

  get '/phrases/:id/history' do
    phrase = Phrase.find(params['id'])
    phrase.words.each do |word|

    end

  end

  post '/login' do
    data = JSON.parse(request.body.read.to_s )
    user = User.find_by(username: data['name'], password: data['password'])
    if user !=nil
      { token: token(data['name'])}.to_json
    end
  end


  def token username
    JWT.encode payload(username), JWT_SECRET, 'HS256'
  end

  def payload username
    {
        exp: Time.now.to_i + 60 * 60,
        iat: Time.now.to_i,
        iss: JWT_ISSUER,
        user: {
            username: username
        }
    }
  end
end
