class UsersController < ApplicationController

  # loads the signup page
  # does not let a logged in user view the signup page
  get '/signup' do
    if !logged_in?
      erb :'users/create_user', :layout => :'not_logged_in_layout'
    else
      redirect_to_home_page
    end
  end

  # does not let a user sign up without a username
  # does not let a user sign up without an email
  # does not let a user sign up without a password
  # creates a general category on initialization
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Pleae don't leave blank content"
      redirect to '/signup'
    else
      @user = User.create(username:params[:username], email:params[:email], password:params[:password])
      @category = Category.create(name:"General", user_id:@user.id)
      session[:user_id] = @user.id
      flash[:message] = "It's time to add expenses"
      redirect_to_home_page
    end
  end

  # loads the login page
  # loads expenses page after login
  # does not let user view login page if already logged in
  get '/login' do
    if logged_in?
      redirect_to_home_page
    else
      erb :index, :layout => :'not_logged_in_layout'
    end
  end

  # loads expenses if username exists and password is authenticated
  post '/login' do
    @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to_home_page
    else
      flash[:message] = "We can't find you, Please try again"
      redirect_if_not_logged_in
    end
  end

  # lets an user edit info only if logged in
  get '/users/:id/edit' do
    if logged_in?
        erb :'users/edit_user'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit with blank content
  patch '/users/:id' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.find(params[:id])
      @user.update(username:params[:username], email:params[:email], password:params[:password])
      flash[:message] = "Account Updated"
      redirect to "/users/#{@user.id}"
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/users/#{params[:id]}/edit"
    end
  end

  # displays user info if logged in
  get '/users/:id' do
    if logged_in?
      erb :'users/show'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user delete its own account if they are logged in
  delete '/users/:id/delete' do
    if logged_in?
      current_user.delete
      redirect to "/logout"
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user logout if they are already logged in
  # does not let a user logout if not logged in
  get '/logout' do
    if logged_in?
      session.clear
      redirect_if_not_logged_in
    else
      redirect to "/"
    end
  end

end
