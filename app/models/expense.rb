class Expense < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  belongs_to :user
end
