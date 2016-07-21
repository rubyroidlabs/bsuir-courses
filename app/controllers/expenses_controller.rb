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


end
