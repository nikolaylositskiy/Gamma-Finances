class Transaction < ActiveRecord::Base
	belongs_to :expense
	
  validates :sum, numericality: { greater_than: 0 }
  validates :reason, presence: true
  validates :traffic, numericality: { greater_than: 0, less_than: 3 }
 
end