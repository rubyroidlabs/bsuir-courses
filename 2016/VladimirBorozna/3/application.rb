require "bundler"
Bundler.require

require_all "lib"
require_all "app/{controllers,models,helpers}/*.rb"

class Application < Sinatra::Base #:nodoc:
  set :root, File.dirname(__FILE__)
  set :sprockets, Sprockets::Environment.new
  set :assets_prefix, "assets"
  set :assets_path, File.join(root, "public", assets_prefix)

  configure do
    sprockets.append_path File.join(root, "app/assets", "stylesheets")
    sprockets.append_path File.join("app/assets", "javascripts")
  end

  configure :development do
    sprockets.css_compressor = :scss
    sprockets.js_compressor  = :uglify
  end

  def initialize
    @app = Rack::Builder.new do
      map("/")         { run PhrasesController }
      map("/phrases")  { run PhrasesController }
      map("/sessions") { run SessionsController }
      map("/users")    { run UsersController }
      map("/assets")   { run Rack::Directory.new("./public/assets") }
    end
  end

  def call(env)
    @app.call(env)
  end
end
