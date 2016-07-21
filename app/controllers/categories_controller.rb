class CategoriesController < ApplicationController

  get '/categories' do
    if logged_in?
      @categories = current_user.categories.all
      erb :'categories/categories'
    else
      redirect_if_not_logged_in
    end
  end

  post '/categories' do
    if params[:name].empty?
      flash[:message] = "Please Enter a Category Name"
      redirect to "/categories"
    else
      @user = current_user
      @category = Category.create(name:params[:name], user_id:@user.id)
      redirect to "/categories"
    end
  end

  get '/categories/:id' do
    if logged_in?
      @category = Category.find(params[:id])
      erb :'categories/show_category'
    else
      redirect_if_not_logged_in
    end
  end

  get '/categories/:id/edit' do
    if logged_in?
      @category = Category.find(params[:id])
      if @category.user_id == current_user.id
        erb :'categories/edit_category'
      else
        redirect to "/categories"
      end
    else
      redirect_if_not_logged_in
    end
  end

  patch '/categories/:id' do
    if !params[:name].empty?
      @category = Category.find(params[:id])
      @category.name = params[:name]
      @category.save
      flash[:message] = "Your category has been updated successfully"
      redirect to "/categories"
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/categories/#{params[:id]}/edit"
    end
  end

  delete '/categories/:id/delete' do
    if logged_in?
      if current_user.categories.size == 1
        flash[:message] = "You need at least one category"
        redirect to "/categories"
      else
        @category = Category.find(params[:id])
        if @category.user_id == current_user.id
          @category.expenses.clear
          @category.save
          @category.delete
          flash[:message] = "Your category has been deleted successfully"
          redirect to "/categories"
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
        redirect to '/expenses'
      end
    else
      redirect_if_not_logged_in
    end
  end

end
