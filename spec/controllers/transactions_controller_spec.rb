require 'rails_helper'

RSpec.describe TransactionsController, :type => :controller do

  context "when user logged in" do
    let(:user) { FactoryGirl.create(:user) }
    subject { FactoryGirl.create(:wallet, user: user)}
    
    before do
      sign_in user
    end  
 
  describe "show action" do
    it "renders show template if an transaction is found" do 
      transaction = create(:transaction)
      get :show, {id: transaction.id }
      expect(response).to render_template('show')
    end

    it "showing a non-existent transaction should result in a RecordNotFound Error" do 
     transaction_id = 0
     expect { get :show, {:id => transaction_id}}.to raise_error ActiveRecord::RecordNotFound
    end  
  end

  describe "edit action" do 
    it "renders show template if an transaction is found" do 
      transaction = create(:transaction)
      get :edit, {id: transaction.id }
      expect(response).to render_template('edit')
    end

    it "edit a non-existent transaction should result in a RecordNotFound Error" do 
     transaction_id = 0
     expect { get :edit, {:id => transaction_id}}.to raise_error ActiveRecord::RecordNotFound
    end  

  end

  
  describe "create action" do
    it "renders #new form if validations fail" do
      post :create, transaction:{goal:''}
      expect(response).to redirect_to(transactions_path)
    end
  end
  
  describe "new action" do 
    it "renders 'new' template if valiadtions fail after trying
      to create an transaction" do
      post :create, transaction: { summ: "" ,goal:""}
      expect(response).to redirect_to(transactions_path)
    end
  end
  
  describe "destroy action" do
  
    it "redirects to index action when an transaction is destroyed
    successfuly" do 
      transaction = create(:transaction)
      delete :destroy, id: transaction.id
      expect(response).to redirect_to(transactions_path) 
    end

    it "deleting a non-existent transaction should result in a RecordNotFound Error" do 
    transaction_id = 0
    expect { delete :destroy, {:id => transaction_id}}.to raise_error ActiveRecord::RecordNotFound
    end  
  end

  describe "update action" do 
    before(:each) do
      @transaction = FactoryGirl.create(:transaction)
    end

    it "renders #edit form if validations fail" do
      put :update, id: @transaction.id, transaction: { goal: "" }
      expect(response).to render_template("edit")
    end

    it "redirects to transactions page" do
      put :update, id: @transaction.id, transaction: { summ: 444}
      expect(response).to redirect_to(@transaction)
    end
  end
  
  describe "index action" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end  
end
end 