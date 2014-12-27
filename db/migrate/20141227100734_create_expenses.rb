class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user
      t.string :expense_name
      t.string :expense_type
      t.string :currency

      t.timestamps
    end
  end
end
