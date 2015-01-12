require 'rails_helper'

RSpec.describe ExpensesController, :type => :controller do
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
		subject {FactoryGirl.create(:expense, user: user)}

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
				expect(assigns(:expense)).to eq(subject)
			end

			it "renders the :show view" do
				get :show, id: subject
				expect(response).to render_template :show
			end
		end

		describe "GET #new" do 
			it "assigns the requested expense to new expense" do
				get :new
				expect(assigns(:expense)).to be_new_record
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
						post :create, expense: FactoryGirl.attributes_for(:expense)
					}.to change(Expense, :count).by(1)
				end

				it "rendirects to index path" do 
					post :create, expense: FactoryGirl.attributes_for(:expense)
					expect(response).to redirect_to ("/expenses/#{assigns(:expense).id}") 
				end
			end
		end

		describe "GET #edit" do
			it "assigns the requested expense to subject" do
				get :edit, id: subject
				expect(assigns(:expense)).to eq(subject)
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
						patch :update, id: subject, expense: {expense_name: "new_expense"} 
					}.to change{ subject.reload.expense_name}.to('new_expense')
				end

				it "rendirects to index path" do 
					patch :update, id: subject, expense: {expense_name: "new_expense"}
					expect(response).to redirect_to ("/expenses/#{assigns(:expense).id}")
				end
			end
		end

		describe 'DELETE #destroy' do 
			before(:each) { @expense = FactoryGirl.create :expense, user: user }

			it "deletes the expense" do 
				expect {
					delete :destroy, id: @expense
				}.to change(Expense, :count).by(-1)
			end

			it "redirects to expenses#index" do
				delete :destroy, id: @expense
				expect(response).to redirect_to :action => :index
			end
		end
	end
end
