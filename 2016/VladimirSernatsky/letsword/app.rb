require_relative "config/environment"

require_relative "auth"

Dir.glob('models/*.rb').each { |file| require_relative file }

class Letsword < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Auth

  set :database_file, "db/config.yml"
  set :sockets, []

  use Rack::Session::Pool, expire_after: 1 * 24 * 60 * 60, secret: SecureRandom.hex(20)

  get "/list", auth: true do
    slim :list
  end

  get "/edit/:id", auth: true do
    @sentence = Sentence.find_by(id: params["id"])
    slim :edit
  end

  post "/edit/?:id?", auth: true do
    if params["action"] == "create"
      if params["word"]
        word = Sentence.word params["word"]
        sentence = Sentence.create(text: word)
        sentence.commits << Commit.create(user_id: @user.id, word: word)
        sentence.save
        EM.next_tick do
          settings.sockets.each do |s|
            s.send(JSON.generate({"action":"create", "user": {"id": @user.id, "name": @user.name}, "sentence": {"id": sentence.id, "text": sentence.text}}))
          end
        end
      end
    elsif params["action"] == "edit"
      if params["word"] && params["id"]
        sentence = Sentence.find_by(id: params["id"])
        if sentence.commits.last.user.id != @user.id
          word = Sentence.word params["word"]
          sentence.add_word(word)
          sentence.commits << Commit.create(user_id: @user.id, word: word)
          sentence.save
          EM.next_tick do
            settings.sockets.each do |s|
              s.send(JSON.generate({"action":"edit", "user": {"id": @user.id, "name": @user.name}, "sentence": {"id": sentence.id, "text": sentence.text}}))
            end
          end
        end
      end
    end
    redirect to "/list"
  end

  get "/signup", unauth: true do
    if params["user-name"] && params["user-password"]
      user = User.create(
        name: params["user-name"],
        password: params["user-password"]
      )
      session["user_id"] = user.id
      redirect to "/list"
    else
      slim :signup
    end
  end

  get "/login", unauth: true do
    if params["user-name"] && params["user-password"]
      user = User.find_by(
        name: params["user-name"],
        password: params["user-password"]
      )
      if user
        session["user_id"] = user.id
        redirect to "/list"
      else
        slim :login
      end
    else
      slim :login
    end
  end

  get "/logout", auth: true do
    session.delete "user_id"
    redirect to "/login"
  end

  get "/ws" do
    if request.websocket?
      request.websocket do |ws|
        ws.onopen do
          settings.sockets << ws
        end
        ws.onclose do
          settings.sockets.delete(ws)
        end
      end
    end
  end
end
