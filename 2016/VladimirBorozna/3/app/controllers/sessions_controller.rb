class SessionsController < ApplicationController #:nodoc:
  set :views, File.expand_path("../../views/sessions", __FILE__)

  get "/login" do
    partial(:modal) { slim :login, layout: false }
  end

  post "/login" do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      log_in(user)
      remember(user)
      redirect_through_js("/")
    else
      response_json(400, ["The name or password is incorrect"])
    end
  end

  get "/logout" do
    log_out if logged_in?
    redirect_through_js("/")
  end
end
