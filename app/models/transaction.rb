class Transaction < ActiveRecord::Base
  belongs_to :expense, class_name: Expense
end
