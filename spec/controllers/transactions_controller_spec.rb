require 'rails_helper'

RSpec.describe TransactionsController, :type => :controller do

  context "when user not logged in" do 
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when user logged in" do
    let(:user) {FactoryGirl.create(:user)}
    let(:expense) {FactoryGirl.create(:expense)}
    subject {FactoryGirl.create(:transaction, expense: expense)}
    

    before do
      sign_in user
    end

    describe "GET #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested expense to subject" do
        get :show, id: subject
        expect(assigns(:transaction)).to eq(subject)
      end

      it "renders the :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do 
      it "assigns the requested expense to new expense" do
        get :new
        expect(assigns(:transaction)).to be_new_record
      end

      it "renders the :new view" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "create new object" do
          expect{
            post :create, transaction: FactoryGirl.attributes_for(:transaction)
          }.to change(Transaction, :count).by(1)
        end

        it "rendirects to index path" do 
          post :create, transaction: FactoryGirl.attributes_for(:transaction)
          expect(response).to redirect_to ("/transactions/#{assigns(:transaction).id}") 
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested expense to subject" do
        get :edit, id: subject
        expect(assigns(:transaction)).to eq(subject)
      end

      it "render the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end

    describe "PATC #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, transaction: {reason: "trusy"} 
          }.to change{ subject.reload.reason}.to('trusy')
        end

        it "rendirects to index path" do 
          patch :update, id: subject, transaction: {reason: "trusy"}
          expect(response).to redirect_to ("/transactions/#{assigns(:transaction).id}")
        end
      end
    end

    describe 'DELETE #destroy' do 
      before(:each) { @transaction = FactoryGirl.create :transaction, expense: expense }

      it "deletes the transaction" do 
        expect {
          delete :destroy, id: @transaction
        }.to change(Transaction, :count).by(-1)
      end

      it "redirects to transaction#index" do
        delete :destroy, id: @transaction
        expect(response).to redirect_to :action => :index
      end
    end

  end
end 