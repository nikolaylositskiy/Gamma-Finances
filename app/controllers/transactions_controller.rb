class TransactionsController < ApplicationController
  
  before_action :find_expense,   only: [:new, :create, :index]
  before_action :find_transaction, only:[:show, :edit,:update, :destroy]




  def index 
    @transactions = @expense.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = @expense.transactions.new(transaction_param)
    if @transaction.save
      redirect_to expense_transactions_path(@expense)
    else
      render "new"  
    end
  end
    
  def show
      
  end


  def update
    
    if @transaction.update(params.require(:transaction).permit(:date, :sum, :reason, :traffic))
      redirect_to @transaction
    else
      render "edit"
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path
  end
  
private

  def find_expense
    @expense = Expense.find(params[:expense_id])
  end

  def find_transaction
    @transaction = Transaction.find(params[:id])
  end

 def transaction_param
    params.require(:transaction).permit(:date, :sum, :reason, :traffic)
  end
end