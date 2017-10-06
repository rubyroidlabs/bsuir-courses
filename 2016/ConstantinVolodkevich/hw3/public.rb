class Public < Sinatra::Base

  get '/' do
    send_file File.expand_path('new_index.html', settings.public_folder)
  end


  post '/users' do
    p 'HI!'
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