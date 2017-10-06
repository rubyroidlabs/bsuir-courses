# Users Controller
class UsersController < ApplicationController
  post "/users/login" do
    redirect to "/ban" if user_banned?
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id if user && user.authenticate(params[:password])
    redirect_to_root_path
  end

  post "/users/signup" do
    redirect to "/ban" if user_banned?
    unless params[:first_name].empty? ||
           params[:last_name].empty? ||
           params[:email].empty? ||
           params[:password].empty?
      user = User.create!(
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

  get "/users/:id" do
    redirect to "/ban" if user_banned?
    @user = User.find(params[:id])
    @users = User.all
    @words = @user.words.includes(:quote)
    slim :user_page
  end

  get "/users/ban/:id" do
    redirect to "/ban" if user_banned?
    if current_user.role == "admin"
      user = User.find(params[:id])
      user.update!(ban: true)
      redirect to "/users/#{current_user.id}"
    else
      slim :main_page
    end
  end

  get "/users/unban/:id" do
    redirect to "/ban" if user_banned?
    if current_user.role == "admin"
      user = User.find(params[:id])
      user.update!(ban: false)
      redirect to "/users/#{current_user.id}"
    else
      slim :main_page
    end
  end
end
