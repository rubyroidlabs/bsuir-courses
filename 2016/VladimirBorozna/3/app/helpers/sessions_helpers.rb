require "pry"

module SessionsHelpers #:nodoc:
  def log_in(user)
    session[:user_id] = user.id
    session[:name]    = user.name
  end

  def log_out
    forget(current_user)
    @current_user = nil
    session.delete(:user_id)
    session.delete(:name)
  end

  def current_user_id
    session[:user_id]
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(user_id: user_id)
    elsif (user_id = request.cookies[:user_id])
      user = User.find_by(user_id: user_id)
      if user && user.remembered?(request.cookies[:remember_token])
        log_in(user)
        @current_user ||= user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    request.cookies[:user_id] = user.id
    request.cookies[:remember_token] = user.remember_token
  end

  def forget(user)
    request.cookies.delete(:user_id)
    request.cookies.delete(:remember_token)
    user.forget
  end
end
