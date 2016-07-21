class CategoriesController < ApplicationController

  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/categories'
    else
      redirect_if_not_logged_in
    end
  end


end
