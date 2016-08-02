class Quantifiable

  module InstanceMethods

    def total_amount
      self.expenses.collect {|expense| expense.amount}.sum
    end
    
  end

end
