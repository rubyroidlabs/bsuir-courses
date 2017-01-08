# class UsersController
class UsersController < ApplicationController
  get "/login" do
    if logged_in?
      redirect_to_home_page
    else
      slim :login
    end
  end

  post "/login" do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to_home_page
    else
      redirect_if_not_logged_in
    end
  end

  get "/users/signup" do
    slim :sign_up
  end

  post "/users/signup" do
    if params[:first_name].empty? ||
       params[:last_name].empty? ||
       params[:email].empty? ||
       params[:password].empty?
      flash[:message] = "Pleae don't leave blank content"
      redirect to "/users/signup"
    else
      user = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password]
      )
      session[:user_id] = user.id
      redirect to "/"
    end
  end

  get "/users/edit/:id" do
    @user = User.find(params[:id])
    slim :edit_user
  end

  post "/users/edit/:id" do
    unless params[:first_name].empty? ||
           params[:last_name].empty? ||
           params[:email].empty?
      User.update(params[:id], first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
      redirect to "/"
    end
  end

  get "/logout" do
    session.clear if logged_in?
    redirect_to_home_page
  end
end
