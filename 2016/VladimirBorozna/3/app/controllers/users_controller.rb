class UsersController < ApplicationController #:nodoc:
  set :views, File.expand_path("../../views/users", __FILE__)

  before "/signup" do
    logged_in?
  end

  get "/signup" do
    partial(:modal) { slim :signup, layout: false }
  end

  post "/signup" do
    @user = User.new(params)
    if @user.save
      log_in(@user)
      redirect_through_js("/")
    else
      response_json(400, error_messages(@user))
    end
  end
end
