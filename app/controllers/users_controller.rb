class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect_to_home_page
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Pleae don't leave blank content"
      redirect to '/signup'
    else
      @user = User.create(username:params[:username], email:params[:email], password:params[:password])
      @category = Category.create(name:"General", user_id:@user.id) #=> creates a category on initialization
      session[:user_id] = @user.id
      flash[:message] = "It's time to add expenses"
      redirect_to_home_page
    end
  end



end
