require 'rails_helper'
describe Expense do 
	it "has valid factory" do
		expect(FactoryGirl.build(:expense)).to be_valid 
	end
	it { is_expected.to belong_to(:user) }
	it { is_expected.to have_many(:transactions) }
end

