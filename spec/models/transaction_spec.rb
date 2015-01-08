require 'rails_helper'
describe Transaction do 
	it "has valid factory" do
		expect(FactoryGirl.build(:transaction)).to be_valid 
	end
	it { is_expected.to belong_to(:expense) }
end
