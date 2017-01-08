# Users Controller
class UsersController < ApplicationController
  post "/users/login" do
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id if user && user.authenticate(params[:password])
    redirect_to_root_path
  end

  post "/users/signup" do
    unless params[:first_name].empty? ||
           params[:last_name].empty? ||
           params[:email].empty? ||
           params[:password].empty?
      user = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password]
      )
      session[:user_id] = user.id
    end
    redirect_to_root_path
  end

  get "/users/logout" do
    session[:user_id] = nil
    redirect_to_root_path
  end
end
