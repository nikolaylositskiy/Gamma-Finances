class ExpensesController < ApplicationController
  def index
    @expenses = Expense.includes(:user).paginate(:page => params[:page], :per_page =>5)

  end

  def show
    @expense = Expense.find(params[:id])
    @expense_id = params[:id]
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.new(params.require(:expense).permit(:expense_name, :expense_type, :currency))
    if @expense.save
      redirect_to @expense
    else
      render "new"      
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(params.require(:expense).permit(:expense_name, :expense_type, :currency))
      redirect_to @expense
    else
      render "edit"
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to action: "index"
  end
end
