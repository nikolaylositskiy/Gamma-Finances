class Expense < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  belongs_to :user
  validates :expense_name, presence: true
  validates :expense_type, presence: true
  
end
