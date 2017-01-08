class CategoriesController < ApplicationController

  # lets user view expense categories if logged in
  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/categories'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank category
  post '/categories' do
    if params[:name].empty?
      flash[:message] = "Please Enter a Category Name"
      redirect_to_categories
    else
      @user = current_user
      @category = Category.create(name:params[:name], user_id:@user.id)
      redirect_to_categories
    end
  end

  # displays a single category
  get '/categories/:id' do
    if logged_in?
      @category = Category.find(params[:id])
      erb :'categories/show_category'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user view category edit form if they are logged in
  # does not let a user edit a category not created by it self
  get '/categories/:id/edit' do
    if logged_in?
      @category = Category.find(params[:id])
      if @category.user_id == current_user.id
        erb :'categories/edit_category'
      else
        redirect_to_categories
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit a category with blank content
  patch '/categories/:id' do
    if !params[:name].empty?
      @category = Category.find(params[:id])
      @category.update(name:params[:name])
      flash[:message] = "Your category has been updated successfully"
      redirect_to_categories
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own category if they are logged in
  # does not let a user delete a category they did not create
  delete '/categories/:id/delete' do
    if logged_in?
      if current_user.categories.size == 1
        flash[:message] = "You need at least one category"
        redirect_to_categories
      else
        @category = Category.find(params[:id])
        if @category.user_id == current_user.id
          @category.destroy
          flash[:message] = "Your category has been deleted successfully"
          redirect_to_categories
        end
      end
    else
      redirect_if_not_logged_in
    end
  end

  # helper route created to edit expenses when the erb
  # file adds '/categories' to the edit link
  get '/categories/expenses/:id/edit' do
    if logged_in?
      @expense = Expense.find(params[:id])
      @category = Category.find(@expense.category_id)
      if @expense.user_id == session[:user_id]
        erb :'expenses/edit_expense'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

end
