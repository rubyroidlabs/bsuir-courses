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


