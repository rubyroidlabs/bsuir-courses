class ExpensesController < ApplicationController

  get '/expenses' do
    if logged_in?
      @expenses = current_user.expenses.all
      erb :'expenses/expenses'
    else
      redirect_if_not_logged_in
    end
  end


end
