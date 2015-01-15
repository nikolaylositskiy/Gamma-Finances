class Transaction < ActiveRecord::Base
	belongs_to :expense
	
  validates :sum, numericality: { greater_than: 0 }
  #validates :date, format: { with: /(19|20)\d\d-((0[1-9]|1[012])-(0[1-9]|[12]\d)|(0[13-9]|1[012])-30|(0[13578]|1[02])-31)/}
  validates :reason, presence: true
  validates :traffic, numericality: { greater_than: 0, less_than: 2 }
 
end