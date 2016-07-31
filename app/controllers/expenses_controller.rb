class ExpensesController < ApplicationController

  # lets a user view all expenses if logged in
  # redirects to login page if not logged in
  get '/expenses' do
    if logged_in?
      erb :'expenses/expenses'
    else
      redirect_if_not_logged_in
    end
  end

  # lets user create a expense if they are logged in
  get '/expenses/new' do
    if logged_in?
      erb :'/expenses/create_expense'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank expense
  post '/expenses' do
    if params[:description].empty? || params[:amount].empty? || params[:date].empty? || params[:category_name].empty?
      flash[:message] = "Please don't leave blank content"
      redirect to "/expenses/new"
    else
      @user = current_user
      @category = @user.categories.find_or_create_by(name:params[:category_name])
      @category.user_id = @user.id
      @expense = Expense.create(description:params[:description], amount:params[:amount], date:params[:date], category_id:@category.id, user_id:@user.id)
      redirect to "/expenses/#{@expense.id}"
    end
  end

  # displays a single expense
  get '/expenses/:id' do
    if logged_in?
      @expense = Expense.find(params[:id])
      erb :'expenses/show_expense'
    else
      redirect_if_not_logged_in
    end
  end

  # lets a user view expense edit form if they are logged in
  # does not let a user edit a expense he/she did not create
  get '/expenses/:id/edit' do
    if logged_in?
      @expense = Expense.find(params[:id])
      @category = Category.find(@expense.category_id)
      if @expense.user_id == current_user.id
        erb :'expenses/edit_expense'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user edit a text with blank content
  patch '/expenses/:id' do
    if !params[:description].empty? && !params[:amount].empty? && !params[:date].empty?
      @expense = Expense.find(params[:id])
      @expense.update(description:params[:description], amount:params[:amount], date:params[:date])
      @category = current_user.categories.find_by(name:params[:category_name])
      @expense.category_id = @category.id
      @expense.save
      flash[:message] = "Your Expense Has Been Succesfully Updated"
      redirect_to_home_page
    else
      flash[:message] = "Please Don't Leave Blank Content"
      redirect to "/expenses/#{params[:id]}/edit"
    end
  end

  # lets a user delete their own expense if they are logged in
  # does not let a user delete a expense they did not create
  delete '/expenses/:id/delete' do
    if logged_in?
      @expense = Expense.find(params[:id])
      if @expense.user_id == current_user.id
        @expense.delete
        flash[:message] = "Your expense has been deleted successfully"
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

end
