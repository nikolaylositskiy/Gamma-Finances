class ExpensesController < ApplicationController

  before_action  :find_expense, only:[:show, :edit,:update, :destroy]

  def index
    @expenses = Expense.includes(:user).paginate(:page => params[:page], :per_page =>5)

  end

  def show

  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expenses_params)
    if @expense.save
      redirect_to @expense
    else
      render "new"
    end
  end

  def edit

  end

  def update

    if @expense.update(expenses_params)
      redirect_to @expense
    else
      render "edit"
    end
  end

  def destroy

    @expense.destroy
    redirect_to action: "index"
  end
end

private

  def find_expense
    @expense = Expense.find(params[:id])
  end

  def expenses_params
    params.require(:expense).permit(:expense_name, :expense_type, :currency)
  end
