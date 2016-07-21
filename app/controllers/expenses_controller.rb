class ExpensesController < ApplicationController

  get '/expenses' do
    if logged_in?
      @expenses = current_user.expenses.all
      erb :'expenses/expenses'
    else
      redirect_if_not_logged_in
    end
  end

  get '/expenses/new' do
    if logged_in?
      erb :'/expenses/create_expense'
    else
      redirect_if_not_logged_in
    end
  end

  post '/expenses' do
    if params[:description].empty? || params[:amount].empty? || params[:date].empty?
      flash[:message] = "Please don't leave blank content"
      redirect to "/expenses/new"
    else
      @user = current_user
      @category = @user.categories.find {|category| category.name == params[:category_name]}
      @expense = Expense.create(description:params[:description], amount:params[:amount], date:params[:date], category_id:@category.id, user_id:@user.id)
      redirect to "/expenses/#{@expense.id}"
    end
  end

  get '/expenses/:id' do
    if logged_in?
      @expense = Expense.find(params[:id])
      erb :'expenses/show_expense'
    else
      redirect_if_not_logged_in
    end
  end

  get '/expenses/:id/edit' do
    if logged_in?
      @expense = Expense.find(params[:id])
      @category = Category.find(@expense.category_id)
      if @expense.user_id == create_user.id
        erb :'expenses/edit_expense'
      else
        redirect_to_home_page
    else
      redirect_if_not_logged_in
    end
  end

  patch 'expenses/:id' do
    if !params[:description].empty? && !params[:amount].empty? && !params[:date].empty?
      @expense = Expense.find(params[:id])
      @expense.description = params[:description]
      @expense.amount = params[:amount]
      @expense.date = params[:date]
      @category = Category.find(name:params[:category_name])
      @expense.category_id = @category_id
      @expense.save
      flash[:message] = "Your Expense Has Been Succesfully Updated"
      redirect_to_home_page
    else
      flash[:message] = "Please Don't Leave Blank Content"
      redirect to "/expenses/#{params[:id]}/edit"
    end
  end

end
