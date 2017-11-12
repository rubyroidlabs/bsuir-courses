class ApplicationController < Sinatra::Base #:nodoc:
  include ControllersHelpers
  include SessionsHelpers
  include ViewsHelpers
  include WebsocketHelpers
  use Websocket::Middleware

  enable :sessions

  set :session_secret, "super secret"
  set :path_views, File.expand_path("../../../app/views", __FILE__)
  set :slim, layout_options: { views: "app/views/layouts" }, layout: :application
  not_found { slim :not_found }
end
