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

  get '/login' do
    if logged_in?
      redirect_to_home_page
    else
      erb :index
    end
  end

  post 'login' do
    @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to_home_page
    else
      flash[:message] = "We can't find you, Please try again"
      redirect_if_not_logged_in
    end
  end

  get '/users/:id/edit' do
    if logged_in?
        erb :'users/edit_user'
    else
      redirect_if_not_logged_in
    end
  end

  patch '/users/:id' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.find(params[:id])
      @user.username = params[:username]
      @user.email = params[:email]
      @user.password = params[:password]
      @user.save
      redirect to "/users/#{@user.id}"
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/users/#{params[:id]}/edit"
    end
  end

  delete '/users/:id/delete' do
    if logged_in?
      current_user.delete
      redirect to "/logout"
    else
      redirect_if_not_logged_in
    end
  end



end
