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


end
