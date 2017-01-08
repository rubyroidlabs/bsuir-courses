class Quantifiable

  module InstanceMethods

    def total_amount
      self.expenses.collect {|expense| expense.amount}.sum
    end

    def expenses_sort_by_date
      self.expenses.sort_by {|expense| expense[:date]}.reverse
    end
  end

end
