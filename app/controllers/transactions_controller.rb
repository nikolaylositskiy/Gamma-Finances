class TransactionsController < ApplicationController
  before_action  :find_transaction, only:[:show, :edit,:update, :destroy]
    
  def index 
    @transactions = Transaction.paginate(per_page: 30, page: params[:page])
  end

  def new
    @transaction = Transaction.new(expense_id: params[:expense_id])
 
  end

  def create
    @transaction = Transaction.new(fdfdparams)
    
    @transaction.save
    if @transaction.save
      redirect_to @transaction
    else
      render "new"  
    end
  end
  
  def show

  end

  def edit

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

  def find_transaction
    @transaction = Transaction.find(params[:id])
  end


  def fdfdparams
    params.require(:transaction).permit([:date, :sum, :reason, :traffic, :expenses_id, expense_id: params[:expense_id]])
  end
  
end