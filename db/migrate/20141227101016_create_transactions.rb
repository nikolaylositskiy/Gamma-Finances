class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :date
      t.float :sum
      t.string :reason
      t.belongs_to :expense
      t.integer :traffic

      t.timestamps
    end
  end
end
