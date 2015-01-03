class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user, null: false
      t.string :expense_name, null: false
      t.string :expense_type, null: false
      t.string :currency, null: false

      t.timestamps
    end
  end
end
